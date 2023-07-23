// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

import "lib/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol";

contract HaikuNFT is ERC721 {
    uint256 public counter = 1;

    struct Haiku {
        address author;
        string line1;
        string line2;
        string line3;
    }

    Haiku[] public haikus;

    // mapping from address to haiku id
    mapping(address => uint256[]) public sharedHaikus;

    // mapping from haiku line to bool
    mapping(string => bool) private _lineExists;

    constructor() ERC721("HaikuNFT", "HNFT") {
        haikus.push();
    }

    /*
    Add a function called mintHaiku that takes in the three lines of the poem. This function should mint an NFT for the minter and save their Haiku.
    Haikus must be unique! If any line in the Haiku has been used as any line of a previous Haiku, revert with HaikuNotUnique().
    You don't have to count syllables, but it would be neat if you did! (No promises on whether or not we counted the same as you did)
    */
    function mintHaiku(string memory line1, string memory line2, string memory line3) public returns (uint256) {
        if(_lineExists[line1] || _lineExists[line2] || _lineExists[line3]) {
            revert HaikuNotUnique();
        }

        Haiku memory newHaiku = Haiku(msg.sender, line1, line2, line3);
        haikus.push(newHaiku);

        _lineExists[line1] = true;
        _lineExists[line2] = true;
        _lineExists[line3] = true;

        _safeMint(msg.sender, counter);
        counter++;
        return counter - 1;
    }

    function shareHaiku(address _to, uint256 _tokenId) public {
        require(_isApprovedOrOwner(msg.sender, _tokenId), "ERC721: transfer caller is not owner nor approved");
        sharedHaikus[_to].push(_tokenId);
    }

    /*
    Add a function called getMySharedHaikus. When called, it should return an array containing all of the haikus shared with the caller.
    If there are no haikus shared with the caller's wallet, it should revert with a custom error of NoHaikusShared, with no arguments.
    */
    function getMySharedHaikus() public view returns(Haiku[] memory){
        uint256[] memory ids = sharedHaikus[msg.sender];
        if(ids.length == 0){
            revert NoHaikusShared();
        }

        Haiku[] memory arr = new Haiku[](ids.length);
        for(uint i = 0; i < ids.length; i++){
            arr[i] = haikus[ids[i] - 1];
        }

        return arr;
    }

    error HaikuNotUnique();
    error NoHaikusShared();
}
