const { expect } = require("chai");
const { ethers, network } = require("hardhat");

describe("Voting contract", function () {
  let Voting, voting, owner, user;

  before(async () => {
    [owner, user] = await ethers.getSigners();
    Voting = await ethers.getContractFactory("Voting");
  });

  beforeEach(async () => {
    voting = await Voting.deploy();
  });

  it("creates a poll", async () => {
    await voting.createPoll("Tea?", ["Yes", "No"], 3600);
    const poll = await voting.polls(0);
    expect(poll.question).to.equal("Tea?");
  });

  it("prevents double vote", async () => {
    await voting.createPoll("Coffee?", ["Yes", "No"], 3600);
    await voting.connect(user).vote(0, 1);

    await expect(
      voting.connect(user).vote(0, 0)
    ).to.be.revertedWith("Already voted");
  });

  it("prevents voting after deadline", async () => {
    await voting.createPoll("Milk?", ["Yes", "No"], 3000);

    await network.provider.send("evm_increaseTime", [4000]);
    await network.provider.send("evm_mine");

    await expect(
      voting.connect(user).vote(0, 1)
    ).to.be.revertedWith("Voting ended");
  });
});
