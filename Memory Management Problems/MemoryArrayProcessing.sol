// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MemoryArrayProcessing {
    function getArray(uint256[] calldata data)
        external
        pure
        returns (uint256[] memory)
    {
        uint256[] memory arr = new uint256[](data.length);
        for (uint256 i = 0; i < data.length; i++) {
            arr[i] = data[i] * 2;
        }

        return arr;
    }
}
