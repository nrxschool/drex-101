// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {BaseSetup} from "../../BaseSetup.t.sol";

contract NubankBankTest is BaseSetup {
    function setUp() public override {
        BaseSetup.setUp();
    }

    function test_mint_real_tokenizado_to_nubank_clients() public {}

    function test_transfer_real_tokenizado_between_nubank_clients() public {}

    function revert_transfer_real_tokenizado_between_clients_and_banks()
        public
    {}
}
