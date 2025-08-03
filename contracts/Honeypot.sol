// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./BasicHoneypot.sol";
import "./ReentrancyHoneypot.sol";
import "./HiddenOwnerHoneypot.sol";

contract HoneypotFactory {
    enum HoneypotType { Basic, Reentrancy, HiddenOwner }
    
    event HoneypotCreated(address indexed contractAddress, HoneypotType hType);
    
    function createHoneypot(HoneypotType _type) external payable returns (address) {
        address newContract;
        
        if (_type == HoneypotType.Basic) {
            newContract = address(new BasicHoneypot{value: msg.value}());
        } 
        else if (_type == HoneypotType.Reentrancy) {
            newContract = address(new ReentrancyHoneypot{value: msg.value}());
        }
        else if (_type == HoneypotType.HiddenOwner) {
            newContract = address(new HiddenOwnerHoneypot{value: msg.value}());
        }
        
        emit HoneypotCreated(newContract, _type);
        return newContract;
    }
}
