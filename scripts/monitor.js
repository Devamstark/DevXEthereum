const { ethers } = require("hardhat");

async function monitorAttacks(factoryAddress) {
  const factory = await ethers.getContractAt("HoneypotFactory", factoryAddress);
  
  factory.on("HoneypotCreated", (contractAddress, hType) => {
    console.log(`New honeypot deployed: ${contractAddress} (Type ${hType})`);
  });
  
  console.log("Monitoring for attacks...");
}

// Usage: node scripts/monitor.js <factory-address>
monitorAttacks(process.argv[2]);
