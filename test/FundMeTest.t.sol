//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {FundMe} from "../src/FundMe.sol";
import {Test} from "forge-std/Test.sol";
import {console} from "forge-std/console.sol";
import {DeployFundMe} from "../script/DeployFundMe.s.sol";
contract FundMeTest is Test{
    FundMe fundMe;
    function setUp() external {
      DeployFundMe deployFundMe = new DeployFundMe();
      fundMe = deployFundMe.run();
    }

    function testMinimumDollarIsFive()  public {
      assertEq(fundMe.MINIMUM_USD(), 5e18);

    }

    function testOwnerIsMsgSender() public {
        console.log(msg.sender);
        console.log(fundMe.i_owner());
        assertEq(fundMe.i_owner(), msg.sender);
    }

    function testPriceFeedVersion() public {
        console.log(fundMe.getVersion());
    }

}