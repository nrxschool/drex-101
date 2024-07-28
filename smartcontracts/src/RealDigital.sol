// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {ERC20} from "./ERC20.sol";

error Unauthorized(address you, address owner);

contract RealDigital is ERC20 {
    address public bacen;
    address public swap;
    address public str;

    event Swap(address indexed from, address indexed to, uint256 amount);

    constructor() ERC20("RealDigital", "RD", 2) {
        bacen = msg.sender;
    }

    function setSTR(address _str) public onlyBacen {
        str = _str;
    }

    function setSwap(address _swap) public onlyBacen {
        swap = _swap;
    }

    modifier onlyBacen() {
        if (msg.sender != bacen) {
            revert Unauthorized(msg.sender, bacen);
        }
        _;
    }

    modifier onlySWAP() {
        if (msg.sender != swap) {
            revert Unauthorized(msg.sender, swap);
        }
        _;
    }

    modifier onlySTR(address strContract) {
        if (strContract != str) {
            revert Unauthorized(msg.sender, str);
        }
        _;
    }

    function mint(address participant, uint256 amount) external onlySTR(msg.sender) {
        _mint(participant, amount);
    }

    function burnFrom(address participant, uint256 amount) external onlySTR(msg.sender) {
        _burn(participant, amount);
    }

    function transferSWAP(address from, address to, uint256 amount) external onlySWAP {
        balanceOf[from] -= amount;

        // Cannot overflow because the sum of all user
        // balances can't exceed the max uint256 value.
        unchecked {
            balanceOf[to] += amount;
        }

        emit Swap(from, to, amount);
    }
}
