// ------- Lesson3 - Remix storage factory -------

//SPDX-License-Identifier: MIT
pragma solidity 0.8.15;

import "./SimpleStorage.sol";

contract StorageFactory {

    SimpleStorage[] public simpleStorageArray;

    function createSimpleStorageContract() public {
        SimpleStorage simpleStorage = new SimpleStorage(); // The new keyword deploys a contract from another contract
        simpleStorageArray.push(simpleStorage);
    }

    // this function is created with the purpose of saving a new simple storage contract in the array
    function sfStore(uint256 _simpleStorageIndex, uint256 _simpleStorageNumber) public {
        // To access any smart contract we need an Address and an ABI
        SimpleStorage simpleStorage = simpleStorageArray[_simpleStorageIndex];
        simpleStorage.store(_simpleStorageNumber);
    }

    function sfGet(uint256 _simpleStorageIndex) public view returns(uint256) {
        SimpleStorage simpleStorage = simpleStorageArray[_simpleStorageIndex];
        return simpleStorage.retreive();
    }
}
