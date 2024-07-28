// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {RealDigital} from "./RealDigital.sol";

error Unauthorized(address you, address[] owners);

contract STR {
    RealDigital public realDigitalContract;
    address[] public participants;

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

    function requestToMint(uint256 amount) external onlyParticipant {
        realDigitalContract.mint(msg.sender, amount);
    }

    function requestToBurn(uint256 amount) external onlyParticipant {
        realDigitalContract.burnFrom(msg.sender, amount);
    }
}
