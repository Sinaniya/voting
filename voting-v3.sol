// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Voting {
    address private owner = msg.sender; // Set the contract creator as the owner

    modifier onlyOwner() {
        require(
            msg.sender == owner,
            "Only contract owner can perform this action."
        );
        _;
    }

    mapping(address => uint) public doner_Votes;
    mapping(address => uint) public doner_Weights;
    mapping(address => bool) public doner_hasVoted;

    mapping(address => uint) public hospital_Votes;
    mapping(address => uint) public hospital_Weights;
    mapping(address => bool) public hospital_hasVoted;

    mapping(uint => uint) public averages;

    uint public total_doner_Votes = 0; // Total number of votes
    uint public total_doner_Sum = 0; // Sum of all the numbers entered
    uint public total_doner_weight_Sum = 0;
    uint public avg_doner_weight = 0;

    uint public total_hospital_Votes = 0; // Total number of votes
    uint public total_hospital_Sum = 0; // Sum of all the numbers entered
    uint public total_hospital_weight_Sum = 0;
    uint public avg_hospital_weight = 0;

    uint public avg = 0;

    function castVote_Doner(uint _vote_doner, uint _weight_doner) public {
        //require(!doner_hasVoted[msg.sender], "You've already voted!");
        doner_Votes[msg.sender] = _vote_doner;
        doner_Weights[msg.sender] = _weight_doner;
        doner_hasVoted[msg.sender] = true;

        total_doner_Votes += 1;
        total_doner_Sum += _vote_doner;
        total_doner_weight_Sum += _weight_doner;
    }

    function castVote_Hospital(
        uint _vote_hospital,
        uint _weight_hospital
    ) public {
        //require(!hospital_hasVoted[msg.sender], "You've already voted!");
        hospital_Votes[msg.sender] = _vote_hospital;
        hospital_Weights[msg.sender] = _weight_hospital;
        hospital_hasVoted[msg.sender] = true;

        total_hospital_Votes += 1;
        total_hospital_Sum += _vote_hospital;
        total_hospital_weight_Sum += _weight_hospital;
    }

    function average() public returns (uint) {
        if (total_doner_Votes == 0 || total_hospital_Votes == 0) return 0; // To prevent division by zero

        avg =
            ((total_doner_Sum / total_doner_Votes) *
                (total_doner_weight_Sum / total_doner_Votes) +
                (total_hospital_Sum / total_hospital_Votes) *
                (total_hospital_weight_Sum / total_hospital_Votes)) /
            ((total_doner_weight_Sum / total_doner_Votes) +
                (total_hospital_weight_Sum / total_hospital_Votes));
        averages[block.timestamp] = avg;
        return avg;
    }

    function resetAll() public onlyOwner {
        total_doner_Votes = 0;
        total_doner_Sum = 0;
        total_doner_weight_Sum = 0;

        total_hospital_Votes = 0;
        total_hospital_Sum = 0;
        total_hospital_weight_Sum = 0;
    }
}
