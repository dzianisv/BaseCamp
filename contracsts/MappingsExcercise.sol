// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

// ["Thriller", "Back in Black", "The Bodyguard", "The Dark Side of the Moon", "Their Greatest Hits (1971-1975)", "Hotel California", "Come On Over", "Rumours", "Saturday Night Fever"]

contract FavoriteRecords {
    // State Variables
    string[] public approvedRecordNames;
    mapping(string => bool) public approvedRecords;

    mapping(address => mapping(string => bool)) userFavorites;

    constructor(string[] memory _preappoved) {
        for(uint i = 0; i < _preappoved.length; i++) {
           approveRecord(_preappoved[i]);
        }
    }

    function approveRecord(string memory _name) private {
        require(!approvedRecords[_name], "record is already approved");
        approvedRecordNames.push(_name);
        approvedRecords[_name] = true;
    }

    // Add Record to Favorites
    function addRecord(string memory _record) public {
        if(approvedRecords[_record]){
            userFavorites[msg.sender][_record] = true;
        } else {
            revert NotApproved(_record);
        }
    }

    error NotApproved(string _record);

    // Get Approved Records
    function getApprovedRecords() public view returns(string[] memory) {
        return approvedRecordNames;
    }

    // Get User's Favorites
    function getUserFavorites(address _user) public view returns(string[] memory) {
        string[] memory favorites = new string[](approvedRecordNames.length);
        uint counter = 0;
        for(uint i = 0; i < approvedRecordNames.length; i++) {
            if(userFavorites[_user][approvedRecordNames[i]]) {
                favorites[counter++] = approvedRecordNames[i];
            }
        }

        // Resize the array
        string[] memory returnFavorites = new string[](counter);
        for(uint i = 0; i < counter; i++) {
            returnFavorites[i] = favorites[i];
        }

        return returnFavorites;
    }

    // Reset User's Favorites
    function resetUserFavorites() public {
        for(uint i = 0; i < approvedRecordNames.length; i++) {
            userFavorites[msg.sender][approvedRecordNames[i]] = false;
        }
    }
}
