# LayerZero Cross Chain Protocol

This repository contains two Solidity smart contracts that demonstrate cross-chain communication using the LayerZero protocol. These contracts are designed to operate on different Ethereum test networks and allow for message passing and token bridging between chains.

## Table of Contents

1. [Overview](#overview)
2. [Contracts](#contracts)
   - [LayerZeroTestContract](#layerzerotestcontract)
   - [LayerZeroTokenContract](#layerzerotokencontract)
3. [Deployment Information](#deployment-information)
4. [Usage](#usage)
   - [Message Sending](#message-sending)
   - [Token Bridging](#token-bridging)
5. [Setup and Installation](#setup-and-installation)

## Overview

The contracts leverage the LayerZero protocol to enable cross-chain communication. They demonstrate basic functionalities such as sending and receiving messages and transferring tokens across different chains.

### LayerZeroTestContract
This contract allows sending and receiving string messages between chains. It utilizes LayerZero's `NonblockingLzApp` to ensure that cross-chain messages are received even if the transaction reverts.

### LayerZeroTokenContract
This contract extends the `ERC20` standard and the `NonblockingLzApp` to facilitate token bridging between chains. It allows users to burn tokens on the source chain and mint them on the destination chain.

## Contracts

### LayerZeroTestContract

#### Constructor
- `constructor(address _endpoint)`: Initializes the contract with the LayerZero endpoint address and sets the destination chain ID based on the endpoint.

#### Functions
- `_nonblockingLzReceive`: Overrides the parent function to update the `data` variable with the received message.
- `send(string memory _message)`: Encodes and sends the provided message to the destination chain.
- `trustAddress(address _otherContract)`: Sets the trusted remote contract address for cross-chain communication.

### LayerZeroTokenContract

#### Constructor
- `constructor(address _endpoint)`: Initializes the contract with the LayerZero endpoint address, sets the destination chain ID, and mints an initial supply of tokens to the deployer.

#### Functions
- `_nonblockingLzReceive`: Overrides the parent function to mint tokens to the specified account on the destination chain.
- `bridge(uint _amount)`: Burns the specified amount of tokens on the source chain and sends a message to mint them on the destination chain.
- `trustAddress(address _otherContract)`: Sets the trusted remote contract address for cross-chain communication.

## Deployment Information

- **Optimism (Chain ID: 10232)**
  - Endpoint: `0x55370E0fBB5f5b8dAeD978BA1c075a499eB107B8`

- **Arbitrum (Chain ID: 10231)**
  - Endpoint: `0x6098e96a28E02f27B1e6BD381f870F1C8Bd169d3`

## Usage

### Message Sending (LayerZeroTestContract)
1. **Deploy the Contract**: Deploy the contract on the desired network with the appropriate endpoint.
2. **Send Message**: Call the `send` function with the desired message. The message will be encoded and sent to the destination chain.
3. **Receive Message**: The `_nonblockingLzReceive` function on the destination chain will decode and store the received message.

### Token Bridging (LayerZeroTokenContract)
1. **Deploy the Contract**: Deploy the contract on both the source and destination chains with the appropriate endpoints.
2. **Bridge Tokens**: Call the `bridge` function with the desired token amount. The tokens will be burned on the source chain and a message will be sent to mint them on the destination chain.
3. **Mint Tokens**: The `_nonblockingLzReceive` function on the destination chain will decode the message and mint the tokens to the specified address.

## Setup and Installation

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/anurag-iitk/layerzero-cross-chain.git
   cd layerzero-cross-chain
   ```

2. **Install Dependencies**:
   Make sure you have [Node.js](https://nodejs.org/) installed. Run the following command to install the required dependencies:

   ```bash
   npm install
   ```

3. **Compile the Contracts**:
   Use Hardhat to compile the contracts:

   ```bash
   npx hardhat compile
   ```

4. **Deploy the Contracts**:
   You can deploy the contracts using the Hardhat deployment scripts. Configure the network settings in `hardhat.config.ts` and run:

   ```bash
   npx hardhat run scripts/deploy.js --network <network-name>
   ```
