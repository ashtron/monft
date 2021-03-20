// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./openzeppelin-contracts/token/ERC721/ERC721.sol";
import "./openzeppelin-contracts/utils/Counters.sol";

// https://docs.openzeppelin.com/contracts/4.x-rc/erc721

contract MonFT is ERC721 {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;
    uint256 public dnaLength;

    struct dna {
        uint256 arms;
        uint256 body;
        uint256 ears;
        uint256 eyes;
        uint256 legs;
        uint256 nose;
        uint256 mouth;
        uint256 wings;
    }

    // tokenId => 
    mapping(uint256 => dna) public dnaSequences; //

    constructor(uint256 _dnaLength) ERC721("MonFT", "MFT") {
        dnaLength = _dnaLength;
    }

    // Gene data getter split into two functions to avoid stack too deep error.
    function getFaceData(uint256 tokenId) public view returns (uint256, uint256, uint256, uint256) {
        return (
            dnaSequences[tokenId].ears,
            dnaSequences[tokenId].eyes,
            dnaSequences[tokenId].nose,
            dnaSequences[tokenId].mouth
        );
    }

    function getBodyData(uint256 tokenId) public view returns (uint256, uint256, uint256, uint256) {
        return (
            dnaSequences[tokenId].arms,
            dnaSequences[tokenId].body,
            dnaSequences[tokenId].legs,
            dnaSequences[tokenId].wings
        );
    }

    function mintMon() public returns (uint256) {
        _tokenIds.increment();

        uint256 newMonId = _tokenIds.current();

        dnaSequences[newMonId] = dna({
            arms: 1,
            body: 2,
            ears: 3,
            eyes: 4,
            legs: 5,
            nose: 6,
            mouth: 7,
            wings: 8
        });

        _mint(msg.sender, newMonId);

        return newMonId;
    }

    // function generatedna() public view returns (uint256) {
    //     // Generate a random five-digit number.
    //     uint256 dna = generateRandomNumber() % 10 ** dnaLength;
    //     return dna;
    // }

    // function generateRandomNumber() public view returns (uint256) {
    //     // Pseudorandom for now.
    //     return uint(keccak256(abi.encodePacked(block.number)));
    // }

    // function mutate(uint256 tokenId) public {
    //     uint256 newdna = generatedna();
    //     dnaSequences[tokenId] = newdna;
    // }

    // function transferMon(address from, address to, uint256 tokenId) public {
    //     mutate(tokenId);
    //     safeTransferFrom(from, to, tokenId);
    // }
}