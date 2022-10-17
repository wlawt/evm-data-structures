// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../../src/BST/BST.sol";

contract BSTTest is Test {
    BST public bst;

    function setUp() public {
        bst = new BST();
    }
}
