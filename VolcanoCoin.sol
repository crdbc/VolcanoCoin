// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

contract VolcanoCoin {
    
    uint total_supply = 10000;
    address owner;
    
    event supply_increase(uint);
    
    constructor(){
        owner = msg.sender;
    }
    
    modifier onlyOwner {
        if(msg.sender == owner){
            _;
        }
    }
    
    function getTotalSupply() public view returns (uint){
        return total_supply;
    }
    
    function increaseTotalSupply() public onlyOwner {
        total_supply += 1000;
        emit supply_increase(total_supply);
    }
}
