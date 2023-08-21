// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

// The only type yul has is a 32 byte word (256 bits)

contract YulTypes {
    function demoNumber() external pure returns (uint x) {
        x;

        assembly {
            x := 42
        }
    }

    function demoHex() external pure returns (uint x) {
        x;

        assembly {
            x := 0xa
        }
    }

    function demoString() external pure returns (string memory) {
        bytes32 myString = "";

        assembly {
            myString := "hello world" // if its more than 32 bytes it won't fit into myString and won't compile
        }

        return string(abi.encode(myString));
    }

    function demoBool() external pure returns (bool x) {
        x;

        assembly {
            x := 1 // 0 -> false, anything above 0 -> true
        }
    }

    function demoAddress() external pure returns (address x) {
        x;

        assembly {
            x := 1 // 0x0000000000000000000000000000000000000001
        }
    }
}
