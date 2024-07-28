// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {BaseSetup} from "../../BaseSetup.t.sol";

contract MintRealDigitalTest is BaseSetup {
    uint256 itauBalance;
    uint256 nubankBalance;

    function setUp() public override {
        BaseSetup.setUp();
    }

    function test_validate_zero_balance_in_init() public {
        itauBalance = rd.balanceOf(itauBank);
        nubankBalance = rd.balanceOf(nubankBank);

        assertEq(itauBalance, 0);
        assertEq(nubankBalance, 0);
    }

    function test_mint_1000_real_digital_to_itau_bank() public {
        vm.prank(itauBank);
        str.requestToMint(1000 * CENTAVOS);

        vm.prank(nubankBank);
        str.requestToMint(1000 * CENTAVOS);

        itauBalance = rd.balanceOf(itauBank);
        nubankBalance = rd.balanceOf(nubankBank);

        assertEq(itauBalance, 1000_00);
        assertEq(nubankBalance, 1000_00);
    }
}
