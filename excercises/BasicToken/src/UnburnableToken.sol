// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

/* Create a contract called UnburnableToken. Add the following in storage:

A public mapping called balances to store how many tokens are owned by each address
A public uint to hold totalSupply
A public uint to hold totalClaimed
Other variables as necessary to complete the task
*/

contract UnburnableToken {
    mapping(address => uint256) public balances;
    mapping(address => bool) public hasClaimed;

    uint256 public totalSupply;
    uint256 public totalClaimed = 0;

    constructor() {
        totalSupply = 100000000;
    }

    /*
    Add a function called claim. When called, so long as a number of tokens equalling the totalSupply have not yet been distributed, any wallet that has not made a claim previously should be able to claim 1000 tokens. If a wallet tries to claim a second time, it should revert with TokensClaimed.
    The totalClaimed should be incremented by the claim amount.
    Once all tokens have been claimed, this function should revert with an error AllTokensClaimed. (We won't be able to test this, but you'll know if it's there!)
    */
    error AllTokensClaimed();
    error TokensClaimed();

    function claim() public {
        if (totalSupply <= totalClaimed) {
            revert AllTokensClaimed();
        }

        if (hasClaimed[msg.sender]) {
            revert TokensClaimed();
        }

        uint256 claimAmount = 1000;
        balances[msg.sender] += claimAmount;

        hasClaimed[msg.sender] = true;
        totalClaimed += claimAmount;
    }

    /*
    Implement a function called safeTransfer that accepts an address _to and an _amount. It should transfer tokens from the sender to the _to address, only if:

    That address is not the zero address
    That address has a balance of greater than zero Base Goerli Eth
    A failure of either of these checks should result in a revert with an UnsafeTransfer error, containing the address.
    */
    error UnsafeTransfer(address);
    error InsufficientBalance(address, uint256 has, uint256 required);

    function safeTransfer(address _to, uint256 _amount) public {
        if (_to == address(0) || _to.balance == 0) {
            revert UnsafeTransfer(_to);
        }

        if (balances[msg.sender] < _amount) {
            revert InsufficientBalance(
                msg.sender,
                balances[msg.sender],
                _amount
            );
        }

        balances[msg.sender] -= _amount;
        balances[_to] += _amount;
    }
}
