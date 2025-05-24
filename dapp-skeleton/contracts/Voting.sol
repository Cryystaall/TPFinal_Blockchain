// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/// @title Voting - simple poll-based voting contract (squelette)
contract Voting {
    struct Poll {
        string question;
        string[] options;
        uint[] votes;
        uint deadline;
        address owner;
    }

    uint public pollCount;
    mapping(uint => Poll) public polls;
    mapping(uint => mapping(address => bool)) public voted;

    event PollCreated(uint pollId);
    event Voted(uint pollId, address voter, uint option);

    /// @notice create a new poll
    /// @param q The question
    /// @param opts array of options (min 2)
    /// @param dur duration in seconds
    function createPoll(string calldata q, string[] calldata opts, uint dur) external {
    require(opts.length >= 2, "min 2 options");

    Poll storage p = polls[pollCount];
    p.question = q;
    p.deadline = block.timestamp + dur;
    p.owner = msg.sender;

    // Copier les options élément par élément
    for (uint i = 0; i < opts.length; i++) {
        p.options.push(opts[i]);
        p.votes.push(0);
    }

    emit PollCreated(pollCount);
    pollCount++;
}


    /// @notice vote on a poll
    /// @param id poll id
    /// @param opt index of option
    function vote(uint id, uint opt) external {
        Poll storage p = polls[id];

        require(block.timestamp <= polls[id].deadline, "Voting ended");
        require(!voted[id][msg.sender], "Already voted");
        require(opt < p.options.length, "invalid option");

        p.votes[opt]++;
        voted[id][msg.sender] = true;

        emit Voted(id, msg.sender, opt);
    }

    /// @notice view results
    function getResults(uint id) external view returns (uint[] memory) {
        return polls[id].votes;
    }
}
