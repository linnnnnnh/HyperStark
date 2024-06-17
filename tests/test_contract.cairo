use starknet::ContractAddress;

use snforge_std::{declare, ContractClassTrait, start_cheat_caller_address, stop_cheat_caller_address};

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

    let amount = token.balance_of(alice);
    assert(amount > 0, 'alice has no strk');

    start_cheat_caller_address(STRK_ADDRESS(), alice);
    token.approve(vault_address, amount);

    stop_cheat_caller_address(STRK_ADDRESS());
    start_cheat_caller_address(vault_address, alice);
    let shares_minted = vault.deposit(amount);

    assert(shares_minted == amount, 'shares not 1:1 to deposit');
    assert(token.balance_of(vault_address) == amount, 'vault didnt receive tokens');
}
