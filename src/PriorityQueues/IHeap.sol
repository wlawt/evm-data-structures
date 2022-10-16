// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

interface Heap {
    function insert(uint256 n) external;

    function deleteMax() external;

    function findMax() external;
}
