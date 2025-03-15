// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract UserProfileManager {
    struct User {
        string name;
        uint256 balance;
    }

    mapping(address => User) private users; // Storage: Parmanent Data

    // Use Calldata for efficiency ( since input is not modified)
    function addUser(address _user, string calldata _name) external {
        users[_user] = User(_name, 0); // saving data parmanently in storage
    }

    // Uses Memory for temporary Processing
    function getUserInfo(address _user)
        external
        view
        returns (string memory, uint256)
    {
        User memory tempUser = users[_user];
        return (tempUser.name, tempUser.balance);
    }

    // Modifies Storage directly to update balance
    function updateBalance(address _user, uint256 _amount) external {
        users[_user].balance += _amount; // Modifies Storage directly
    }

    // Uses calldata for large array input, Process in memory
    function processBalance(uint256[] calldata amounts) external pure returns(uint256){
        uint256 totalBalance = 0;
        for(uint256 i = 0; i < amounts.length; i++){
            totalBalance += amounts[i]; // processing in memory
        }

        return totalBalance;
    }
}
