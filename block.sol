// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleBlockchain {
    struct Block {
        uint index;
        string data;
        uint timestamp;
        bytes32 previousHash;
        bytes32 currentHash;
    }

    Block[] public blockchain;

    constructor() {
        // Create the genesis block
        _createBlock("Genesis Block", bytes32(0));
    }

    function createBlock(string memory _data) public {
        Block memory previousBlock = blockchain[blockchain.length - 1];
        _createBlock(_data, previousBlock.currentHash);
    }

    function _createBlock(string memory _data, bytes32 _previousHash) internal {
        uint index = blockchain.length;
        uint timestamp = block.timestamp;
        bytes32 currentHash = keccak256(abi.encodePacked(index, _data, timestamp, _previousHash));

        Block memory newBlock = Block({
            index: index,
            data: _data,
            timestamp: timestamp,
            previousHash: _previousHash,
            currentHash: currentHash
        });

        blockchain.push(newBlock);
    }

    function getBlock(uint _index) public view returns (uint, string memory, uint, bytes32, bytes32) {
        require(_index < blockchain.length, "Block does not exist.");
        Block memory blockData = blockchain[_index];
        return (blockData.index, blockData.data, blockData.timestamp, blockData.previousHash, blockData.currentHash);
    }

    function getLatestBlock() public view returns (uint, string memory, uint, bytes32, bytes32) {
        return getBlock(blockchain.length - 1);
    }

    function getBlockchainLength() public view returns (uint) {
        return blockchain.length;
    }
}