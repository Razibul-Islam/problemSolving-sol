// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ArrayCopyingToStorageToMemory {
    function setNum(uint256[] calldata _data)
        external
        pure
        returns (uint256[] memory)
    {
        uint256[] memory arr = new uint256[](_data.length);

        for (uint256 i = 0; i < _data.length; i++) {
            arr[i] = _data[i] * 3;
        }

        return arr;
    }
}
