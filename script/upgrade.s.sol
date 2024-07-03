// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";
import {BoxV2} from "../src/BoxV2.sol";
import {BoxV1} from "../src/BoxV1.sol";
contract UpgradeBox is Script {
    function run() external returns(address){
        address mostRecentDeployment=DevOpsTools.get_most_recent_deployment("ERC1976Proxy", block.chainid);
        vm.startBroadcast();
        BoxV2 newBox = new BoxV2();
        vm.stopBroadcast();
        address _proxy=upgradeBox(mostRecentDeployment,address(newBox));
        return _proxy;
    }
    function upgradeBox(address proxy,address newBox) public returns(address){
        vm.startBroadcast();
        BoxV1 proxyADD=BoxV1(proxy);
        proxyADD.upgradeToAndCall(newBox, "");
        vm.stopBroadcast();
        return address(proxyADD);
    }
}