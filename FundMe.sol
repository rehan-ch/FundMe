pragma solidity ^"0.8.0";
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
contract FundMe{
  uint256 public minimumUsd = 50;
  require(msg.value >= minimumUsd, "Didn't send enough");

  function getPrice() public view returns(uint256){
    // address  0xA39434A63A52E749F02807ae27335515BA4b07F7
    AggregatorV3Interface priceFeed = AggregatorV3Interface(0xA39434A63A52E749F02807ae27335515BA4b07F7)
    (, int256 price, , , ) = priceFeed.latestRoudData();
    return unint256(price * 1e10);
  }

  function getConversionRate(uint256 ethAmount) public view returns(uint256){
    uint256 ethPrice = getPrice();
    uint256n ethAmountInUsd = (ethPrice * ethAmount) / 1e18;
    return ethAmountInUsd;
  }

}