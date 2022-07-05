 // SPDX-License-Identifier: MIT
 pragma solidity 0.8.15;

 import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
 
 library PriceConverter {
     
    // returns the price of 1 ethereum in terms of USD
    // this function is only used in the getConversionRate function
    function getPrice() internal view returns(uint256){
        // We need the ABI and the Address
        // Address: 0x8A753747A1Fa494EC906cE90E9f37563A8AF630e
        // ABI: 
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x8A753747A1Fa494EC906cE90E9f37563A8AF630e); //question: why the keyword "new" is not used?
        (,int256 price,,,) = priceFeed.latestRoundData();
        return uint256(price * 1e10); // question: I didn't understand why it's 1e10.
    }

    // returns the latest version of the chainlink's data feed library
    function getVersion() internal view returns(uint256) {
        AggregatorV3Interface agv3 = AggregatorV3Interface(0x8A753747A1Fa494EC906cE90E9f37563A8AF630e);
        return agv3.version();
    }

    // getting a number in terms of ETH, returns the equivalent in terms of USD
    function getConversionRate(uint256 ethAmount) internal view returns(uint256) {
        uint256 ethPrice = getPrice();
        uint256 ethAmountInUSD = (ethPrice * ethAmount) / 1e18;
        return ethAmountInUSD;
    }
  }
