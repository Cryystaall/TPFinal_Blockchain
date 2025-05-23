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

        // TODO: initialise struct and store in mapping
        // polls[pollCount] = ...
        // emit PollCreated(pollCount);
        // pollCount++;
    }

    /// @notice vote on a poll
    /// @param id poll id
    /// @param opt index of option
    function vote(uint id, uint opt) external {
        // TODO: implement guards (deadline, double-vote, option bounds)
        // TODO: record vote & emit event
    }

    /// @notice view results
    function getResults(uint id) external view returns (uint[] memory) {
        return polls[id].votes;
    }
}
