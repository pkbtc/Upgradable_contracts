// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.0;

import {Test} from "forge-std/Test.sol";
import {DeployBox} from "../script/Deploy.s.sol";
import {UpgradeBox} from "../script/upgrade.s.sol";
import {BoxV2} from "../src/BoxV2.sol";
import {BoxV1} from "../src/BoxV1.sol";

contract DeployAndUpgradeTest is Test {
    DeployBox deployer;
    UpgradeBox upgrader;
    address public onwer=makeAddr("OWNER");
    address public proxy;
    function setUp() public{
        deployer = new DeployBox();
        upgrader = new UpgradeBox();
        proxy=deployer.run();
    }

    function testUpgrade() public{
        BoxV2 boxV2 = new BoxV2();
        upgrader.upgradeBox(proxy,address(boxV2));

        uint expectedValue=2;
        assertEq(expectedValue, BoxV2(proxy).version());

        
    }

    function testGetNumber() public {
        BoxV2 boxV2 = new BoxV2();
        upgrader.upgradeBox(proxy,address(boxV2));

        BoxV2(proxy).setNumber(10);
        uint expect=10;
        assertEq(expect, BoxV2(proxy).getNumber());
        
    }
}