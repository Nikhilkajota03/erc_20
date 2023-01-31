const hre = require("hardhat");

async function main() {

  const OceanToken = await hre.ethers.getContractFactory("OceanToken")
  const  oceanToken = await OceanToken.deploy(100000000, 50)

  await oceanToken.deployed();

  console.log("address of the OceanToken",oceanToken.address);

}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});


//0xEDbAE91A4D7969302B1c588958f48eE7aFf0564F
