// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.18;

import {Test, console} from "./../lib/forge-std/src/Test.sol";
import {B_Contributor} from "./../src/B_Contributor.sol";

contract B_ContributorTest is Test {
    address owner = makeAddr("owner");
    address blackHat = makeAddr("blackHat");

    B_Contributor contributor;

    function setUp() external {
        vm.prank(owner);
        contributor = new B_Contributor();
    }
}
