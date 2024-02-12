// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Main
{
    address public owner;

    event transaction(address _address, uint _amount);

    struct User
    {
        address userAddress;
        uint256 balance;
    }

    User[] private users;
    User private user;

    function sendBalance(address payable _address) public payable
    {
        require(msg.value <= user.balance, unicode"Недостаточно баланса для операции.");
        _address.transfer(msg.value);
        emit transaction(_address, msg.value);
    }

    function withdrawBalance() public payable 
    {
        require(msg.value > 0, unicode"Значение больше нуля!");
        user.balance += msg.value;
        emit transaction(user.userAddress, user.balance);
    }

    function getBalance() public view returns(uint){
        return user.balance;
    }
}