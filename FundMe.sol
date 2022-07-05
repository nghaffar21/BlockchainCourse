//SPDX-License-Identifier: MIT
pragma solidity 0.8.15;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

import "./PriceConverter.sol";

error NotOwner();

// Smart contracts, just like wallets, have addresses. This means that smart contracts, 
// again just like wallets, can hold funds
contract FundMe {

  using PriceConverter for uint256;
  uint256 public constant MINIMUM_USD = 50 * 1e18;
  address public immutable i_owner; // the immutable keyword has the same function as the constant keyword,
                                    // except that we don't assign a value to our variable in the same line that we define it.
  address[] public funders;
  mapping(address => uint256) public addressToAmountFunded;              

  constructor() {
    i_owner = msg.sender;
  }

  // receives a fund from the user
  function fund() public payable {
    require( msg.value.getConversionRate() >= MINIMUM_USD, "You have to transfer at least 1 ETH.");
    funders.push(msg.sender);
    addressToAmountFunded[msg.sender] = msg.value;
  }

  function withdraw() public onlyOwner {
    // reset the mapping addressToAmountFunded
    for(uint256 funderIndex = 0; funderIndex < funders.length; funderIndex++){
      address funder = funders[funderIndex];
      addressToAmountFunded[funder] = 0;
    }

    // reset the array funders
    funders = new address[] (0);

    // withdraw the funds from this address to another address
    // there are three ways to do this:

    // transfer
    //payable(msg.sender).transfer(address(this).balance);
  
    // send
    //bool sendSuccess = payable(msg.sender).send(address(this).balance);
    //require(sendSuccess, "Send failed");

    // call --> recommended way
    (bool callSuccess, ) = payable(msg.sender).call{value: address(this).balance}("");
    require(callSuccess, "Call failed");
  }

  modifier onlyOwner {
    //require(msg.sender == i_owner, "Message sender is not the contract owner!");
    if(msg.sender != i_owner) { revert NotOwner(); }
    _;
  }

  receive() payable external {
    fund();
  }

  fallback() payable external {
    fund();
  }
}
