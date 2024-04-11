// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {RealDigital} from "./RealDigital.sol";
import {RealTokenizado} from "./RealTokenizado.sol";

error Unauthorized(address you, address[] owners);

contract Swap {
    address[] public participants;
    RealDigital public realDigitalContract;

    constructor(address _realDigitalContract, address[] memory _participants) {
        realDigitalContract = RealDigital(_realDigitalContract);

        for (uint256 i = 0; i < _participants.length; i++) {
            participants.push(_participants[i]);
        }
    }

    modifier onlyParticipant() {
        bool isParticipant = false;
        for (uint256 i = 0; i < participants.length; i++) {
            if (msg.sender == participants[i]) {
                isParticipant = true;
                break;
            }
        }

        if (!isParticipant) {
            revert Unauthorized(msg.sender, participants);
        }
        _;
    }

    function swap(
        address _realTokenizado1,
        address _client1,
        address _realTokenizado2,
        address _client2,
        uint256 amount
    ) external onlyParticipant {
        RealTokenizado realTokenizado1 = RealTokenizado(_realTokenizado1);
        RealTokenizado realTokenizado2 = RealTokenizado(_realTokenizado2);

        // transferir Real Digital
        realDigitalContract.transferSWAP(realTokenizado1.owner(), realTokenizado2.owner(), amount);

        // transferir Real Tokenizado
        realTokenizado1.burn(_client1, amount);

        realTokenizado2.mint(_client2, amount);
    }
}
