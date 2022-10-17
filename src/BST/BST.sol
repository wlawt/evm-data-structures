// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract BST {
    struct Node {
        uint256 key;
        bytes32 left;
        bytes32 right;
    }

    mapping(bytes32 => Node) public bst;
    bytes32 public root;

    constructor() {}

    function insert(bytes32 n, uint256 k) public returns (bytes32) {
        // tree is empty
        if (bst[n].key == 0) {
            // make the node
            bst[n].key = k;
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

    function search(bytes32 n, uint256 k) public view returns (uint256) {
        if (bst[n].key == 0) {
            return 0;
        }

        if (k == bst[n].key) {
            return bst[n].key;
        }

        if (k < bst[n].key) {
            return search(bst[n].left, k);
        } else {
            return search(bst[n].right, k);
        }
    }

    function remove(bytes32 n, uint256 k) public returns (bytes32) {
        if (bst[n].key == 0) {
            return n;
        }

        if (k < bst[n].key) {
            bst[n].left = remove(bst[n].left, k);
        } else if (k > bst[n].key) {
            bst[n].right = remove(bst[n].right, k);
        } else {
            // k == bst[n].key
            if (bst[bst[n].left].key == 0) {
                bytes32 tmp = bst[n].right;
                delete bst[n];
                return tmp;
            } else if (bst[bst[n].right].key == 0) {
                bytes32 tmp = bst[n].left;
                delete bst[n];
                return tmp;
            }

            bytes32 temp = minValueNode(bst[n].right);
            bst[n].key = bst[temp].key;

            bst[n].right = remove(bst[n].right, bst[temp].key);
        }

        return n;
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
}
