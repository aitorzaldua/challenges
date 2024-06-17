// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Test, console} from "forge-std/Test.sol";
import {A_PasswordStore} from "../src/A_PasswordStore.sol";

contract A_PasswordStoreTest is Test {
    address owner = makeAddr("owner");
    address blackHat = makeAddr("blackHat");

    A_PasswordStore public passwordStore;

    function setUp() public {
        vm.prank(owner);
        passwordStore = new A_PasswordStore();
    }

    function test_owner_can_set_password() public {
        vm.startPrank(owner);
        string memory expectedPassword = "myNewPassword";
        passwordStore.setPassword(expectedPassword);
        string memory actualPassword = passwordStore.getPassword();
        assertEq(actualPassword, expectedPassword);
    }

    function testFail_non_owner_reading_password_reverts() public {
        vm.startPrank(blackHat);
        passwordStore.getPassword();
    }
}
