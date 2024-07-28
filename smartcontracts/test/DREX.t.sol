// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {BaseSetup} from "./BaseSetup.t.sol";
import {RealDigital} from "../src/RealDigital.sol";
import {RealTokenizado} from "../src/RealTokenizado.sol";
import {STR} from "../src/STR.sol";
import {Swap} from "../src/Swap.sol";

contract DrexTes is BaseSetup {
    RealDigital rd;
    RealTokenizado rtItau;
    RealTokenizado rtNubank;
    STR str;
    Swap swap;

    address itauBank = 0x70997970C51812dc3A010C7d01b50e0d17dc79C8;
    address itauGil = 0xd0Ceb785f297E32c1F0D24067Ec08434e27E92cf;
    address itauFe = 0x90F79bf6EB2c4f870365E785982E1f101E93b906;

    address nubankAndre = 0x15d34AAf54267DB7D7c367839AAf71A00a2C6A65;
    address nubankBank = 0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC;

    address[] owners = [itauBank, nubankBank];

    function setUp() public override {
        BaseSetup.setUp();

        vm.label(address(rtItau), "rtItau");
        vm.label(address(rtNubank), "rtNubank");

        vm.label(itauBank, "itauBank");
        vm.label(nubankBank, "nubankBank");

        vm.label(itauGil, "itauGil");
        vm.label(itauFe, "itauFe");
        vm.label(nubankAndre, "nubankAndre");

        vm.startPrank(deployer);
        rd = new RealDigital();
        str = new STR(address(rd), owners);
        swap = new Swap(address(rd), owners);

        rd.setSTR(address(str));
        rd.setSwap(address(swap));

        rtItau = new RealTokenizado(itauBank, "Itau", "ITAU");
        rtNubank = new RealTokenizado(nubankBank, "Nubank", "NU");
        vm.stopPrank();

        vm.prank(itauBank);
        rtItau.setSwap(address(swap));

        vm.prank(nubankBank);
        rtNubank.setSwap(address(swap));
    }

    function test_drex() public {
        // validar mint para bank1 usando `STR::requestToMint(bank1)`
        // assertEq(rd.balanceOf(itauBank), 0);
        // vm.prank(itauBank);
        // str.requestToMint(100 * 100);
        // assertEq(rd.balanceOf(itauBank), 100 * 100);

        // vm.prank(itauBank);
        // str.requestToBurn(100 * 100);
        // assertEq(rd.balanceOf(itauBank), 0);

        // validar mint para bank2 usando `STR::requestToMint(bank2)`
        // assertEq(rd.balanceOf(nubankBank), 0);
        // vm.prank(nubankBank);
        // str.requestToMint(100 * 100);
        // assertEq(rd.balanceOf(nubankBank), 100 * 100);

        // vm.prank(nubankBank);
        // str.requestToBurn(100 * 100);
        // assertEq(rd.balanceOf(nubankBank), 0);

        // validar mint para client1 usando `RT1::mint(client1, amount)`
        // assertEq(rtItau.balanceOf(itauGil), 0);
        // vm.prank(itauBank);
        // rtItau.mint(itauGil, 100 * 100);
        // assertEq(rtItau.balanceOf(itauGil), 100 * 100);

        // validar transferencia entre client1 e client2
        // assertEq(rtItau.balanceOf(itauFe), 0);
        // vm.prank(itauGil);
        // rtItau.transfer(itauFe, 100 * 100);
        // assertEq(rtItau.balanceOf(itauFe), 100 * 100);

        // validar mint para client2 usando `RT2::mint(client2, amount)`
        // assertEq(rtNubank.balanceOf(nubankAndre), 0);
        // vm.prank(nubankBank);
        // rtNubank.mint(nubankAndre, 101 * 100);
        // assertEq(rtNubank.balanceOf(nubankAndre), 101 * 100);

        // Validar swap usando `SWAP::swap(RD, RT1, client1, RT2, client2, amount)`
        // 1 - mint RD para o Itau
        vm.prank(itauBank);
        str.requestToMint(100 * 100);
        // 2 - mint RT-ITAU para o Gil
        vm.prank(itauBank);
        rtItau.mint(itauGil, 100 * 100);
        // 3 - swap do Gil (itau) para o Fe (nubank)

        vm.prank(itauBank);
        swap.swap(
            address(rtItau),
            itauGil,
            address(rtNubank),
            nubankAndre,
            100 * 100
        );

        // validar saldo final do itauOwer
        assertEq(rd.balanceOf(itauBank), 0);
        // validar saldo final do nubankOwer
        assertEq(rd.balanceOf(nubankBank), 100 * 100);

        // validar saldo final do itauGil
        assertEq(rtItau.balanceOf(itauGil), 0);
        // validar saldo final do nubankAndre
        assertEq(rtNubank.balanceOf(nubankAndre), 100 * 100);
    }
}
