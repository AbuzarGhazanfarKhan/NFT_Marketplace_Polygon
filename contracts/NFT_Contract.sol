// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract NFT is ERC721URIStorage {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    address contractAddress; // Address of this contract to be able to interact with it

    // To give nft market the ability to transact these tokens or change the ownership,of the tokens from a seprate contract

    constructor(address marketplaceAddress) ERC721("PropertyToken", "PRT") {
        contractAddress = marketplaceAddress;
    }

    function createToken(string memory tokenURI) public returns (uint256) {
        _tokenIds.increment();
        uint256 newTokenId = _tokenIds.current();

        _mint(msg.sender, newTokenId);
        _setTokenURI(newTokenId, tokenURI);
         // To give nft market the ability to transact these tokens or change the ownership,of the tokens from a seprate contract
        setApprovalForAll(contractAddress, true);
        return newTokenId;
    }
}
