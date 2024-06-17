// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.18;

/*
 * @title Contributor
 * @notice This contract allows you to add funds to this contract using  contribute().
 * ******* If you are able to send more ether to the contract than the owner, you will become
 * ******* the owner but you only have 1 ether.
 * ******* As a security researcher, you have to stole the funds and write the PoC to send to developers.
 */
contract B_Contributor {
    mapping(address => uint256) public contributions;
    address public owner;

    constructor() {
        owner = msg.sender;
        contributions[msg.sender] = 1000 ether;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "caller is not the owner");
        _;
    }

    function contribute() public payable {
        require(msg.value < 1 ether);
        contributions[msg.sender] += msg.value;
        if (contributions[msg.sender] > contributions[owner]) {
            owner = msg.sender;
        }
    }

    function getContribution() public view returns (uint256) {
        return contributions[msg.sender];
    }

    function withdraw() public onlyOwner {
        payable(owner).transfer(address(this).balance);
    }

    receive() external payable {
        require(msg.value > 0 && contributions[msg.sender] > 0);
        owner = msg.sender;
    }
}
