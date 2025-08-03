const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("Attack Simulation", () => {
  it("Should simulate ownership hijack attempt", async () => {
    const HiddenOwnerHoneypot = await ethers.getContractFactory("HiddenOwnerHoneypot");
    const honeypot = await HiddenOwnerHoneypot.deploy({ value: ethers.utils.parseEther("0.1") });
    
    const [_, attacker] = await ethers.getSigners();
    await expect(
      honeypot.connect(attacker).changeOwner(attacker.address)
    ).to.emit(honeypot, "OwnershipAttack");
  });
});
