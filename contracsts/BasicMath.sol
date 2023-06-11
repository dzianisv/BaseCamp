// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

contract BasicMath {
    function adder(uint _a, uint _b) public pure returns (uint, bool) {
        // tested on (2**256 - 1) 115792089237316195423570985008687907853269984665640564039457584007913129639935
        if (_a > (type(uint).max - _b)) {
            return (0, true);
        }

        return (_a + _b, false);
    }

    function subtractor(uint _a, uint _b) public pure returns (uint, bool) {
        if (_a < _b) {
            return (0, true);
        }
        return (_a - _b, false);
    }
}