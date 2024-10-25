// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

import {RealDigital} from "../src/RealDigital.sol";
import {RealTokenizado} from "../src/RealTokenizado.sol";
import {Swap} from "../src/Swap/Swap.sol";
import {STR} from "../src/STR.sol";

import {Utils} from "./Utils.t.sol";
import {console2} from "forge-std/Script.sol";

contract BaseSetup is Utils {
    uint256 constant CENTAVOS = 100;

    RealTokenizado rtNubank;
    RealTokenizado rtItau;
    RealDigital rd;
    Swap swap;
    STR str;

    address itauBank = 0x70997970C51812dc3A010C7d01b50e0d17dc79C8;
    address nubankBank = 0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC;

    address[] participants = [itauBank, nubankBank];

    address[] users;
    address bacen;
    address charlesItau;
    address aliceItau;
    address bobNubank;

    function createMockUsers(address[] memory myUsers) private {
        bacen = myUsers[2];
        charlesItau = myUsers[3];
        aliceItau = myUsers[0];
        bobNubank = myUsers[1];

        vm.label(bacen, "Banco Central (deployer)");
        vm.label(charlesItau, "Charles cliente Itau");
        vm.label(aliceItau, "Alice cliente Itau");
        vm.label(bobNubank, "Bob cliente Nubank");

        vm.label(address(rtItau), "Real Tokenizado Itau");
        vm.label(address(rtNubank), "Real Tokenizado Nubank");

        vm.label(itauBank, "Banco Itau");
        vm.label(nubankBank, "Banco Nubank");
    }

    function setUp() public virtual {
        Utils utils = new Utils();
        users = utils.createUsers(6);

        createMockUsers(users);

        vm.startPrank(bacen);
        // Deploy Real Digital
        rd = new RealDigital();

        // Deploy STR and Swap contracts
        str = new STR(address(rd), participants);
        swap = new Swap(address(rd), participants);

        // Set STR and Swap on Real Digital to mint and transfer balances
        rd.setSTR(address(str));
        rd.setSwap(address(swap));

        // Deploy Real Tokenizado to Itau and Nubank
        rtItau = new RealTokenizado(itauBank, "Itau", "ITAU");
        rtNubank = new RealTokenizado(nubankBank, "Nubank", "NU");
        vm.stopPrank();

        // Itau set Swap on Real Tokenizado to transfer balances
        vm.prank(itauBank);
        rtItau.setSwap(address(swap));

        // Nubank set Swap on Real Tokenizado to transfer balances
        vm.prank(nubankBank);
        rtNubank.setSwap(address(swap));
    }
}
