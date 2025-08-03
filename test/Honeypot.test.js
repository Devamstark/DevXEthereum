const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("Honeypot Tests", function() {
  let factory;
  
  before(async () => {
    const HoneypotFactory = await ethers.getContractFactory("HoneypotFactory");
    factory = await HoneypotFactory.deploy();
  });

  it("Should deploy basic honeypot", async () => {
    const tx = await factory.createHoneypot(0);
    const receipt = await tx.wait();
    expect(receipt.events[0].args.contractAddress).to.be.properAddress;
  });

  it("Should detect reentrancy attempts", async () => {
    const tx = await factory.createHoneypot(1);
    const receipt = await tx.wait();
    const honeypotAddress = receipt.events[0].args.contractAddress;
    
    const honeypot = await ethers.getContractAt("ReentrancyHoneypot", honeypotAddress);
    await expect(
      honeypot.withdraw(ethers.utils.parseEther("0.1"))
    ).to.emit(honeypot, "AttackDetected");
  });
});
