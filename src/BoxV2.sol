// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.0;
import {UUPSUpgradeable} from "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";
contract BoxV2 is  UUPSUpgradeable{

    uint256 internal number;

   


    function setNumber(uint _number) external{
        number = _number;
    }
    function getNumber() external view returns(uint256){
        return number;

    }
    function version() public pure returns(uint256) {
        return 2;
    }

    function _authorizeUpgrade(address newImplementation) internal override{

    }
    
}