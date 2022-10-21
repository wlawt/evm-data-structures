// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

library Strings {
    // https://ethereum.stackexchange.com/questions/31457/substring-in-solidity
    function substring(
        string memory str,
        uint256 startIndex,
        uint256 endIndex
    ) public pure returns (string memory) {
        bytes memory strBytes = bytes(str);
        bytes memory result = new bytes(endIndex - startIndex);
        for (uint256 i = startIndex; i < endIndex; i++) {
            result[i - startIndex] = strBytes[i];
        }
        return string(result);
    }

    function strcmp(
        uint256 i,
        string memory t,
        string memory p
    ) public pure returns (uint256) {
        for (uint256 j = 0; j < bytes(p).length; j++) {
            if (
                keccak256(abi.encodePacked(bytes(t)[i + j])) !=
                keccak256(abi.encodePacked(bytes(p)[j]))
            ) {
                return 1;
            }
        }
        return 0;
    }

    function simplestrcmp(string memory t, string memory p)
        public
        pure
        returns (bool)
    {
        return keccak256(bytes(t)) == keccak256(bytes(p));
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
            string memory tmp = substring(t, i, i + m - 1);
            if (strcmp(i, tmp, p) == 0) {
                return true;
            }
        }

        return false;
    }

    // KMP rolling hash patternMatching
    function kmpPatternMatching(string memory t, string memory p)
        public
        pure
        returns (bool)
    {
        //
    }
}
