// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Voting {
    mapping(address => uint) public votes;
    mapping(address => bool) public hasVoted;

    uint public totalVotes = 0;  // Total number of votes
    uint public totalSum = 0;    // Sum of all the numbers entered

    function castVote(uint _vote) public {
        require(!hasVoted[msg.sender], "You've already voted!");
        votes[msg.sender] = _vote;
        hasVoted[msg.sender] = true;

        totalVotes += 1;
        totalSum += _vote;
    }

    function avg() public view returns (uint) {
        if (totalVotes == 0) return 0; // To prevent division by zero
        return totalSum / totalVotes;
    }
}
