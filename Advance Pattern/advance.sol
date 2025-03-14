// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract advance {
    struct userProfile {
        string name;
        uint256 balance;
        bool active;
    }

    mapping(address => userProfile) private profiles;
    address[] private userList;

    function addUser(address[] calldata _users, string[] calldata _names)
        external
    {
        require(_users.length == _names.length, "Array must be same Length");

        for (uint256 i = 0; i < _users.length; i++) {
            profiles[_users[i]] = userProfile({
                name: _names[i],
                balance: 0,
                active: true
            });

            userList.push(_users[i]);
        }
    }

    function updateBalance(uint256 amount) external {
        userProfile[] memory activeUsers = new userProfile[](userList.length);
        uint256 activeCount = 0;

        // Copying active from storage to memory
        for (uint256 i = 0; i < userList.length; i++) {
            if (profiles[userList[i]].active) {
                activeUsers[activeCount] = profiles[userList[i]];
                activeCount++;
            }
        }

        // Process in memory
        for (uint256 i = 0; i < activeCount; i++) {
            activeUsers[i].balance += amount;
        }

        // From memory to storage Update
        for (uint256 i = 0; i < activeCount; i++) {
            address userAddress = userList[i];
            if (profiles[userAddress].active) {
                profiles[userAddress].balance = activeUsers[i].balance;
            }
        }
    }

    function getActiveUsers()
        external
        view
        returns (address[] memory, string[] memory)
    {
        uint256 activeCount = 0;
        for (uint256 i = 0; i < userList.length; i++) {
            if (profiles[userList[i]].active) {
                activeCount++;
            }
        }

        address[] memory activeAddress = new address[](activeCount);
        string[] memory activeNames = new string[](activeCount);

        uint256 currentIndex = 0;
        for (uint256 i = 0; i < userList.length; i++) {
            if (profiles[userList[i]].active) {
                activeAddress[currentIndex] = userList[i];
                activeNames[currentIndex] = profiles[userList[i]].name;
                currentIndex++;
            }
        }
        return (activeAddress, activeNames);
    }

    function processLargeArray(uint256[] calldata data)
        external
        pure
        returns (uint256)
    {
        uint256 result = 0;

        for (uint256 i = 0; i < data.length; i++) {
            result += data[i];
        }

        return result;
    }
}
