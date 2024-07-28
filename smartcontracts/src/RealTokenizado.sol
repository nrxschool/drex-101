// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {ERC20} from "./ERC20.sol";

error Unauthorized(address you, address owner);

contract RealTokenizado is ERC20 {
    address public owner;
    address public swap;

    constructor(address _owner, string memory _name, string memory _symbol) ERC20(_name, _symbol, 2) {
        owner = _owner;
    }

    function setSwap(address _swap) external onlyOwner {
        swap = _swap;
    }

    modifier onlyOwner() {
        if (msg.sender != owner) {
            revert Unauthorized(msg.sender, owner);
        }
        _;
    }

    modifier onlySwapOrOwner() {
        if (msg.sender != swap && msg.sender != owner) {
            revert Unauthorized(msg.sender, owner);
        }
        _;
    }

    function mint(address client, uint256 amount) external onlySwapOrOwner {
        _mint(client, amount);
    }

    function burn(address client, uint256 amount) external onlySwapOrOwner {
        _burn(client, amount);
    }
}
