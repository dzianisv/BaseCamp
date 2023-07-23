// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/HaikuNFT.sol";
import "lib/openzeppelin-contracts/contracts/token/ERC721/utils/ERC721Holder.sol";

contract NftTest is Test, ERC721Holder {
    HaikuNFT public nft;

    function setUp() public {
        nft = new HaikuNFT();
    }

    function testCreateHaiku() public {
        address[3] memory users;

        for (uint160 i = 1; i < 3; i++) {
            users[i] = address(i);
        }

        uint256 tokenId = nft.mintHaiku("hello", "base", "word");
        for (uint i = 0; i < users.length; i++) {
            nft.sharedHaikus(users[i], tokenId);
        }

        // for (uint i = 0; i < users.length; i++) {
        //     vm.prank(users[i]);
        //     nft.getMySharedHaikus();
        // }
    }
}
