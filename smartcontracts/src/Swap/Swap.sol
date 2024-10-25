// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {RealDigital} from "../RealDigital.sol";
import {SwapOneStep} from "./Swap.OneStep.sol";

error Unauthorized(address you, address[] owners);

contract Swap is SwapOneStep {
    constructor(
        address _realDigitalContract,
        address[] memory _participants
    ) SwapOneStep(_realDigitalContract, _participants) {}

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

    function swapOneStep(
        address _realTokenizado1,
        address _client1,
        address _realTokenizado2,
        address _client2,
        uint256 amount
    ) external onlyParticipant {
        swapOneStepImplementation(
            _realTokenizado1,
            _client1,
            _realTokenizado2,
            _client2,
            amount
        );
    }

    function swapTwoSteps(
        address _realTokenizado1,
        address _realTokenizado2,
        address receiver,
        uint256 amount
    ) external onlyParticipant {
        startSwapImplementation(
            _realTokenizado1,
            _realTokenizado2,
            receiver,
            amount
        );
    }

    function executeTwoSteps(uint256 proposalId) external onlyParticipant {
        executeSwapImplementation(proposalId);
    }

    function cancelTwoSteps(
        uint256 proposalId,
        string memory reason
    ) external onlyParticipant {
        cancelSwapImplementation(proposalId, reason);
    }

    function swapTwoStepsReserve(
        address _realTokenizado1,
        address _realTokenizado2,
        address receiver,
        uint256 amount
    ) external onlyParticipant {
        startSwapReserveImplementation(
            _realTokenizado1,
            _realTokenizado2,
            receiver,
            amount
        );
    }

    function executeTwoStepsReserve(
        uint256 proposalId
    ) external onlyParticipant {
        twoStepsReserveContract.executeSwap(proposalId);
    }

    function cancelTwoStepsReserve(
        uint256 proposalId,
        string memory reason
    ) external onlyParticipant {
        twoStepsReserveContract.cancelSwap(proposalId, reason);
    }
}
