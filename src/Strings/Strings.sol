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

    // brute force approach
    function patternMatching(string memory t, string memory p)
        public
        pure
        returns (bool)
    {
        uint256 n = bytes(t).length;
        uint256 m = bytes(p).length;

        for (uint256 i = 0; i < n - m; i++) {
            bytes memory tmp;
            uint256 counter = 0;
            for (uint256 j = i; j < i + m - 1; j++) {
                tmp[counter] = bytes(t)[j];
                counter++;
            }
            string memory stmp = string(tmp);
            if (strcmp(i, stmp, p) == 0) {
                return true;
            }
        }

        return false;
    }
}
