// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

import "forge-std/Test.sol";
import "../src/UnburnableToken.sol";

contract TokenTest is Test {
    UnburnableToken public token;

    function setUp() public {
        token = new UnburnableToken();
    }

    function testClaim() public {
        token.claim();
    }

    function test_RevertIf_DoubleClaimed() public {
        token.claim();
        vm.expectRevert();
        token.claim();
    }

    function test_RevertIf_TransferNotFoundedAccount() public {
        token.claim();
        vm.expectRevert();
        token.safeTransfer(address(0x1), 1);
    }

    function test_RevertIf_BurnTokens() public {
        token.claim();
        vm.expectRevert();
        token.safeTransfer(address(0x0), 1);
    }
}
