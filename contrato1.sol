// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.15;


contract Contrato{

    uint public balance;
    address owner;
    
    struct Transaction{
        address owner;
        uint balance;
        uint changeBalance;
        string status;
    }

    Transaction[] public historic;



    modifier onlyOwner(){
        require(msg.sender == owner, "You don't have access");
        _;
    }
    
    constructor(){ //salva a informação quando roda a primeira vez
        owner = msg.sender;
    }

    function sendBalance(uint changeBalance, string memory status) public onlyOwner{
        require(changeBalance <= balance, "You don't have enough balance");
        balance = balance - changeBalance;
        status = "Send";
        Transaction memory newTransaction = Transaction(owner, balance, changeBalance, status);
        historic.push(newTransaction);
    }

    function receiveBalance(uint changeBalance, string memory status) public{
        balance = balance + changeBalance;
        status = "Receive";
        Transaction memory newTransaction = Transaction(owner, balance, changeBalance, status);
        historic.push(newTransaction);
    }

    function checkBalance() public view returns(uint){
        return(balance);

    }

    function changeOwner(address newOwner) public onlyOwner{
        owner = newOwner;
    }

    function viewHistoric() public view onlyOwner returns(Transaction[] memory){
        return historic;
    }


}