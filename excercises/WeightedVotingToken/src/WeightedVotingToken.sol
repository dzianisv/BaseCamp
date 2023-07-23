// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import "lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";
import "lib/openzeppelin-contracts/contracts/utils/structs/EnumerableSet.sol";

contract WeightedVotingToken is ERC20 {
    using EnumerableSet for EnumerableSet.AddressSet;

    uint public maxSupply = 1000000;

    mapping(address => bool) public hasClaimed;

    enum Votes {
        AGAINST,
        FOR,
        ABSTAIN
    }

    struct Issue {
        EnumerableSet.AddressSet voters;
        string issueDesc;
        uint votesFor;
        uint votesAgainst;
        uint votesAbstain;
        uint totalVotes;
        uint quorum;
        bool passed;
        bool closed;
    }

    struct PublicIssue {
        address[] voters;
        string issueDesc;
        uint256 votesFor;
        uint256 votesAgainst;
        uint256 votesAbstain;
        uint256 totalVotes;
        uint256 quorum;
        bool passed;
        bool closed;
    }

    Issue[] _issues;

    error TokensClaimed();
    error AllTokensClaimed();
    error NoTokensHeld();
    error QuorumTooHigh(uint proposedQuorum);
    error AlreadyVoted();
    error VotingClosed();

    constructor() ERC20("WeightedVotingToken", "WVT") {
        //Burn the 0th element
        _issues.push();
        _issues[0].closed = true;
    }

    function claim() public {
        if (totalSupply() >= maxSupply) revert AllTokensClaimed();
        if (hasClaimed[msg.sender]) revert TokensClaimed();

        hasClaimed[msg.sender] = true;
        _mint(msg.sender, 100);
    }

    function createIssue(
        string calldata desc,
        uint quorum
    ) public returns (uint) {
        if (balanceOf(msg.sender) <= 0) revert NoTokensHeld();
        if (quorum > totalSupply()) revert QuorumTooHigh(quorum);

        _issues.push();
        Issue storage issue = _issues[_issues.length - 1];
        issue.issueDesc = desc;
        issue.quorum = quorum;

        return _issues.length - 1;
    }

    function getIssue(
        uint256 _issueId
    ) external view returns (PublicIssue memory) {
        Issue storage issue = _issues[_issueId];

        return
            PublicIssue(
                issue.voters.values(),
                issue.issueDesc,
                issue.votesFor,
                issue.votesAgainst,
                issue.votesAbstain,
                issue.totalVotes,
                issue.quorum,
                issue.passed,
                issue.closed
            );
    }

    function vote(uint _issueId, Votes _vote) public {
        Issue storage issue = _issues[_issueId];

        if (issue.closed) revert VotingClosed();
        if (issue.voters.contains(msg.sender)) revert AlreadyVoted();

        issue.voters.add(msg.sender);
        uint voterBalance = balanceOf(msg.sender);

        if (_vote == Votes.FOR) {
            issue.votesFor += voterBalance;
        } else if (_vote == Votes.AGAINST) {
            issue.votesAgainst += voterBalance;
        } else {
            issue.votesAbstain += voterBalance;
        }

        issue.totalVotes += voterBalance;
        if (issue.totalVotes >= issue.quorum) {
            issue.closed = true;
            issue.passed = issue.votesFor > issue.votesAgainst;
        }
    }
}
