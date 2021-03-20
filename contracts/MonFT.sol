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

    function mutate(uint256 tokenId) public {
        // Choose the part to mutate.
        uint256 partIndex = generateRandomNumber(8);

        // Choose the new part.
        uint256 newPartIndex = generateRandomNumber(numOptions);

        // Need to think of a more elegant method.
        if (partIndex == 1) {
            dnaSequences[tokenId].arms = getIndex(dnaSequences[tokenId].arms, newPartIndex);
        } else if (partIndex == 2) {
            dnaSequences[tokenId].body = getIndex(dnaSequences[tokenId].body, newPartIndex);
        } else if (partIndex == 3) {
            dnaSequences[tokenId].legs = getIndex(dnaSequences[tokenId].legs, newPartIndex);
        } else if (partIndex == 4) {
            dnaSequences[tokenId].wings = getIndex(dnaSequences[tokenId].wings, newPartIndex);
        } else if (partIndex == 5) {
            dnaSequences[tokenId].ears = getIndex(dnaSequences[tokenId].ears, newPartIndex);
        } else if (partIndex == 6) {
            dnaSequences[tokenId].eyes = getIndex(dnaSequences[tokenId].eyes, newPartIndex);
        } else if (partIndex == 7) {
            dnaSequences[tokenId].nose = getIndex(dnaSequences[tokenId].nose, newPartIndex);
        } else if (partIndex == 8) {
            dnaSequences[tokenId].mouth = getIndex(dnaSequences[tokenId].mouth, newPartIndex);
        }
    }

    function transferMon(address from, address to, uint256 tokenId) public {
        mutate(tokenId);
        safeTransferFrom(from, to, tokenId);
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

    // Gene data getter split into two functions to avoid stack too deep error.
    function getBodyData(uint256 tokenId) public view returns (uint256, uint256, uint256, uint256) {
        return (
            dnaSequences[tokenId].arms,
            dnaSequences[tokenId].body,
            dnaSequences[tokenId].legs,
            dnaSequences[tokenId].wings
        );
    }
    
    function getFaceData(uint256 tokenId) public view returns (uint256, uint256, uint256, uint256) {
        return (
            dnaSequences[tokenId].ears,
            dnaSequences[tokenId].eyes,
            dnaSequences[tokenId].nose,
            dnaSequences[tokenId].mouth
        );
    }

    function generateRandomNumber(uint256 max) public view returns (uint256) {
        uint256 randomNumber = uint(keccak256(abi.encodePacked(block.timestamp, msg.sender))) % max;
        return randomNumber + 1; // Add 1 to avoid 0 (no part).
    }

    function getIndex(uint256 current, uint256 index) private view returns (uint256) {
        // Make sure the part changes.
        return index == current ? (index + 1) % numOptions : index;
    }
}