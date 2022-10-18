// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

library Strings {
    function strcmp(
        uint256 i,
        string memory t,
        string memory p
    ) public pure returns (uint256) {
        for (uint256 j = 0; j < bytes(p).length; j++) {
            if (bytes(t)[i + j] != bytes(p)[j]) {
                return 1;
            }
        }
        return 0;
    }
}
