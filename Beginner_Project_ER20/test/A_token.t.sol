// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {A_token} from "../src/A_token.sol";
import {Deploy_A_token} from "../script/A_token.s.sol";

contract CounterTest is Test {
    A_token public Atk;
    Deploy_A_token public deployer;

    function setUp() public 
    {
        
        deployer=new Deploy_A_token();
        Atk = deployer.run();
        Atk = new A_token(1000 ether);
    }
    
    function test_transfer() public 
    {
        address recipient = address(0x123);
        uint256 amount = 10 ether;
        Atk.transfer(recipient, amount);
        uint256 senderBalance = Atk.balanceOf(address(this));
        assertEq(senderBalance, 990 ether);
        uint256 recipientBalance = Atk.balanceOf(recipient);
        assertEq(recipientBalance, amount);
    }

    function test_approve() public 
    {
        address spender = address(0x123);
        uint256 amount = 50 ether;
        Atk.approve(spender, amount);
        uint256 allowance = Atk.allowance(address(this), spender);
        assertEq(allowance, amount);
    }

    function test_transferFrom() public 
    {
        address lender = address(0x123);
        address spender = address(0x456);

        Atk.transfer(lender,30 ether);
        assertEq(Atk.balanceOf(lender), 30 ether);

        Atk.approve_1(lender,spender, 20 ether);
        Atk.transferFrom(lender, spender, 15 ether);    //would succeed
        assertEq(Atk.balanceOf(lender), 15 ether);
        assertEq(Atk.balanceOf(spender), 15 ether);
        
    }
}
