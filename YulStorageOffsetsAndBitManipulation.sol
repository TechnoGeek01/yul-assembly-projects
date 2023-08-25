// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.19;

contract YulStorageOffsetsAndBitShifting {
    uint128 public A = 1;
    uint96 public B = 2;
    uint16 public C = 3;
    uint8 public D = 4;

    function readValueBySlot(uint slot) external view returns (uint value) {
        assembly {
            value := sload(slot)
        }
    }

    function getOffsetOfC() external pure returns (uint slot, uint offset) {
        assembly {
            slot := C.slot
            offset := C.offset
        }
    }

    function readC() external view returns (uint c) {
        assembly {
            let value := sload(C.slot)
            let shifted := shr(mul(C.offset, 8), value)

            c := and(0xffff, shifted)
        }
    }

    function writeToC(uint16 newC) external {
        assembly {
            let c := sload(C.slot)
            let clearedC := and(
                c,
                0xffff0000ffffffffffffffffffffffffffffffffffffffffffffffffffffffff
            )

            let shiftedNewC := shl(mul(C.offset, 8), newC)
            let newVal := or(shiftedNewC, clearedC)

            sstore(C.slot, newVal)
        }
    }

    // dangerous to do
    function writeValueToASlot(uint slot, uint value) external {
        assembly {
            sstore(slot, value)
        }
    }
}
