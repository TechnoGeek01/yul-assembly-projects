// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

contract YulArraysAndMappings {
    uint[3] fixedArray;
    uint[] dynamicBigArray;
    uint8[] dynamicSmallArray;

    mapping(uint => uint) myMapping;
    mapping(uint => mapping(uint => uint)) nestedMapping;
    mapping(address => uint[]) addressToList;

    constructor() {
        fixedArray = [234, 4235, 5345];
        dynamicBigArray = [10, 20, 30];
        dynamicSmallArray = [11, 12, 13];

        myMapping[10] = 5;
        myMapping[11] = 6;
        nestedMapping[2][4] = 7;

        addressToList[0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db] = [
            5345,
            3645,
            6474
        ];
    }

    function readFixedArray(uint index) external view returns (uint ret) {
        assembly {
            ret := sload(add(fixedArray.slot, index))
        }
    }

    function dynamicBigArrayLength() external view returns (uint ret) {
        assembly {
            ret := sload(fixedArray.slot)
        }
    }

    function readDynamicBigArray(uint index) external view returns (uint ret) {
        uint slot;

        assembly {
            slot := dynamicBigArray.slot
        }

        bytes32 location = keccak256(abi.encode(slot));

        assembly {
            ret := sload(add(location, index))
        }
    }

    function readDynamicSmallArray(
        uint index
    ) external view returns (bytes32 ret) {
        uint slot;

        assembly {
            slot := dynamicSmallArray.slot
        }

        bytes32 location = keccak256(abi.encode(slot));

        assembly {
            ret := sload(add(location, index))
        }
    }

    function getMapping(uint key) external view returns (uint ret) {
        uint slot;

        assembly {
            slot := myMapping.slot
        }

        bytes32 location = keccak256(abi.encode(key, uint(slot)));

        assembly {
            ret := sload(location)
        }
    }

    function getNestedMapping() external view returns (uint ret) {
        uint slot;

        assembly {
            slot := nestedMapping.slot
        }

        bytes32 location = keccak256(
            abi.encode(
                uint256(4),
                keccak256(abi.encode(uint256(2), uint256(slot)))
            )
        );

        assembly {
            ret := sload(location)
        }
    }

    function lengthOfNestedList() external view returns (uint ret) {
        uint slot;

        assembly {
            slot := addressToList.slot
        }

        bytes32 location = keccak256(
            abi.encode(
                address(0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db),
                uint256(slot)
            )
        );

        assembly {
            ret := sload(location)
        }
    }

    function getAddressToList(uint index) external view returns (uint ret) {
        uint slot;

        assembly {
            slot := addressToList.slot
        }

        bytes32 location = keccak256(
            abi.encode(
                keccak256(
                    abi.encode(
                        address(0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db),
                        uint256(slot)
                    )
                )
            )
        );

        assembly {
            ret := sload(add(location, index))
        }
    }
}
