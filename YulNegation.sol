// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

contract YulNegation {
    function negation(bool x) external pure returns (uint result) {
        result = 1;
        assembly {
            if iszero(x) {
                result := 2
            }
        }
    }
}
