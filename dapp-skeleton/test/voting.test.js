const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("Voting contract", function () {
  let Voting, voting, owner, user;

  before(async () => {
    [owner, user] = await ethers.getSigners();
    Voting = await ethers.getContractFactory("Voting");
  });

  beforeEach(async () => {
    voting = await Voting.deploy();
    await voting.deployed();
  });

  it("creates a poll", async () => {
    await voting.createPoll("Tea?", ["Yes","No"], 3600);
    const poll = await voting.polls(0);
    expect(poll.question).to.equal("Tea?");
  });

  // TODO: test double vote
  // TODO: test vote after deadline
});
