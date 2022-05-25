// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

contract NFTMarketplace is ReentrancyGuard {

    using Counters for Counters.Counter;
    Counters.Counter private _itemIds; // Counter for each indivisuao items for sale
    Counters.Counter private _itemSold; //counter for number of items sold 

    // Numbr of items i bought  myself
    //number of items I creatd Myself
    //Number of items that are currently not sold

    address payable owner; // Owner of the contract

    // Commission Fee
    uint256 listingPrice=0.0025 ether;

    constructor(){
        owner= payable(msg.sender);
    }

    struct MarketItem{
        uint itemId;
        address nftContract;
        uint256 tokenId;
        address payable seller;
        address payable owner;
        uint256 price;
        bool sold;

    }

    mapping(uint256 => MarketItem) private idToMarketItem;

    // Event for when market item created

    event MarketItemCreated (
        uint indexed itemId,
        address indexed nftContract,
        uint256 indexed tokenId,
        address payable seller,
        address payable owner,
        uint256 price,
        bool sold
    );
    // FUnction to return the listing price
    function getListingPrice() public view returns (uint256){
        return listingPrice;
    }
    // function for creating Market item
    // function for creating Market sale
    function createMarketItem(
        address nftContract,
        uint256 tokenId,
        uint256 price
    ) public payable nonReentrant {
        require(price > 0,"price must be at least 1 wei");
        require(msg.value == listingPrice,"Price must be equal to Listing Price"));

        _itemIds.increment();
        uint256 itemId=_itemId.current();

        idToMarketItem[itemId] = MarketItem(
        itemId,
        nftContract,
        tokenId,
        payable(msg.sender),
        payable(address(0)),
        price,
        false
        );
    }
 
}