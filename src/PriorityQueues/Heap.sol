// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

// Max Heap Implementation
contract Heap {
    uint256 public size = 0;
    uint256[] public arr;
    mapping(uint256 => bool) public arrExists;

    constructor(uint256 _size) {
        arr = new uint256[](_size);
    }

    function insert(uint256 n) external {
        size++;
        uint256 l = last();
        arr[l] = n;
        arrExists[n] = true;
        fixUp(l);
    }

    function deleteMax() external returns (uint256) {
        uint256 l = last();
        uint256 r = root();

        // swap
        uint256 tmp = arr[r];
        arr[r] = arr[l];
        arr[l] = tmp;

        size--;
        fixDown(r);
        return arr[l];
    }

    function findMax() external view returns (uint256) {
        return root();
    }

    function root() internal view returns (uint256) {
        return arr[0];
    }

    function last() internal view returns (uint256) {
        return size - 1;
    }

    function parent(uint256 idx) internal view returns (uint256) {
        if (idx == 0) {
            return arr[0];
        }
        return arr[(idx - 1) / 2];
    }

    function exists(uint256 n) internal view returns (bool) {
        return arrExists[n] ? true : false;
    }

    function left(uint256 idx) internal view returns (uint256) {
        return arr[2 * idx + 1];
    }

    function right(uint256 idx) internal view returns (uint256) {
        return arr[2 * idx + 2];
    }

    function checkBounds(uint256 idx) internal view returns (bool) {
        if (idx == 0) {
            return arr[0] < arr[idx];
        }
        return arr[(idx - 1) / 2] < arr[idx];
    }

    function fixUp(uint256 idx) internal {
        while (exists(parent(idx)) && checkBounds(idx)) {
            // swap
            uint256 tmp = arr[idx];
            arr[idx] = arr[(idx - 1) / 2];
            arr[(idx - 1) / 2] = tmp;
            idx = (idx - 1) / 2;
        }
    }

    function fixDown(uint256 i) internal {
        while (exists(left(i)) && exists(right(i))) {
            uint256 j = left(i);
            if (exists(right(i)) && arr[right(i)] > arr[j]) {
                j = right(i);
            }

            if (arr[i] >= arr[j]) break;

            // swap
            uint256 tmp = arr[i];
            arr[i] = arr[j];
            arr[j] = tmp;
            i = j;
        }
    }
}
