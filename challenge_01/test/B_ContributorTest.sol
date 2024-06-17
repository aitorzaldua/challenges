// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.18;

import {Test, console} from "./../lib/forge-std/src/Test.sol";
import {B_Contributor} from "./../src/B_Contributor.sol";

contract B_ContributorTest is Test {
    address owner = makeAddr("owner");
    address user = makeAddr("user");
    address blackHat = makeAddr("blackHat");

    B_Contributor contributor;

    function setUp() external {
        // users only have 1 ether.
        vm.deal(blackHat, 1 ether);
        vm.deal(user, 1 ether);

        vm.prank(owner);
        contributor = new B_Contributor();
        vm.deal(address(contributor), 1000 ether);
    }

    function test_usersCanSendFunds() public {
        vm.startPrank(user);
        contributor.contribute{value: 0.1 ether}();
        uint256 userContributions = contributor.getContribution();
        vm.stopPrank();
        assertEq(userContributions, 0.1 ether);
    }

    function test_ownerCanWithdrawFunds() public {
        vm.prank(owner);
        contributor.withdraw();
        assertEq(owner.balance, 1000 ether);
        assertEq(address(contributor).balance, 0);
    }
}
