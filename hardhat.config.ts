import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
import * as dotenv from "dotenv";
import * as path from "path";
dotenv.config({ path: path.resolve(__dirname, ".env") });

const privateKey = process.env.PRIVATE_KEY || "";
const optimismId = process.env.OPTIMISM_KEY || "";
const arbitrum_id = process.env.ARBITRUM_KEY || "";

const config: HardhatUserConfig = {
  defaultNetwork: "hardhat",
  networks: {
    hardhat: {
      blockGasLimit: 10000000,
      mining: {
        auto: true,
      },
      accounts: {
        count: 1000,
      },
    },
    optimism: {
      url: `https://opt-sepolia.g.alchemy.com/v2/${optimismId}`,
      accounts: privateKey ? [privateKey] : [],
    },
    arbitrum: {
      url: `https://arb-sepolia.g.alchemy.com/v2/${arbitrum_id}`,
      accounts: privateKey ? [privateKey] : [],
    }
  },
  solidity: {
    version: "0.8.27",
    settings: {
      optimizer: {
        enabled: true,
        runs: 200,
      },
    },
  },
};

export default config;
