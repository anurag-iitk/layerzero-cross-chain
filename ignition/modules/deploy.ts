import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

// Define the contract parameters
const endpointAddress1 = "0x55370E0fBB5f5b8dAeD978BA1c075a499eB107B8"; // Address for dstChainId 10231
const endpointAddress2 = "0x6098e96a28E02f27B1e6BD381f870F1C8Bd169d3"; // Address for dstChainId 10232


module.exports = buildModule("LayerZeroTestContractModule", (m) => {
  const LayerZeroTestContract = m.contract("LayerZeroTestContract", [endpointAddress1]);
  return { LayerZeroTestContract };
})

module.exports = buildModule("LayerZeroTestContractModule", (m) => {
  const LayerZeroTestContract = m.contract("LayerZeroTestContract", [endpointAddress2]);
  return { LayerZeroTestContract };
})

module.exports = buildModule("CrossChainTokenModule", (m) => {
  const CrossChainToken = m.contract("CrossChainToken", [endpointAddress1]);
  return { CrossChainToken };
})

module.exports = buildModule("CrossChainTokenModule", (m) => {
  const CrossChainToken = m.contract("CrossChainToken", [endpointAddress2]);
  return { CrossChainToken };
})

