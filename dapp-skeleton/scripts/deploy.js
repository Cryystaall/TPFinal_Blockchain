const hre = require("hardhat");

async function main() {
  const Voting = await hre.ethers.getContractFactory("Voting");
  const voting = await Voting.deploy();            
  await voting.waitForDeployment();                    
  console.log("Voting deployed at:", voting.target);   
}

main().catch((e) => {
  console.error(e);
  process.exit(1);
});
