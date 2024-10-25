// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {RealTokenizado} from "../RealTokenizado.sol";
import {RealDigital} from "../RealDigital.sol";
import {SwapTwoSteps} from "./Swap.TwoSteps.sol";

contract SwapOneStep is SwapTwoSteps {
    constructor(
        address _realDigitalContract,
        address[] memory _participants
    ) SwapTwoSteps(_realDigitalContract, _participants) {}

    function swapOneStepImplementation(
        RealDigital realDigitalContract,
        address _realTokenizado1,
        address _client1,
        address _realTokenizado2,
        address _client2,
        uint256 amount
    ) internal {
        RealTokenizado realTokenizado1 = RealTokenizado(_realTokenizado1);
        RealTokenizado realTokenizado2 = RealTokenizado(_realTokenizado2);

        // transferir Real Digital
        realDigitalContract.transferSWAP(
            realTokenizado1.owner(),
            realTokenizado2.owner(),
            amount
        );

        // transferir Real Tokenizado
        realTokenizado1.burn(_client1, amount);
        realTokenizado2.mint(_client2, amount);
    }
}
