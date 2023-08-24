// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

contract YulStorage {
    uint x;
    uint y = 1;
    uint z = 2;

    function getVarX() external view returns (uint ret) {
        assembly {
            ret := sload(x.slot)
        }
    }

    function getVarFromSlot(uint slot) external view returns (uint ret) {
        assembly {
            ret := sload(slot)
        }
    }

    function setVarY(uint newVal) external {
        assembly {
            sstore(y.slot, newVal)
        }
    }

    // dangerous to do
    function setVarToSlot(uint slot, uint value) external {
        assembly {
            sstore(slot, value)
        }
    }

    function getSlotOfX() external pure returns (uint slot) {
        assembly {
            slot := x.slot
        }
    }
}
