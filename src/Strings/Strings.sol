// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "../Math/Math.sol";

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

    function strcmp(string memory t, string memory p)
        public
        pure
        returns (uint256)
    {
        for (uint256 j = 0; j < bytes(p).length - 1; j++) {
            if (
                keccak256(bytes(substring(t, j, j + 1))) !=
                keccak256(bytes(substring(p, j, j + 1)))
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
            if (strcmp(tmp, p) == 0) {
                return true;
            }
        }

        return false;
    }

    // Karp-Rabin simple hash patternMatching
    function karpRabinSimple(string memory t, string memory p)
        public
        pure
        returns (bool)
    {
        uint256 hP = uint256(keccak256(abi.encodePacked(bytes(p))));
        uint256 n = bytes(t).length;
        uint256 m = bytes(p).length;
        for (uint256 i = 0; i < n - m; i++) {
            string memory substrT = substring(t, i, i + m); // [i, i+m-1]
            uint256 hT = uint256(keccak256(abi.encodePacked(bytes(substrT))));
            if (hP == hT) {
                if (strcmp(substrT, p) == 0) {
                    return true;
                }
            }
        }

        return false;
    }

    // Karp-Rabin rolling hash
    function karpRabinRollingHash(string memory t, string memory p)
        public
        pure
        returns (bool)
    {
        uint256 M = 101; // {2, ... , mn^2}
        uint256 hP = uint256(keccak256(abi.encodePacked(bytes(p))));
        uint256 hT = uint256(keccak256(abi.encodePacked(bytes(t))));

        uint256 n = bytes(t).length;
        uint256 m = bytes(p).length;
        uint256 s = (10**(m - 1)) % M;

        for (uint256 i = 0; i < n - m; i++) {
            if (hT == hP) {
                string memory substrT = substring(t, i, i + m);
                if (strcmp(substrT, p) == 0) {
                    return true;
                }
            }

            if (i < n - m) {
                // compute next hash value guess
                // uint256 T_i = hT % s;
                uint256 len = Math.log10(hT);
                uint256 T_i = hT / (10**(len - 1));
                uint256 T_im = hT % 10;
                hT = ((hT - T_i * s) * 10 + T_im) % M;
            }
        }

        return false;
    }

    // faliure array
    function kmpFailureArray(string memory p)
        public
        returns (uint256[] memory)
    {
        uint256[] memory failureArr;
        failureArr[0] = 0;

        uint256 j = 1;
        uint256 l = 0;
        uint256 m = bytes(p).length;

        while (j < m) {
            string memory P_j = substring(p, j, j + 1);
            string memory P_l = substring(p, l, l + 1);
            if (simplestrcmp(P_j, P_l)) {
                l++;
                failureArr[j] = l;
                j++;
            } else if (l > 0) {
                l = failureArr[l - 1];
            } else {
                failureArr[j] = 0;
                j++;
            }
        }

        return failureArr;
    }
}
