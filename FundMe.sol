// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;
import "./PriceConverter.sol";
contract FundMe{
    // library for price converstion
    using PriceConverter for uint256;
    // can not change value of constant variable after assign
    uint256 public constant MINIMUM_USD = 50 * 1e18;
    address[] public funders;
    mapping(address => uint256) public addressToAmountFunded;
    // immutable variable can assign only one time
    address public immutable i_owner;

    constructor(){
        i_owner = msg.sender;
    }

    // to send ammount ot contract
    function fund() public payable{
        // can send only if value is greater than on equal to MINIMUM_USD
        require(msg.value.getConversionRate() >= MINIMUM_USD, "Didn't send enough");
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] = msg.value;
    }

    // to with draw amount from contract
    function withdraw() public onlyOwner{
        // to empty array of sentders
        for(uint256 funderIndex; funderIndex < funders.length; funderIndex++){
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }
        funders = new address[](0);
        (bool callSuccess,) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess, "Call Failed");
    }

    // only admin can withdraw
    modifier onlyOwner{
        require(msg.sender == i_owner, "Sender is not Owner!");
        _;
    }

    receive() external payable{
        fund();
    }
    fallback() external payable{
        fund();
    }

}