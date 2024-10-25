// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {RealDigital} from "../RealDigital.sol";
import {RealTokenizado} from "../RealTokenizado.sol";
import {SwapEvents} from "./Swap.Events.sol";

contract SwapTwoStepsReserve {
    constructor(
        address _realDigitalContract,
        address[] memory _participants
    ) SwapEvents(_realDigitalContract, _participants) {}

    function startSwapReserveImplementation(
        address _realTokenizado1,
        address _realTokenizado2,
        address receiver,
        uint256 amount
    ) internal {
        RealTokenizado tokenSender = RealTokenizado(_realTokenizado1);
        RealTokenizado tokenReceiver = RealTokenizado(_realTokenizado2);

        realDigitalContract.transferFrom(msg.sender, address(this), amount);

        swapProposals[proposalCount] = SwapProposal({
            tokenSender: tokenSender,
            tokenReceiver: tokenReceiver,
            sender: msg.sender,
            receiver: receiver,
            amount: amount,
            status: SwapStatus.PENDING
        });

        emit SwapStarted(proposalCount, msg.sender, receiver, amount);
        proposalCount++;
    }

    function executeSwap(uint256 proposalId) internal {
        SwapProposal storage proposal = swapProposals[proposalId];

        require(
            proposal.receiver == msg.sender,
            "Only receiver can execute the swap"
        );
        require(proposal.status == SwapStatus.PENDING, "Swap is not pending");

        realDigitalContract.transferSWAP(
            address(this),
            proposal.tokenReceiver.owner(),
            proposal.amount
        );

        proposal.tokenSender.burn(proposal.sender, proposal.amount);
        proposal.tokenReceiver.mint(proposal.receiver, proposal.amount);
        proposal.status = SwapStatus.EXECUTED;

        emit SwapExecuted(
            proposalId,
            proposal.sender,
            proposal.receiver,
            proposal.amount
        );
    }

    function cancelSwap(uint256 proposalId, string memory reason) internal {
        SwapProposal storage proposal = swapProposals[proposalId];

        require(
            proposal.sender == msg.sender || proposal.receiver == msg.sender,
            "Only participants can cancel the swap"
        );
        require(proposal.status == SwapStatus.PENDING, "Swap is not pending");

        realDigitalContract.transfer(proposal.sender, proposal.amount);
        proposal.status = SwapStatus.CANCELLED;

        emit SwapCancelled(proposalId, reason);
    }
}
