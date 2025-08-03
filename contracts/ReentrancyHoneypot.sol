// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ReentrancyHoneypot {
    mapping(address => uint256) public balances;
    
    event AttackDetected(address indexed attacker, string attackType);
    
    function deposit() external payable {
        balances[msg.sender] += msg.value;
    }
    
    function withdraw(uint256 amount) external {
        require(balances[msg.sender] >= amount, "Insufficient balance");
        (bool success, ) = msg.sender.call{value: amount}("");
        require(success, "Transfer failed");
        balances[msg.sender] -= amount;
        
        if (gasleft() > 100000) {
            emit AttackDetected(msg.sender, "Possible reentrancy");
        }
    }
}
