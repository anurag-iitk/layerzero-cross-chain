// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.27;

// import "hardhat/console.sol";
import "../node_modules/@layerzerolabs/solidity-examples/contracts/lzApp/NonblockingLzApp.sol";

/*
Optimism Goerli - chain ID is 10132, and the endpoint is 0xae92d5aD7583AD66E49A0c67BAd18F6ba52dDDc1.
Goerli - 0xbfD2135BFfbb0B5378b56643c2Df8a87552Bfa23 and chainId is 10121
*/

abstract contract LayerZeroTestContract is NonblockingLzApp {
    string public data = "No message received";
    uint16 destChainId;

    constructor(address _endpoint) NonblockingLzApp(_endpoint) {
        if(_endpoint == 0xae92d5aD7583AD66E49A0c67BAd18F6ba52dDDc1) destChainId = 10121;
        if(_endpoint == 0xbfD2135BFfbb0B5378b56643c2Df8a87552Bfa23) destChainId = 10132;
    }

    function 

}
