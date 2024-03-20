// SPDX-License-Identifier: MIT

pragma solidity ^0.8.24;

import "./IVoting.sol";

contract Voting {

    struct Poll {
        string question;
        string[] option;
        mapping(address => bool) hasVoted;
        mapping(uint => uint) votes;
        bool exists;
    } 

    Poll[] public polls;

    mapping(address => mapping(uint => bool)) public hasVoted;

    event PollCreatedSuccessfully(uint _pollId, string _question, string[] _options);
    event VotedSuccessfully(uint _pollId, address _voter, uint _option);

    function createPoll(string memory _question, string[] memory _options) public {
        require(_options.length >= 2, "Poll must have at least 2 options.");

        Poll storage newPoll = polls.push();

        newPoll.question = _question;

        newPoll.option = _options;

        newPoll.exists = true;
        
        emit PollCreatedSuccessfully(polls.length - 1, _question, _options);
    }
    
    function vote(uint _pollId, uint _option) public {
        require(_pollId < polls.length, "Poll does not exist.");

        require(!hasVoted[msg.sender][_pollId], "You have alreadt voted.");

        require(_option < polls[_pollId].option.length, "Invalid option.");

        polls[_pollId].votes[_option]++;
        polls[_pollId].hasVoted[msg.sender] = true;
        hasVoted[msg.sender][_pollId] = true;

        emit VotedSuccessfully(_pollId, msg.sender, _option);
    }

    function getPoll(uint _pollId) public view returns (string memory _question, string[] memory _options, uint[] memory _votes) {
        require(_pollId < polls.length, "Poll does not exist.");

        Poll storage poll = polls[_pollId];
        uint optionCount = poll.option.length;
        _votes = new uint[] (optionCount);

        for(uint i = 0; i < optionCount; i++) {
            _votes[i] = poll.votes[i];

        }
            return(poll.question, poll.option, _votes);
    }
}