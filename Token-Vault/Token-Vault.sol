// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IToken {
    function CreateWallet(address add) external;
    function Diposit(address add, uint amount) external ;
    function Withdraw(address add, uint amount) external ;
    function checkBalance(address add) external view returns(uint);
}

contract Vault is IToken{
    // Mapping
    mapping (address => uint) private wallets;

    // Event Declear
    event createAccoutn(address add, uint amount ,string message);
    event DipositBalance(address add, uint amount);
    event withdrawBalance(address add, uint amount);

    // Modifier Declear
    modifier checkDeposit(address add){
        require(wallets[add] <= 0,"Deposit must be greater than zero");
        _;
    }

    modifier checkWithdraw(address add, uint amount){
        require(wallets[add] >= amount,"Insufficient balance");
        _;
    }

    // Function Declear
    function CreateWallet(address add) external override {
        wallets[add] = 0;
        emit createAccoutn(add, 0, "your account has been created");
    }

    function Diposit(address add, uint amount) external override checkDeposit(add) {
        wallets[add] += amount;
        emit DipositBalance(add, amount);
    }
    
    function Withdraw(address add, uint amount) external override {
        wallets[add] -= amount;
        emit withdrawBalance(add, amount);
    }

    function checkBalance(address add) external view returns(uint){
        return wallets[add];
    }
}
