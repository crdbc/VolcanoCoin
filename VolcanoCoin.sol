// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

contract VolcanoCoin {
    
    struct Payment{
        address recipient;
        uint amount;
    }
    
    uint total_supply = 10000;
    address owner;
    mapping(address => uint) balance;
    mapping(address => Payment[]) payments;
    
    event supply_increase(uint);
    event token_transfer(address, uint);
    
    constructor(){
        owner = msg.sender;
        balance[owner] = total_supply;
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
    
    function getUserBalance(address _userAddress) public view returns (uint){
        return balance[_userAddress];
    }
    
    function transfer(address _transferToAddress, uint _amount) public {
        payable(_transferToAddress).transfer(_amount);
        emit token_transfer(_transferToAddress, _amount);
    }
}
