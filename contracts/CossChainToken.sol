// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.27;

// import "hardhat/console.sol";
import "../node_modules/@layerzerolabs/solidity-examples/contracts/lzApp/NonblockingLzApp.sol";
import "../node_modules/@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract CrossChainToken is NonblockingLzApp, ERC20 {
    uint16 dstChainId;

    constructor(
        address _endpoint
    ) NonblockingLzApp(_endpoint) ERC20("MyToken", "TKN") {
        if (_endpoint == 0x55370E0fBB5f5b8dAeD978BA1c075a499eB107B8)
            dstChainId = 10231;
        if (_endpoint == 0x6098e96a28E02f27B1e6BD381f870F1C8Bd169d3)
            dstChainId = 10232;

        _mint(msg.sender, 100000 * 10 ** decimals());
    }

    function _nonblockingLzReceive(
        uint16,
        bytes memory,
        uint64,
        bytes memory _payload
    ) internal override {
        (address account, uint amount) = abi.decode(_payload, (address, uint));
        _mint(account, amount);
    }

    function bridge(uint _amount) public payable {
        _burn(msg.sender, _amount);
        bytes memory payload = abi.encode(msg.sender, _amount);
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
