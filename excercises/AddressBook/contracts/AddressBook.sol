// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import {Ownable} from "openzeppelin-contracts/contracts/access/Ownable.sol";

contract AddressBook is Ownable {
    /*
    Create an Ownable contract called AddressBook. In it include:

    A struct called Contact with properties for:
        id
        firstName
        lastName
        a uint array of phoneNumbers
    Additional storage for contacts
    Any other necessary state variables
    */
    struct Contact {
        uint id;
        string firstName;
        string lastName;
        uint[] phoneNumbers;
    }

    uint[] ids;
    mapping (uint=>Contact) public contacts;
    uint id;

    constructor(address owner) Ownable(owner) {

    }

    // Add Contact
    // The addContact function should be usable only by the owner of the contract. It should take in the necessary arguments to add a given contact's information to contacts
    function addContact(string calldata _firstName, string  calldata _lastName, uint[] memory _phoneNumbers) public onlyOwner returns (uint) {
        uint _id = id++;
        contacts[id] = Contact(
            _id,
            _firstName,
            _lastName,
            _phoneNumbers
        );
        ids.push(_id);
        return _id;
    }

    error ContactNotFound(uint id);
    // Delete Contact
    // The deleteContact function should be usable only by the owner and should delete the contact under the supplied _id number.
    function deleteContact(uint _id) public onlyOwner {
        delete contacts[_id];

        for (uint i = 0; i < ids.length; i++) {
            if (ids[i] == _id) {
                delete ids[i];
                return;
            }
        }

        revert ContactNotFound(_id);
    }

    // If the _id is not found, it should revert with an error called ContactNotFound with the supplied id number.

    // Get Contact
    // The getContact function returns the contact information of the supplied _id number. It reverts with ContactNotFound if the contact isn't present.
    function getContact(uint _id) public view returns (Contact memory) {
        return contacts[_id];
    }

    // Get All Contacts
    // The getAllContacts function returns an array with all of the user's current, non-deleted contacts.
    function getAllContacts() public view returns (Contact[] memory) {
        Contact[] memory r = new Contact[](ids.length);
        for (uint i = 0; i < ids.length; i++) {
            r[i] = contacts[ids[i]];
        }
        return r;
    }
}