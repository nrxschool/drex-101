// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {SwapStorage} from "./Swap.Storage.sol";

contract SwapEvents is SwapStorage {
    /// Events: Swap Two Steps
    event SwapStarted(
        uint256 indexed proposalId,
        address sender,
        address receiver,
        uint256 amount
    );
    event SwapExecuted(
        uint256 indexed proposalId,
        address sender,
        address receiver,
        uint256 amount
    );
    event SwapCancelled(uint256 indexed proposalId, string reason);

    /// Events: Swap Two Steps Reserve
    event SwapReserveStarted(
        uint256 indexed proposalId,
        address sender,
        address receiver,
        uint256 amount
    );
    event SwapReserveExecuted(
        uint256 indexed proposalId,
        address sender,
        address receiver,
        uint256 amount
    );
    event SwapReserveCancelled(uint256 indexed proposalId, string reason);

    constructor(
        address _realDigitalContract,
        address[] memory _participants
    ) SwapStorage(_realDigitalContract, _participants) {}
}
