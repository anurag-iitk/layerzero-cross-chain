// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.27;

// import "hardhat/console.sol";
import "../node_modules/@layerzerolabs/solidity-examples/contracts/lzApp/NonblockingLzApp.sol";
import "../node_modules/@openzeppelin/contracts/token/ERC20/ERC20.sol";

abstract contract LayerZeroTestContract is NonblockingLzApp, ERC20 {
    uint16 dstChainId;

    constructor(
        address _endpoint
    ) NonblockingLzApp(_endpoint) ERC20("MyToken", "TKN") {
        if (_endpoint == 0xae92d5aD7583AD66E49A0c67BAd18F6ba52dDDc1)
            dstChainId = 10121;
        if (_endpoint == 0xbfD2135BFfbb0B5378b56643c2Df8a87552Bfa23)
            dstChainId = 10132;
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
}
