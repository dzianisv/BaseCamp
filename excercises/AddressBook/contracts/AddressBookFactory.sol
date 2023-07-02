// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import {AddressBook} from "./AddressBook.sol";

contract AddressBookFactory {
    function deploy() public returns (address) {
        AddressBook book = new AddressBook(msg.sender);
        return address(book);
    }
}