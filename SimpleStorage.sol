// ------- Lesson2 - The Basics -------

//SPDX-License-Identifier: MIT
pragma solidity 0.8.15;

// a contract in solidity is the same as a class in OOP languages
contract SimpleStorage {
    
    // default value of uint in solidity is 0
    uint256 favoriteNumber;

    function store(uint256 _favoriteNumber) public virtual{
        favoriteNumber = _favoriteNumber;
    }

    // the blue buttons (on the "deploy" tab on the left of Remix), don't cost any gas. The orange buttons 
    // cost gas. There are two functions that don't pay gas; view and pure(unless they are called from a function 
    // that costs gas). An expression like "uint256 public favoriteNumber;" is a view function.
    // An equivalent of this expression is the following:
    
    function retreive() public view returns(uint256) {
        return favoriteNumber;
    }

    // ------- The structs and arrays -------
    // a struct; a struct is like a type, like uint256 and string
    People public person = People({favoriteNumber: 7, name: "Nima"});

    struct People{
        uint256 favoriteNumber;
        string name;
    }

    // create a list with the instances of the struct
    People[] public people;

    // ------- The mappings -------
    // arrays are not useful if we need the favorite number of a specific person while we have his name
    // that's why we use mappings in such case
    mapping(string => uint256) public nameToFavoriteNumber;

    /* 
    a function that adds items to the people array

    the memory, storage, and calldata keywords are used for array, struct, and mapping type variables 
    to specify if the variable is only used within the function, or it is used outside of the function as well.
    */
    function addPerson(string memory _name, uint256 _favoriteNumber) public {
        people.push(People({favoriteNumber: _favoriteNumber, name: _name}));
        nameToFavoriteNumber[_name] = _favoriteNumber;
    }
}
