pragma solidity ^0.4.8;

contract Coinit {
    
    struct Account {

    }

    function Coinit() {
        Genesis(msg.sender);
    }

    function validateEmployee(address _emplyeeAdr) isAdmin {

    }
    
    function createAccount(string _name, string _mail)  returns(bool success) {

    }

    function createAndSendCoin(address _receiver, int _amount) isAdmin returns(bool) {

    }

    function sendCoin(address _receiver, int _amount) returns(bool sufficient) {

    }

    function markForPayOutOnNextSalary(address _addr, int _amount) isAdmin returns(bool sufficient) {

    }

    function payOutOnNextSalary(int _amount) returns(bool sufficient) {

    }
    
    function payOut() isAdmin {

    }
    
    function createAndGiveMoneyToAllEmployees(int _amount) isAdmin {

    }

    function kill() isAdmin {

    }

    function accountExists() constant returns(bool) {

    }
    
    function getBalance() constant returns(int) {

    }

    function getBalance(address adr) constant returns(int) {

    }

    function getValidated(address _addr) constant returns(bool) {

    }

    function isAccountAdmin() constant returns(bool) {

    }

    function isAccountAdmin(address _addr) constant returns(bool) {

    }

    function getAdminAddr() constant returns(address) {

    }

    function getSenderAddr() constant returns(address) {

    }

    function getNumberOfValidatedEmployees() constant returns(uint) {

    }

    modifier isAdmin() {
        _;
    }

    event Transfer(address indexed _from, address indexed _to, int _value);

    event Validate(address indexed _employee, bool _value);
    
    event Genesis(address indexed _admin);


}