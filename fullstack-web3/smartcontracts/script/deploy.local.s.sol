// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.18;

import {Script, console2} from "forge-std/Script.sol";
import {Counter} from "../src/Counter.sol";
import {RealDigital} from "../src/RealDigital.sol";
import {RealTokenizado} from "../src/RealTokenizado.sol";
import {STR} from "../src/STR.sol";
import {Swap} from "../src/Swap.sol";

contract Local is Script {
    RealDigital rd;
    RealTokenizado rtItau;
    RealTokenizado rtNubank;
    STR str;
    Swap swap;
    address ownerItau = 0x70997970C51812dc3A010C7d01b50e0d17dc79C8;
    address ownerNubank = 0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC;
    address[] owners = [ownerItau, ownerNubank];

    function setUp() public {}

    function run() public {
        // private key BACEN
        vm.startBroadcast(0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80);

        rd = new RealDigital();
        str = new STR(address(rd), owners);
        swap = new Swap(address(rd), owners);

        rd.setSTR(address(str));
        rd.setSwap(address(swap));

        rtItau = new RealTokenizado(ownerItau, "Itau", "ITAU");
        rtNubank = new RealTokenizado(ownerNubank, "Nubank", "NU");
        vm.stopBroadcast();

        // private key ITAU
        vm.startBroadcast(0x59c6995e998f97a5a0044966f0945389dc9e86dae88c7a8412f4603b6b78690d);
        rtItau.setSwap(address(swap));
        vm.stopBroadcast();

        // private key NUBANK
        vm.startBroadcast(0x5de4111afa1a4b94908f83103eb1f1706367c2e68ca870fc3fb9a804cdab365a);
        rtNubank.setSwap(address(swap));
        vm.stopBroadcast();

        console2.log("STR:                    ", address(str));
        console2.log("SWAP:                   ", address(swap));
        console2.log("Real Digital:           ", address(rd));
        console2.log("Real Tokenizado ITAU:   ", address(rtItau));
        console2.log("Real Tokenizado Nubank: ", address(rtNubank));
    }
}
