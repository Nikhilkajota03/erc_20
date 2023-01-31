require("@nomicfoundation/hardhat-toolbox");

require("dotenv").config();
/** @type import('hardhat/config').HardhatUserConfig */

const GOERLI_URL = process.env.GOERLI_URL;
const PRIVATE_KEY = process.env.PRIVATE_KEY;
module.exports = {
  solidity: "0.8.17",
  networks: {
    goerli: {
      url:"https://eth-goerli.g.alchemy.com/v2/_17YLvfVUabt2_sGEze8GnVWSGSKTH9P",
      accounts: ["26b018a00f21af534c59b733b4788c2f6ab17fa771d30ef3302e2933b1362016"],
    },
  },
};
