// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import "forge-std/Test.sol";
import "../src/WeightedVotingToken.sol";

contract WeightedVotingTokenTest is Test {
    WeightedVotingToken public token;

    function setUp() public {
        token = new WeightedVotingToken();
    }

    function test_revertIf_doubleClaimed() public {
        token.claim();
        vm.expectRevert();
        token.claim();
    }

    function test_createIssue() public {
        token.claim();
        uint256 issueId = token.createIssue("Fix test issue", 100);
        token.vote(issueId, WeightedVotingToken.Votes.FOR);
        token.getIssue(issueId);
    }
}
