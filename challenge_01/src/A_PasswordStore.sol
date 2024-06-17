// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

/*
 * @title A_PasswordStore
 * @notice This contract allows store private passwords.
 ********* It is owner protected, so only the owner can see the password.
 ********* Also, only the owner can set a new password.
 * CHALLENGE: Find all the vulnerabilities.
 */
contract A_PasswordStore {
    error PasswordStore__NotOwner();

    address private s_owner;
    string private s_password;

    event SetNetPassword();

    constructor() {
        s_owner = msg.sender;
    }

    /*
     * @notice This function allows only the owner to set a new password.
     * @param newPassword The new password to set.
     */
    function setPassword(string memory newPassword) external {
        s_password = newPassword;
        emit SetNetPassword();
    }

    /*
     * @notice This allows only the owner to retrieve the password.
     * @param newPassword The new password to set.
     */
    function getPassword() external view returns (string memory) {
        if (msg.sender != s_owner) {
            revert PasswordStore__NotOwner();
        }
        return s_password;
    }
}
