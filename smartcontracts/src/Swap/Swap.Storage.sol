// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {RealDigital} from "../RealDigital.sol";
import {RealTokenizado} from "../RealTokenizado.sol";

contract SwapStorage {
    address[] public participants;
    RealDigital public realDigitalContract;

    uint256 public proposalReserveCount;
    uint256 public proposalCount;

    mapping(uint256 => SwapReserveProposal) public swapReserveProposals;

    struct SwapReserveProposal {
        RealTokenizado tokenSender;
        RealTokenizado tokenReceiver;
        address sender;
        address receiver;
        uint256 amount;
        SwapStatus status;
    }

    enum SwapReserveStatus {
        PENDING,
        EXECUTED,
        CANCELLED
    }

    struct SwapProposal {
        RealTokenizado tokenSender;
        RealTokenizado tokenReceiver;
        address sender;
        address receiver;
        uint256 amount;
        SwapStatus status;
    }

    enum SwapStatus {
        PENDING,
        EXECUTED,
        CANCELLED
    }

    mapping(uint256 => SwapProposal) public swapProposals;

    constructor(address _realDigitalContract, address[] memory _participants) {
        realDigitalContract = RealDigital(_realDigitalContract);

        for (uint256 i = 0; i < _participants.length; i++) {
            participants.push(_participants[i]);
        }
    }
}
