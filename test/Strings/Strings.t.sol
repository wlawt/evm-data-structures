// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../../src/Strings/Strings.sol";

contract StringsTest is Test {
    function setUp() public {}

    function testSimpleStrcmp() public {
        string memory a = "cat";
        string memory b = "cat";
        assertTrue(Strings.simplestrcmp(a, b));
    }

    function testPatternMatching() public {
        string memory a = "cat";
        string memory b = "cat";
        assertTrue(Strings.patternMatching(a, b));
    }
}
