// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CopyingStorageToMemory{
    mapping (address => uint256) private balances;

    function setBalance(address _user, uint256 balance) external {
        balances[_user] = balance;
    }

    function getBalance(address _user) external view returns(uint){
        uint balan = balances[_user];
        return balan;
    }
}