use starknet::ContractAddress;

use snforge_std::{declare, ContractClassTrait};

use hyperstark::ISimpleVaultSafeDispatcher;
use hyperstark::ISimpleVaultSafeDispatcherTrait;
use hyperstark::ISimpleVaultDispatcher;
use hyperstark::ISimpleVaultDispatcherTrait;

fn deploy_contract(name: ByteArray) -> ContractAddress {
    let STRK: felt252 = 0x01a2de9f2895ac4e6cb80c11ecc07ce8062a4ae883f64cb2b1dc6724b85e897d;
    let mut calldata = ArrayTrait::new();
    calldata.append(STRK);

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
