// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract StoreandRetrieveUserData {
    struct User {
        string name;
        uint256 balance;
    }

    // Uses Storage
    mapping(address => User) private users;

    function addUsers(address _user, string calldata _name) external {
        users[_user] = User(_name, 0);
    }

    function getUser(address _user) external view returns(string memory, uint256){
        User memory tempUser = users[_user];

        return(tempUser.name, tempUser.balance);
    }
}
