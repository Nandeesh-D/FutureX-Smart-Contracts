// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.0;
 
import{Script,console} from "forge-std/Script.sol";
import{EventFactory} from "../src/EventFactory.sol";
import{Event} from "../src/Event.sol";
import{FeeAddress} from "../src/FeeAddress.sol";
import{USDCMock} from "../src/mocks/USDCMock.sol";
contract Deployments is Script{
    EventFactory factory;
    FeeAddress feeAddress;
    USDCMock usdc;
    uint256 owner=uint256(keccak256("owner private key"));
    function run() external returns(EventFactory _factory,FeeAddress _feeAddress,USDCMock _usdc){
        usdc=new USDCMock();
        feeAddress=new FeeAddress();
        
        vm.startBroadcast(owner);
        factory=new EventFactory(address(feeAddress),address(usdc));
        vm.stopBroadcast();
        
        console.log("usdc address",address(usdc));
        return(factory,feeAddress,usdc);
    }
}