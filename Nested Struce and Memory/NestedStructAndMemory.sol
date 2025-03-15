// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract NestedStructAndMemory{
    struct UserProfile {
        string name;
        uint age;
        bool active;
    }

    mapping (address => UserProfile) private profiles;

    function setProfiles(address _user, string calldata _name, uint _age) external {
        profiles[_user] = UserProfile(_name,_age,false);
    }

    function fetchProfile(address _user) external view returns(string memory, uint, bool){
        UserProfile memory temUser = profiles[_user];
        return (temUser.name,temUser.age,temUser.active);
    }
}