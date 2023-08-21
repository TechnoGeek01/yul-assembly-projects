// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

contract YulIsPrime {
    function isPrime(uint x) public pure returns (bool p) {
        p = true;
        assembly {
            let halfX := add(div(x, 2), 1)

            for {
                let i := 2
            } lt(i, halfX) {
                i := add(i, 1)
            } {
                if iszero(mod(x, i)) {
                    // eq(mod(x,i),0) and iszero(mod(x, i)) are same
                    p := 0
                    break
                }
            }
        }
    }
}
