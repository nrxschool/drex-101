// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {RealDigital} from "../src/RealDigital.sol";
import {BaseSetup} from "./BaseSetup.t.sol";

contract RealDigitalTest is BaseSetup {
    function setUp() public override {
        BaseSetup.setUp();
    }

    function verify_balance_of_deployer() public {
        uint256 balance = realDigital.balanceOf(deployer);

        assertEq(balance, 1000 * 100);
    }
}

