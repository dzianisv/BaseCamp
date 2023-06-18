// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

// https://docs.base.org/base-camp/docs/arrays/arrays-exercise

contract ArraysExercise {
    uint256[] public numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
    address[] senders;
    uint256[] timestamps;

    // Write a function called getNumbers that returns the entire numbers array.
    function getNumbers() public view returns (uint256[] memory) {
        return numbers;
    }

    // Write a public function called resetNumbers that resets the numbers array to its initial value, holding the numbers from 1-10.
    function resetNumbers() public {
        delete numbers;

        for (uint256 i = 1; i <= 10; i++) {
            numbers.push(i);
        }
    }

    // Write a function called appendToNumbers that takes a uint[] calldata array called _toAppend, and adds that array to the storage array called numbers, already present in the starter.
    // [1] gas 90560
    // [1,2, 3] 143250
    // [0, 1, 2, 3, 4, 5, 6, 7, 8, 9] gas 304770
    function appendToNumbers2(uint256[] calldata _toAppend) public {
        uint256[] memory temp = new uint256[](
            numbers.length + _toAppend.length
        );

        for (uint256 i = 0; i < numbers.length; i++) {
            temp[i] = numbers[i];
        }

        for (uint256 i = 0; i < _toAppend.length; i++) {
            temp[numbers.length + i] = _toAppend[i];
        }

        numbers = temp;
    }

    // [1] gas 56898
    // [1, 2, 3] gas 109326
    // [0, 1, 2, 3, 4, 5, 6, 7, 8, 9] gas 269927
    function appendToNumbers(uint256[] calldata _toAppend) public {
        for (uint256 i = 0; i < _toAppend.length; i++) {
            numbers.push(_toAppend[i]);
        }
    }

    /*
        Write a function called saveTimestamp that takes a uint called _unixTimestamp as an argument.
        When called, it should add the address of the caller to the end of senders and the _unixTimeStamp to timestamps.
    */
    function saveTimestamp(uint256 _unixTimestamp) public {
        senders.push(msg.sender);
        timestamps.push(_unixTimestamp);
    }

    /*
        Write a function called afterY2K that takes no arguments. When called, it should return two arrays.
        The first should return all timestamps that are more recent than January 1, 2000, 12:00am. To save you a click, the Unix timestamp for this date and time is 946702800.
        The second should return a list of senders addresses corresponding to those timestamps.
    */
    function afterY2K()
        public
        view
        returns (uint256[] memory, address[] memory)
    {
        uint256 count = 0;

        // count the number of timestamps after Y2K
        for (uint256 i = 0; i < timestamps.length; i++) {
            if (timestamps[i] > 946702800) {
                count++;
            }
        }

        // initialize arrays to hold the timestamps and addresses
        uint256[] memory postY2Ktimestamps = new uint256[](count);
        address[] memory correspondingSenders = new address[](count);

        uint256 index = 0;
        for (uint256 i = 0; i < timestamps.length; i++) {
            if (timestamps[i] > 946702800) {
                postY2Ktimestamps[index] = timestamps[i];
                correspondingSenders[index] = senders[i];
                index++;
            }
        }

        return (postY2Ktimestamps, correspondingSenders);
    }

    // Add public functions called resetSenders and resetTimestamps that reset those storage variables.
    function resetSenders() public {
        delete senders;
    }

    // Add public functions called resetSenders and resetTimestamps that reset those storage variables.
    function resetTimestamps() public {
        delete timestamps;
    }
}
