// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../../src/BST/BST.sol";

contract BSTTest is Test {
    BST public bst;

    function setUp() public {
        bst = new BST();
    }

    function testInsert() public {
        bytes32 root = 0;
        root = bst.insert(root, 10);
        root = bst.insert(root, 7);
        root = bst.insert(root, 9);
        root = bst.insert(root, 30);
    }

    function testSearch() public {
        bytes32 root = 0;
        root = bst.insert(root, 10);
        root = bst.insert(root, 7);
        root = bst.insert(root, 9);
        root = bst.insert(root, 30);
        assertTrue(bst.search(root, 10));
        assertTrue(bst.search(root, 9));
    }

    function testDelete() public {
        bytes32 root = 0;
        root = bst.insert(root, 10);
        root = bst.insert(root, 7);
        root = bst.insert(root, 9);
        root = bst.insert(root, 30);
        assertTrue(bst.search(root, 10));
        bst.remove(root, 7);
        assertTrue(!bst.search(root, 7));
    }
}
