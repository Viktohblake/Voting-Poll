// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

interface IVoting {
    event PollCreated(uint indexed _pollId, address indexed _creator, string _question, string[] _options);
    event VoteCast(address indexed _voter, uint indexed _pollId, uint _option);

    function createPoll(string calldata _question, string[] calldata _options) external returns (uint _pollId);

    function vote(uint _pollId, uint _option) external;

    function getPoll(uint _pollId) external view returns (string memory _question, string[] memory _options, uint[] memory _voteCounts);
}