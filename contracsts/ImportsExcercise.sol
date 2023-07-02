// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import {SillyStringUtils} from "./SillyStringUtils.sol";

// Create a contract called ImportsExercise. It should import a copy of SillyStringUtils
contract ImportsExercise {
    using SillyStringUtils for string;

    SillyStringUtils.Haiku public haiku;

    // saveHaiku should accept three strings and save them as the lines of haiku.
    function saveHaiku(
        string calldata _line1,
        string calldata _line2,
        string calldata _line3
    ) public {
        haiku.line1 = _line1;
        haiku.line2 = _line2;
        haiku.line3 = _line3;
   }

    // getHaiku should return the haiku as a Haiku type.
    function getHaiku() public view returns (SillyStringUtils.Haiku memory) {
        return haiku;
    }

    // shruggieHaiku should use the library to add 🤷 to the end of line3. It must not modify the original haiku.
    function shruggieHaiku() public view returns (SillyStringUtils.Haiku memory) {
        SillyStringUtils.Haiku memory newHaiku = haiku;
        newHaiku.line3 = newHaiku.line3.shruggie();
        return newHaiku;
    }
}