// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.27;

// import "hardhat/console.sol";
import "../node_modules/@layerzerolabs/solidity-examples/contracts/lzApp/NonblockingLzApp.sol";

/*
Optimism Goerli - chain ID is 10132, and the endpoint is 0xae92d5aD7583AD66E49A0c67BAd18F6ba52dDDc1.
Goerli - 0xbfD2135BFfbb0B5378b56643c2Df8a87552Bfa23 and chainId is 10121
*/

contract LayerZeroTestContract is NonblockingLzApp {
    string public data = "No message received";
    uint16 dstChainId;

    constructor(address _endpoint) NonblockingLzApp(_endpoint) {
        if (_endpoint == 0xae92d5aD7583AD66E49A0c67BAd18F6ba52dDDc1)
            dstChainId = 10121;
        if (_endpoint == 0xbfD2135BFfbb0B5378b56643c2Df8a87552Bfa23)
            dstChainId = 10132;
    }

    function _nonblockingLzReceive(
        uint16,
        bytes memory,
        uint64,
        bytes memory _payload
    ) internal override {
        data = abi.decode(_payload, (string));
    }

    function send(string memory _message) public payable {
        bytes memory payload = abi.encode(_message);
        _lzSend(
            dstChainId,
            payload,
            payable(msg.sender),
            address(0x0),
            bytes(""),
            msg.value
        );
    }

    function trustAddress(address _otherContract) public onlyOwner {
        trustedRemoteLookup[dstChainId] = abi.encodePacked(
            _otherContract,
            address(this)
        );
    }
}
