// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./openzeppelin-contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "./openzeppelin-contracts/utils/Counters.sol";

// https://docs.openzeppelin.com/contracts/4.x-rc/erc721

contract MonFT is ERC721Enumerable {
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

    // Need to think of a more elegant method.
    function mutate(uint256 tokenId) public {
        dna storage dnaSequence = dnaSequences[tokenId];

        // Choose the new part.
        uint256 newPartIndex = generateRandomNumber(numOptions);

        // If a part is missing, add it.
        if (dnaSequence.arms == 0) {
            dnaSequences[tokenId].arms = newPartIndex;
            return;
        } else if (dnaSequence.body == 0) {
            dnaSequences[tokenId].body = newPartIndex;
            return;
        } else if (dnaSequence.legs == 0) {
            dnaSequences[tokenId].legs = newPartIndex;
            return;
        } else if (dnaSequence.wings == 0) {
            dnaSequences[tokenId].wings = newPartIndex;
            return;
        } else if (dnaSequence.ears == 0) {
            dnaSequences[tokenId].ears = newPartIndex;
            return;
        } else if (dnaSequence.eyes == 0) {
            dnaSequences[tokenId].eyes = newPartIndex;
            return;
        } else if (dnaSequence.nose == 0) {
            dnaSequences[tokenId].nose = newPartIndex;
            return;
        } else if (dnaSequence.mouth == 0) {
            dnaSequences[tokenId].mouth = newPartIndex;
            return;
        }

        // If no parts are missing, choose the part to mutate.
        uint256 partIndex = generateRandomNumber(8);

        if (partIndex == 1) {
            dnaSequence.arms = getIndex(dnaSequence.arms, newPartIndex);
        } else if (partIndex == 2) {
            dnaSequence.body = getIndex(dnaSequence.body, newPartIndex);
        } else if (partIndex == 3) {
            dnaSequence.legs = getIndex(dnaSequence.legs, newPartIndex);
        } else if (partIndex == 4) {
            dnaSequence.wings = getIndex(dnaSequence.wings, newPartIndex);
        } else if (partIndex == 5) {
            dnaSequence.ears = getIndex(dnaSequence.ears, newPartIndex);
        } else if (partIndex == 6) {
            dnaSequence.eyes = getIndex(dnaSequence.eyes, newPartIndex);
        } else if (partIndex == 7) {
            dnaSequence.nose = getIndex(dnaSequence.nose, newPartIndex);
        } else if (partIndex == 8) {
            dnaSequence.mouth = getIndex(dnaSequence.mouth, newPartIndex);
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