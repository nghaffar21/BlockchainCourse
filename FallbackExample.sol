// SPDX-License-Identifier: MIT
pragma solidity 0.8.15;

contract FallbackExample {
    uint256 public result = 0;

    receive() external payable {
        result = 1;
    }

    fallback() external payable {
        result = msg.value;
    }
}
