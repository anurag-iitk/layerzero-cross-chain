// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.27;

// import "hardhat/console.sol";
import "../node_modules/@layerzerolabs/solidity-examples/contracts/lzApp/NonblockingLzApp.sol";

/*
Optimism - chain ID is 10232, and the endpoint is 0x55370E0fBB5f5b8dAeD978BA1c075a499eB107B8.
Arbitrum - 0x6098e96a28E02f27B1e6BD381f870F1C8Bd169d3 and chainId is 10231
*/

contract LayerZeroTestContract is NonblockingLzApp {
    string public data = "No message received";
    uint16 dstChainId;

    constructor(address _endpoint) NonblockingLzApp(_endpoint) {
        if (_endpoint == 0x55370E0fBB5f5b8dAeD978BA1c075a499eB107B8)
            dstChainId = 10231;
        if (_endpoint == 0x6098e96a28E02f27B1e6BD381f870F1C8Bd169d3)
            dstChainId = 10232;
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
