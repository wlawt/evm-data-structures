// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

library Math {
    // https://ethereum.stackexchange.com/questions/134302/get-first-digit-of-number
    function log10(uint256 n) public pure returns (uint256) {
        uint256 count;
        while (n != 0) {
            count++;
            n /= 10;
        }
        return count;
    }
}
