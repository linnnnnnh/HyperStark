use starknet::ContractAddress;

// TODO: use OZ
#[starknet::interface]
pub trait IERC20<TContractState> {
    fn name(self: @TContractState) -> felt252;
    fn symbol(self: @TContractState) -> felt252;
    fn decimals(self: @TContractState) -> u8;
    fn total_supply(self: @TContractState) -> u256;
    fn balance_of(self: @TContractState, account: ContractAddress) -> u256;
    fn allowance(self: @TContractState, owner: ContractAddress, spender: ContractAddress) -> u256;
    fn transfer(ref self: TContractState, recipient: ContractAddress, amount: u256) -> bool;
    fn transfer_from(
        ref self: TContractState, sender: ContractAddress, recipient: ContractAddress, amount: u256
    ) -> bool;
    fn approve(ref self: TContractState, spender: ContractAddress, amount: u256) -> bool;
}

#[starknet::interface]
pub trait ISimpleVault<TContractState> {
    fn deposit(ref self: TContractState, amount: u256) -> u256;
    fn withdraw(ref self: TContractState, shares: u256) -> u256;
    fn total_supply(ref self: TContractState) -> u256;
    fn token(ref self: TContractState) -> felt252;
}

#[starknet::interface]
pub trait INostraRouter<TContractState> {
    fn add_liquidity(
        ref self: TContractState,
        pair: ContractAddress,
        amount_0_desired: u256,
        amount_1_desired: u256,
        amount_0_min: u256,
        amount_1_min: u256,
        to: ContractAddress,
        deadline: u64,
    ) -> (u256, u256, u256);
    fn remove_liquidity(
        ref self: TContractState,
        pair: ContractAddress,
        liquidity: u256,
        amount_0_min: u256,
        amount_1_min: u256,
        to: ContractAddress,
        deadline: u64,
    ) -> (u256, u256);
}

#[starknet::interface]
pub trait INostraPool<TContractState> {
    fn swap(
        ref self: TContractState,
        amount_0_out: u256,
        amount_1_out: u256,
        to: ContractAddress,
        data: Array<felt252>,
    );
    fn out_given_in(
        ref self: TContractState,
        amount_out: u256,
        first_token_in: bool,
    ) -> u256;
    fn token_0(ref self: TContractState) -> ContractAddress;
    fn token_1(ref self: TContractState) -> ContractAddress;
    fn transfer(ref self: TContractState, recipient: ContractAddress, amount: u256) -> bool;
    fn approve(ref self: TContractState, spender: ContractAddress, amount: u256) -> bool;
    fn balance_of(self: @TContractState, account: ContractAddress) -> u256;
}

// https://starknet-by-example.voyager.online/applications/simple_vault.html
#[starknet::contract]
pub mod SimpleVault {
    use super::{IERC20Dispatcher, IERC20DispatcherTrait};
    use super::{INostraRouterDispatcher, INostraRouterDispatcherTrait};
    use super::{INostraPoolDispatcher, INostraPoolDispatcherTrait};
    use starknet::{ContractAddress, get_caller_address, get_contract_address, get_block_timestamp};

    const pool_address: felt252 = 0x01a2de9f2895ac4e6cb80c11ecc07ce8062a4ae883f64cb2b1dc6724b85e897d;

    #[storage]
    struct Storage {
        token: IERC20Dispatcher,
        pool: INostraPoolDispatcher,
        router: INostraRouterDispatcher,
        total_supply: u256,
        balance_of: LegacyMap<ContractAddress, u256>,
    }

    #[constructor]
    fn constructor(ref self: ContractState, token: ContractAddress, router: ContractAddress, pool: ContractAddress) {
        self.token.write(IERC20Dispatcher { contract_address: token });
        self.router.write(INostraRouterDispatcher { contract_address: router });
        self.pool.write(INostraPoolDispatcher { contract_address: pool });

        let MAX_INT = 115792089237316195423570985008687907853269984665640564039457584007913129639935;
        let token_1 = IERC20Dispatcher { contract_address: self.pool.read().token_1() };
        token_1.approve(router, MAX_INT);
        self.token.read().approve(router, MAX_INT);
        self.pool.read().approve(router, MAX_INT);
    }

    #[event]
    #[derive(Drop, starknet::Event)]
    enum Event {
        LpOut: LpOut,
    }

    #[derive(Drop, starknet::Event)]
    struct LpOut {
        #[key]
        out: u256,
    }

    #[generate_trait]
    impl PrivateFunctions of PrivateFunctionsTrait {
        fn _mint(ref self: ContractState, to: ContractAddress, shares: u256) {
            self.total_supply.write(self.total_supply.read() + shares);
            self.balance_of.write(to, self.balance_of.read(to) + shares);
        }

        fn _burn(ref self: ContractState, from: ContractAddress, shares: u256) {
            self.total_supply.write(self.total_supply.read() - shares);
            self.balance_of.write(from, self.balance_of.read(from) - shares);
        }
    }

    #[abi(embed_v0)]
    impl SimpleVault of super::ISimpleVault<ContractState> {
        fn deposit(ref self: ContractState, amount: u256) -> u256 {
            let caller = get_caller_address();
            let this = get_contract_address();

            let mut shares = 0;
            if self.total_supply.read() == 0 {
                shares = amount;
            } else {
                let balance = self.pool.read().balance_of(this);
                shares = (amount * self.total_supply.read()) / balance;
            }

            self.token.read().transfer_from(caller, this, amount);

            let token1_amount = self.pool.read().out_given_in((amount / 2), true);

            self.token.read().transfer(pool_address.try_into().unwrap(), amount / 2);

            self.pool.read().swap(
                0,
                token1_amount,
                this,
                ArrayTrait::new()
            );

            let token_1 = IERC20Dispatcher { contract_address: self.pool.read().token_1() };

            // Slippage=((Executed Price − Expected Price)/Expected Price) × 100

            let (_actual_in_0, _actual_in_1, lp_out) = self.router.read().add_liquidity(
                pool_address.try_into().unwrap(),
                amount / 2,
                token_1.balance_of(this),
                0, // TODO: add slippage,
                0, // TODO: add slippage,
                this,
                get_block_timestamp() + 1000
            );

            // what to do with (amount_in - actual_in)?

            self.emit(LpOut { out: lp_out });

            PrivateFunctions::_mint(ref self, caller, shares);

            shares
        }

        fn withdraw(ref self: ContractState, shares: u256) -> u256 {
            let caller = get_caller_address();
            let this = get_contract_address();

            let balance = self.pool.read().balance_of(this);
            let amount = (shares * balance) / self.total_supply.read();
            PrivateFunctions::_burn(ref self, caller, shares);

            let (token_0_out, token_1_out) = self.router.read().remove_liquidity(
                pool_address.try_into().unwrap(),
                amount,
                0, // TODO: add slippage,
                0, // TODO: add slippage,
                this,
                get_block_timestamp() + 1000
            );

            // swap token1 for token0
            let token_0_balance_before = self.token.read().balance_of(this);

            let token_0_amount = self.pool.read().out_given_in(token_1_out, false);
            let token_1 = IERC20Dispatcher { contract_address: self.pool.read().token_1() };
            token_1.transfer(pool_address.try_into().unwrap(), token_1_out);
            self.pool.read().swap(
                token_0_amount,
                0, // TODO: add slippage
                this,
                ArrayTrait::new()
            );

            let token_0_received = self.token.read().balance_of(this) - token_0_balance_before;
            let token_0_to_withdraw = token_0_received + token_0_out;

            self.token.read().transfer(caller, token_0_to_withdraw);

            token_0_to_withdraw
        }

        fn total_supply(ref self: ContractState) -> u256 {
            self.total_supply.read()
        }

        fn token(ref self: ContractState) -> felt252 {
            self.token.read().name()
        }
    }
}
