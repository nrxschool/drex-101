// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {BaseSetup} from "../../BaseSetup.t.sol";

contract TransferRealDigitalTest is BaseSetup {
    function setUp() public override {
        BaseSetup.setUp();

        // mint real digital to itau bank
    }

    function test_transfer_real_digital_between_banks() public {}

    function revert_transfer_real_digital_between_bank_and_client() public {}
}
