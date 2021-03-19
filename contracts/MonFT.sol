// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./openzeppelin-contracts/token/ERC721/ERC721.sol";
import "./openzeppelin-contracts/utils/Counters.sol";

// https://docs.openzeppelin.com/contracts/4.x-rc/erc721

contract MonFT is ERC721 {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    // tokenID => random number
    mapping(uint256 => uint256) public geneSequences;

    constructor() ERC721("MonFT", "MFT") {}

    function mintMon() public returns (uint256) {
        _tokenIds.increment();
        uint256 newMonId = _tokenIds.current();
        
        geneSequences[newMonId] = generateGeneSequence();
        _mint(msg.sender, newMonId);

        return newMonId;
    }

    function generateGeneSequence() public view returns (uint256) {
        uint256 geneSequence = generateRandomNumber() % 10 ** 4;
        return geneSequence;
    }

    function generateRandomNumber() public view returns (uint256) {
        // Pseudorandom for now.
        return uint(keccak256(abi.encodePacked(block.number)));
    }

    function mutate(uint256 tokenId) public {
        uint256 newGeneSequence = generateGeneSequence();
        geneSequences[tokenId] = newGeneSequence;
    }

    function transferMon(address from, address to, uint256 tokenId) public {
        mutate(tokenId);
        safeTransferFrom(from, to, tokenId);
    }
}