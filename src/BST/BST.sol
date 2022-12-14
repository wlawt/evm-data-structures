// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract BST {
    struct Node {
        uint256 key;
        bytes32 left;
        bytes32 right;
    }

    mapping(bytes32 => Node) public bst;

    constructor() {}

    function insert(bytes32 n, uint256 k) public returns (bytes32) {
        // tree is empty
        if (bst[n].key == 0) {
            bst[0] = bst[n];
            n = createAddress(k, 0);
            // make the node
            bst[n].key = k;
            bst[n].left = 0;
            bst[n].right = 0;
            return n;
        }

        // traverse
        if (k < bst[n].key) {
            bst[n].left = insert(bst[n].left, k);
        } else {
            bst[n].right = insert(bst[n].right, k);
        }

        return n;
    }

    function search(bytes32 n, uint256 k) public view returns (bool) {
        if (bst[n].key == 0) {
            return false;
        }

        if (k == bst[n].key) {
            return true;
        }

        if (k < bst[n].key) {
            return search(bst[n].left, k);
        } else {
            return search(bst[n].right, k);
        }
    }

    function remove(bytes32 n, uint256 k) public {
        if (bst[n].key == 0) {
            return;
        }

        if (k < bst[n].key) {
            remove(bst[n].left, k);
        } else if (k > bst[n].key) {
            remove(bst[n].right, k);
        } else {
            // k == bst[n].key
            if (bst[bst[n].left].key == 0 || bst[bst[n].right].key == 0) {
                delete bst[n];
                return;
            }

            bytes32 temp = minValueNode(bst[n].right);
            bst[n].key = bst[temp].key;

            remove(bst[n].right, bst[temp].key);
        }

        return;
    }

    function minValueNode(bytes32 n) internal view returns (bytes32) {
        Node memory curr = bst[n];
        bytes32 addr = n;
        while (bst[curr.left].key != 0) {
            curr = bst[curr.left];
            addr = curr.left;
        }
        return addr;
    }

    function createAddress(uint256 key, bytes32 parentAddress)
        public
        view
        returns (bytes32)
    {
        return keccak256(abi.encodePacked(key, parentAddress, block.timestamp));
    }
}
