// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

contract YulMax {
    // in yul there are no else statements
    function max(uint x, uint y) external pure returns (uint maximum) {
        assembly {
            if lt(x, y) {
                maximum := y
            }

            if iszero(lt(x, y)) {
                maximum := x
            }
        }
    }
}
