// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract EfficientStringHandling{
    function getData(string calldata data) external pure returns(string memory){
        return string(abi.encodePacked(data)); // convert calldata to memory
    }
}