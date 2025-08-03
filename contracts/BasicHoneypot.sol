// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BasicHoneypot {
    address private owner;
    mapping(address => uint256) public balances;
    
    event AttackAttempt(address indexed attacker, uint256 amount, uint256 timestamp);
    
    constructor() payable {
        owner = msg.sender;
    }
    
    function withdraw(uint256 amount) public {
        require(balances[msg.sender] >= amount, "Insufficient balance");
        (bool success, ) = msg.sender.call{value: amount}("");
        require(success, "Transfer failed");
        balances[msg.sender] -= amount;
    }
    
    function deposit() public payable {
        require(msg.sender == owner, "Not owner");
        balances[msg.sender] += msg.value;
    }
}
