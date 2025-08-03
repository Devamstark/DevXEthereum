const { ethers } = require("hardhat");

async function main() {
  const [deployer] = await ethers.getSigners();
  
  console.log("Deploying with account:", deployer.address);
  
  const HoneypotFactory = await ethers.getContractFactory("HoneypotFactory");
  const factory = await HoneypotFactory.deploy();
  
  await factory.deployed();
  console.log("Factory deployed to:", factory.address);
  
  // Deploy sample honeypots
  const tx1 = await factory.createHoneypot(0, { value: ethers.utils.parseEther("0.1") });
  const receipt1 = await tx1.wait();
  console.log("Basic honeypot:", receipt1.events[0].args.contractAddress);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
