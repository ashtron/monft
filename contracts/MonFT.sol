// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./openzeppelin-contracts/token/ERC721/ERC721.sol";
import "./openzeppelin-contracts/utils/Counters.sol";

// https://docs.openzeppelin.com/contracts/4.x-rc/erc721

contract MonFT is ERC721 {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    constructor() ERC721("MonFT", "MFT") public {}

    function mintMon() public returns (uint256) {
        _tokenIds.increment();
        uint256 newMonId = _tokenIds.current();

        _mint(msg.sender, newMonId);

        return newMonId;
    }

    function transferMon(address from, address to, uint256 tokenId) public {
        safeTransferFrom(from, to, tokenId);
    }
}