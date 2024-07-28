// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

import {Counter} from "../src/Counter.sol";
import {Utils} from "./Utils.t.sol";

import {RealDigital} from "../src/RealDigital.sol";

import {console2} from "forge-std/Script.sol";

contract BaseSetup is Utils {
    RealDigital realDigital;

    address[] users;
    address deployer;
    address charles;
    address alice;
    address bob;

    function createMockUsers(address[] memory myUsers) private {
        deployer = myUsers[2];
        charles = myUsers[3];
        alice = myUsers[0];
        bob = myUsers[1];

        vm.label(deployer, "deployer (dev)");
        vm.label(charles, "charler");
        vm.label(alice, "alice");
        vm.label(bob, "bob");
    }

    function setUp() public virtual {
        Utils utils = new Utils();
        users = utils.createUsers(6);

        createMockUsers(users);
    }
}
