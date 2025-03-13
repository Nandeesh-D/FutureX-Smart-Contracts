// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Event} from "./Event.sol";

contract EventFactory {
    address public owner;
    address public feeAddress;
    address immutable usdc;
    address[] public createdEvents;

    event EventCreated(
        address indexed eventAddress,
        string description,
        uint deadline
    );

    modifier onlyOwner() {
        require(msg.sender == owner, "Not authorized");
        _;
    }

    constructor(address _feeAddress,address _usdc) {
        owner = msg.sender;
        feeAddress=_feeAddress;
        usdc=_usdc;
    }

    function createEvent(
        string memory _description,
        uint _deadline
        
    ) external onlyOwner {
        Event newEvent = new Event(
            _description,
            _deadline,
            msg.sender,
            usdc,
            feeAddress
        );
        createdEvents.push(address(newEvent));

        emit EventCreated(address(newEvent), _description, _deadline);
    }

    function updateFeeAddress(address protcolFeeAddress) external onlyOwner{
        require(feeAddress!=address(0),"Zero address");
        feeAddress=protcolFeeAddress;
    }

    function getDeployedEvents() external view returns (address[] memory) {
        return createdEvents;
    }
}
