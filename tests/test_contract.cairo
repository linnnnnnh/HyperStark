use starknet::ContractAddress;

use snforge_std::{declare, ContractClassTrait, start_cheat_caller_address, stop_cheat_caller_address};
use snforge_std::trace::{get_call_trace};

use hyperstark::ISimpleVaultSafeDispatcher;
use hyperstark::ISimpleVaultSafeDispatcherTrait;
use hyperstark::ISimpleVaultDispatcher;
use hyperstark::ISimpleVaultDispatcherTrait;

// TODO: make these global variables
fn STRK() -> felt252 {
    // STRK whale
    0x4718f5a0fc34cc1af16a1cdee98ffb20c31f5cd61d6ab07201858f4287c938d 
}

fn STRK_ADDRESS() -> ContractAddress {
    0x4718f5a0fc34cc1af16a1cdee98ffb20c31f5cd61d6ab07201858f4287c938d.try_into().unwrap()
}

fn ALICE() -> ContractAddress {
    0x0213c67ed78bc280887234fe5ed5e77272465317978ae86c25a71531d9332a2d.try_into().unwrap()
}

fn NOSTRA_ROUTER() -> felt252 {
    0x049ff5b3a7d38e2b50198f408fa8281635b5bc81ee49ab87ac36c8324c214427
}

// STRK/ETH 0.5%
fn NOSTRA_POOL() -> felt252 {
    0x01a2de9f2895ac4e6cb80c11ecc07ce8062a4ae883f64cb2b1dc6724b85e897d
}

// STRK/ETH 0.5%
fn NOSTRA_POOL_ADDRESS() -> ContractAddress {
    0x01a2de9f2895ac4e6cb80c11ecc07ce8062a4ae883f64cb2b1dc6724b85e897d.try_into().unwrap()
}

// TODO: add this to /interfaces directory
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

fn deploy_contract(name: ByteArray) -> ContractAddress {
    let mut calldata = ArrayTrait::new();
    calldata.append(STRK());
    calldata.append(NOSTRA_ROUTER());
    calldata.append(NOSTRA_POOL());

    let contract = declare(name).unwrap();
    let (contract_address, _) = contract.deploy(@calldata).unwrap();
    contract_address
}

#[test]
fn test_initalize_vault() {
    let contract_address = deploy_contract("SimpleVault");
    let dispatcher = ISimpleVaultDispatcher { contract_address };

    let total_supply_initial = dispatcher.total_supply();

    assert(total_supply_initial == 0, 'supply not zero');
}

#[test]
#[fork("MAIN_NET")]
fn test_vault_deposit() {
    let vault_address = deploy_contract("SimpleVault");
    let vault = ISimpleVaultDispatcher { contract_address: vault_address };
    let alice: ContractAddress = ALICE();
    let token = IERC20Dispatcher { contract_address: STRK_ADDRESS() };
    let pool = IERC20Dispatcher { contract_address: NOSTRA_POOL_ADDRESS() };

    let mut amount = 300000000000000000000; // TODO: fuzz
    if token.balance_of(alice) < amount {
        amount = token.balance_of(alice);
        assert(amount > 0, 'alice has no strk');
    }

    let pool_strk_before = token.balance_of(NOSTRA_POOL_ADDRESS());

    // ACT
    start_cheat_caller_address(STRK_ADDRESS(), alice);
    token.approve(vault_address, amount);

    stop_cheat_caller_address(STRK_ADDRESS());
    start_cheat_caller_address(vault_address, alice);
    let shares_minted = vault.deposit(amount);

    // ASSERT
    assert(shares_minted == amount, 'shares not 1:1 to deposit');
    assert(token.balance_of(NOSTRA_POOL_ADDRESS()) > pool_strk_before, 'pool didnt receive tokens');
    assert(pool.balance_of(vault_address) > 0, 'pool didnt add liquidity');
}
