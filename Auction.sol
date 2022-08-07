// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;


contract Auction{

    struct Bider {
        uint bid_ ;
        bool paybid;
        bool payBack;
        uint timeofattend;
    }

    mapping(address => Bider) Biders ;

    uint public hiestBid;

    address public hiestBider;

    address public beneficiary;

    uint public endTime;

    constructor(address _beneficiary , uint _hiestBid , uint deadline){

        beneficiary=_beneficiary;

        hiestBid = _hiestBid;

        endTime = block.timestamp + deadline;

    }

    function Bid() public payable{

        require(block.timestamp < endTime , "Auction was ended !");
        require(msg.value > hiestBid , "your bid is lower than hiest bid !");

        if(hiestBider != address(0)){

            bool result = payable(hiestBider).send(hiestBid);
            Biders[hiestBider].payBack = true;

        }

        Biders[msg.sender].bid_ = msg.value;
        Biders[msg.sender].paybid = true;
        Biders[msg.sender].payBack = false;
        Biders[msg.sender].timeofattend += 1;

        hiestBid= msg.value;
        hiestBider = msg.sender;
    }

    function Show_bider_info() public view returns(Bider memory){

        return Biders[msg.sender] ;


    }


    function Show_Hiestbider_info() public view returns(Bider memory){

        return Biders[hiestBider] ;


    }


}
