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
        assertTrue(Strings.simplestrcmp("a", "a"));
    }

    function testPatternMatching() public {
        string memory a = "abbbababbab";
        string memory b = "abba";
        assertTrue(Strings.patternMatching(a, b));
    }

    function testKMPSimple() public {
        string memory a = "abbbababbab";
        string memory b = "abba";
        assertTrue(Strings.kmpSimple(a, b));
    }
}
