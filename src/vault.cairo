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
    fn total_supply(self: @TContractState) -> u256;
    fn token(self: @TContractState) -> felt252;
    fn harvest(ref self: TContractState, account: ContractAddress, amount: u128, proof: Array<felt252>);
    fn only_owner(self: @TContractState);
    fn is_owner(self: @TContractState) -> bool;
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
    fn total_supply(self: @TContractState) -> u256;
    fn get_reserves(self: @TContractState) -> (u256, u256);
}

#[starknet::interface]
pub trait INostraClaimer<TContractState> {
    fn claim(ref self: TContractState, amount: u128, proof: Array<felt252>);
}

// https://starknet-by-example.voyager.online/applications/simple_vault.html
#[starknet::contract]
pub mod SimpleVault {
    use super::{IERC20Dispatcher, IERC20DispatcherTrait};
    use super::{INostraRouterDispatcher, INostraRouterDispatcherTrait};
    use super::{INostraPoolDispatcher, INostraPoolDispatcherTrait};
    use super::{INostraClaimerDispatcher, INostraClaimerDispatcherTrait};
    use starknet::{ContractAddress, get_caller_address, get_contract_address, get_block_timestamp};

    const pool_address: felt252 = 0x01a2de9f2895ac4e6cb80c11ecc07ce8062a4ae883f64cb2b1dc6724b85e897d;

    #[storage]
    struct Storage {
        token: IERC20Dispatcher,
        pool: INostraPoolDispatcher,
        router: INostraRouterDispatcher,
        claimer: INostraClaimerDispatcher, 
        total_supply: u256,
        // Vault share of the user 
        vault_shares_of: LegacyMap<ContractAddress, u256>,
        // Role 'owner': only one address
        owner: ContractAddress,
    }

    #[constructor]
    fn constructor(ref self: ContractState, token: ContractAddress, router: ContractAddress, pool: ContractAddress, claimer: ContractAddress) {
        self.token.write(IERC20Dispatcher { contract_address: token });
        self.router.write(INostraRouterDispatcher { contract_address: router });
        self.pool.write(INostraPoolDispatcher { contract_address: pool });
        self.claimer.write(INostraClaimerDispatcher { contract_address: claimer});

        let MAX_INT = 115792089237316195423570985008687907853269984665640564039457584007913129639935;
        let token_1 = IERC20Dispatcher { contract_address: self.pool.read().token_1() };
        token_1.approve(router, MAX_INT);
        self.token.read().approve(router, MAX_INT);
        self.pool.read().approve(router, MAX_INT);
        self.owner.write(get_caller_address());
    }

    // Events 
    #[event]
    #[derive(Drop, starknet::Event)]
    enum Event {
        Deposited: Deposited,
        Withdrawn: Withdrawn,
        Harvested: Harvested,
    }

    #[derive(Drop, starknet::Event)]
    struct Deposited {
        #[key]
        sender: ContractAddress,
        lpAmount: u256,
        shares: u256
    }
    #[derive(Drop, starknet::Event)]
    struct Withdrawn {
        #[key]
        receiver: ContractAddress,
        withdrawn_amount: u256
    }
    #[derive(Drop, starknet::Event)]
    struct Harvested {
        #[key]
        user: ContractAddress,
        reinvested_rewards: u256
    }

    // The vault is an ERC20 token 
    #[generate_trait]
    impl PrivateFunctions of PrivateFunctionsTrait {
        fn _mint(ref self: ContractState, to: ContractAddress, shares: u256) {
            self.total_supply.write(self.total_supply.read() + shares);
            self.vault_shares_of.write(to, self.vault_shares_of.read(to) + shares);
        }

        fn _burn(ref self: ContractState, from: ContractAddress, shares: u256) {
            self.total_supply.write(self.total_supply.read() - shares);
            self.vault_shares_of.write(from, self.vault_shares_of.read(from) - shares);
        }
    }

    #[abi(embed_v0)]
    impl SimpleVault of super::ISimpleVault<ContractState> {
        #[inline(always)]
        fn only_owner(self: @ContractState) {
            assert!(SimpleVault::is_owner(self), "Not owner");
        }
        #[inline(always)]
        fn is_owner(self: @ContractState) -> bool {
            self.owner.read() == get_caller_address()
        }

        fn deposit(ref self: ContractState, amount: u256) -> u256 {
            let caller = get_caller_address();
            let this = get_contract_address();

            // Calculate the shares given the amount deposited
            let mut shares = 0;
            if self.total_supply.read() == 0 {
                shares = amount;
            } else {
                let balance = self.pool.read().balance_of(this);
                shares = (amount * self.total_supply.read()) / balance;
            }

            // Transfer the deposited STRK from user to vault  
            self.token.read().transfer_from(caller, this, amount);
            // Calculate the equivalent ETH given the 1/2 of STRK  
            let token1_amount = self.pool.read().out_given_in((amount / 2), true); 

            // Transfer 1/2 of STRK to the pool
            self.token.read().transfer(pool_address.try_into().unwrap(), amount / 2);

            // Swap from STRK to "token1_amount" of ETH 
            self.pool.read().swap(
                0,
                token1_amount,
                this,
                ArrayTrait::new()
            );

            let token_1 = IERC20Dispatcher { contract_address: self.pool.read().token_1() };

            // Slippage=((Executed Price − Expected Price)/Expected Price) × 100

            // Add 1/2 of STRK and the swapped ETH from vault to pool, lp_out stays in the vault
            let (_actual_in_0, _actual_in_1, lp_out) = self.router.read().add_liquidity(
                pool_address.try_into().unwrap(),
                amount / 2, 
                token_1.balance_of(this), // balance in ETH of this contract that represents in the pool
                0, // TODO: add slippage,
                0, // TODO: add slippage,
                this, // vault
                get_block_timestamp() + 1000
            );

            // Question: what to do with (amount_in - actual_in)?

            // Mint the shares to the user 
            PrivateFunctions::_mint(ref self, caller, shares); 

            self.emit(Deposited { sender: caller, lpAmount: lp_out, shares: shares });

            shares
       }

        fn withdraw(ref self: ContractState, shares: u256) -> u256 {
            let caller = get_caller_address();
            let this = get_contract_address();

            let balance = self.pool.read().balance_of(this); 
            // Calculate the corresponding amount from shares
            let amount = (shares * balance) / self.total_supply.read(); 
            PrivateFunctions::_burn(ref self, caller, shares);

            // Remove the liquidity from pool to vault 
            let (token_0_out, token_1_out) = self.router.read().remove_liquidity(
                pool_address.try_into().unwrap(),
                amount, // liquidity 
                0, // TODO: add slippage,
                0, // TODO: add slippage,
                this, 
                get_block_timestamp() + 1000
            );

            // Get balance before swap of STRK 
            let token_0_balance_before = self.token.read().balance_of(this);

            // Calculate the equivalent STRK given the number of ETH, token_1_out
            let token_0_amount = self.pool.read().out_given_in(token_1_out, false); 

            let token_1 = IERC20Dispatcher { contract_address: self.pool.read().token_1() };

            // Transfer the ETH to pool for swap
            token_1.transfer(pool_address.try_into().unwrap(), token_1_out);

            // swap token1(ETH) for token0(STRK)
            self.pool.read().swap(
                token_0_amount,
                0, // TODO: add slippage
                this,
                ArrayTrait::new()
            );

            // STRK receive = Balance after swap - balance before swap
            let token_0_received = self.token.read().balance_of(this) - token_0_balance_before;
            // Total amount of STRK to withdraw
            let token_0_to_withdraw = token_0_received + token_0_out;

            self.token.read().transfer(caller, token_0_to_withdraw);

            self.emit(Withdrawn { receiver: caller, withdrawn_amount: token_0_to_withdraw });

            token_0_to_withdraw
        }

        
        fn harvest(ref self: ContractState, account: ContractAddress, amount: u128, proof: Array<felt252>) {
            
            // Claim the rewards 
            self.claimer.read().claim(amount, proof);
            
            // Reinvest the corresponding rewards to the pool
            let amount_u256: u256 = amount.try_into().unwrap();

            self.deposit(amount_u256);

            self.emit(Harvested { user: account, reinvested_rewards: amount_u256 });                
        }

        fn total_supply(self: @ContractState) -> u256 {
            self.total_supply.read()
        }
        
        fn token(self: @ContractState) -> felt252 {
            self.token.read().name() // Question: what is the name? should be added
        }
    }
}
