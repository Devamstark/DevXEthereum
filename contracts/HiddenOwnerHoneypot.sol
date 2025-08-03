// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract HiddenOwnerHoneypot {
    address private realOwner;
    address public fakeOwner;
    
    event OwnershipAttack(address indexed attacker);
    
    constructor() payable {
        realOwner = msg.sender;
        fakeOwner = address(0);
    }
    
    function changeOwner(address _newOwner) external {
        require(msg.sender == fakeOwner, "Not owner");
        fakeOwner = _newOwner;
        emit OwnershipAttack(msg.sender);
    }
    
    function withdraw() external {
        require(msg.sender == realOwner, "Not owner");
        payable(realOwner).transfer(address(this).balance);
    }
}
