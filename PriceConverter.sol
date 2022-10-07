// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

library PriceConverter{
    function getPrice() internal view returns(uint256){
        // address  0xA39434A63A52E749F02807ae27335515BA4b07F7
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0xA39434A63A52E749F02807ae27335515BA4b07F7);
        (,int256 price,,,) = priceFeed.latestRoudData();
        // multiply with 1e10 to match the length of wei
        return uint256(price * 1e10);
    }

    function getConversionRate(uint256 ethAmount) internal view returns(uint256){
        uint256 ethPrice = getPrice();
        uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1e18;
        return ethAmountInUsd;
    }
}