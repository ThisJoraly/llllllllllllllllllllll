// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract second {
    struct User {
        address userAddress;
        uint256 balance;
    }
    
    mapping(address => User) private users;
    
    event transaction(address indexed user, uint256 amount);
    
    function sendBalance() external payable {
        require(msg.value > 0, unicode"Значение должно быть больше нуля.");
        
        User storage user = users[msg.sender];
        user.userAddress = msg.sender;
        user.balance += msg.value;
        
        emit transaction(msg.sender, msg.value);
    }

    function withdrawBalance(uint256 index) external payable {
        require(index > 0, unicode"Значение больше нуля!");

        users[msg.sender].balance -= index;
        payable(msg.sender).transfer(index);
        
        emit transaction(msg.sender, index);
    }
        
    function getBalance(address user) external view returns (uint) {
        return users[user].balance;
    }
    
}