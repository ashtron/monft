// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./openzeppelin-contracts/token/ERC721/ERC721.sol";
import "./openzeppelin-contracts/utils/Counters.sol";

// https://docs.openzeppelin.com/contracts/4.x-rc/erc721

contract MonFT is ERC721 {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;
    uint256 public dnaLength;
    uint256 public numOptions;

    struct dna {
        uint256 arms;
        uint256 body;
        uint256 ears;
        uint256 eyes;
        uint256 legs;
        uint256 nose;
        uint256 mouth;
        uint256 wings;
        uint256 mutations;
    }

    mapping(uint256 => dna) public dnaSequences;

    constructor(uint256 _numOptions) ERC721("MonFT", "MFT") {
        numOptions = _numOptions;
    }

    function mintMon() public returns (uint256) {
        _tokenIds.increment();

        uint256 newMonId = _tokenIds.current();
        initializeDna(newMonId);
        _mint(msg.sender, newMonId);

        return newMonId;
    }

    function initializeDna(uint256 tokenId) public {
        dnaSequences[tokenId] = dna({
            arms: 0,
            body: 1,
            ears: 0,
            eyes: 0,
            legs: 0,
            nose: 0,
            mouth: 0,
            wings: 0,
            mutations: 0
        });
    }

    // function generateRandomNumber() public view returns (int256) {
    //     // Pseudorandom for now.
        
    //     int randomNumber = abs(int(uint(keccak256(abi.encodePacked("500dfasdfasdfdfas"))) % 10));
    //     return abs(randomNumber - int(numOptions));
    // }

    function generateRandomNumber() public view returns (uint256) {
        uint256 randomNumber = uint(keccak256(abi.encodePacked(block.timestamp, msg.sender))) % numOptions;
        return randomNumber;
    }

    function abs(int x) private pure returns (int) {
        return x >= 0 ? x : -x;
    }

    function numDigits(int number) private pure returns (uint8) {
        uint8 digits = 0;

        while (number != 0) {
            number /= 10;
            digits++;
        }

        return digits;
    }

    // function mutate(uint256 tokenId) public {
    //     uint256 newdna = generatedna();
    //     dnaSequences[tokenId] = newdna;
    // }

    // function transferMon(address from, address to, uint256 tokenId) public {
    //     mutate(tokenId);
    //     safeTransferFrom(from, to, tokenId);
    // }

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
}