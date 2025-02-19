// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

import {Script} from "forge-std/Script.sol";
import {A_token} from "../src/A_token.sol";

contract Deploy_A_token is Script {
    uint256 public initialSupply=1000 ether;

    function run() public returns(A_token) {
        vm.startBroadcast();
        A_token Atk=new A_token(initialSupply);
        vm.stopBroadcast();
        return Atk;
    }
}
