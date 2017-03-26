pragma solidity ^0.4.8;

contract Coinit {
    
    struct Account {
        address addr;
        int amount;
        bool validated;
        bool exist;
    }
    
    struct TinyAccount {
        address addr;
        int amount;
    }
    
    mapping (address => Account) accounts;
    
    address[] private accountsArray;

    TinyAccount[] private amountToBePaidOut;

    address private admin;

    function Coinit() {
        admin = msg.sender;
        Genesis(msg.sender);
    }

    function validateEmployee(address _emplyeeAdr) isAdmin() {
        Account acc = accounts[_emplyeeAdr];
        accounts[_emplyeeAdr].validated = true;
        accountsArray.push(_emplyeeAdr);
        Validate(_emplyeeAdr, true);
    }
    
    function createAccount(string _name, string _mail)  returns(bool success) {
        accounts[msg.sender] = Account({addr: msg.sender, amount: 0, validated: false, exist: true});
        AccountCreated(msg.sender, 0, _name, _mail, false);
        return true;
    }

    function createAndSendCoin(address _receiver, int _amount) isAdmin returns(bool) {
        Account acc = accounts[_receiver];
        accounts[_receiver].amount += _amount;
        Transfer(msg.sender, _receiver, _amount);
        return true;
    }

    function sendCoin(address _receiver, int _amount) onlyWithBalanceMoreThan(_amount) returns(bool sufficient) {
        accounts[msg.sender].amount -= _amount;
        accounts[_receiver].amount += _amount;
        Transfer(msg.sender, _receiver, _amount);
        return true;
    }

    function markForPayOutOnNextSalary(address _addr, int _amount) isAdmin returns(bool sufficient) {
        amountToBePaidOut.push(TinyAccount(_addr, _amount));
        MarkForPayOut(_addr, _amount);
        return true;
    }

    function payOutOnNextSalary(int _amount) returns(bool sufficient) {
        return markForPayOutOnNextSalary(msg.sender, _amount);
    }
    
    function payOut() isAdmin {
        for (uint i = 0; i < amountToBePaidOut.length; i++) {
            address addr = amountToBePaidOut[i].addr;
            int amount = amountToBePaidOut[i].amount;
            accounts[addr].amount -= amount;
            PayOut(addr, amount);
        }
        delete amountToBePaidOut;
    }
    
    function createAndGiveMoneyToAllEmployees(int _amount) isAdmin {
        for (uint i = 0; i < accountsArray.length; i++) {
            createAndSendCoin(accountsArray[i], _amount);
        }
    }

    function kill() isAdmin {
        selfdestruct(admin);
    }

    function accountExists() constant returns(bool) {
        return accounts[msg.sender].exist == true;
    }
    
    function getBalance() constant returns(int) {
        return accounts[msg.sender].amount;
    }

    function getBalance(address adr) constant returns(int) {
        Account acc = accounts[adr];
        return acc.amount;
    }

    function getValidated(address _addr) constant returns(bool) {
        return accounts[_addr].validated;
    }

    function isAccountAdmin() constant returns(bool) {
        return admin == msg.sender;
    }

    function isAccountAdmin(address _addr) constant returns(bool) {
        return admin == _addr;
    }

    function getAdminAddr() constant returns(address) {
        return admin;
    }

    function getSenderAddr() constant returns(address) {
        return msg.sender;
    }

    function getNumberOfValidatedEmployees() constant returns(uint) {
        return accountsArray.length;
    }

    modifier isValidated() {
        if (accounts[msg.sender].validated == true) _;
    }

    modifier isAdmin() {
        if (msg.sender != admin)
            throw;
        _;
    }

    modifier onlyWithBalanceMoreThan(int _amount) {
        if (accounts[msg.sender].amount >= _amount) _;
    }

    event Transfer(address indexed _from, address indexed _to, int _value);

    event Validate(address indexed _employee, bool _value);
    
    event Genesis(address indexed _admin);

    event PayOut(address indexed _account, int _value);

    event MarkForPayOut(address indexed _account, int _value);
    
    event AccountCreated(address _addr, int amount, string _name, string _mail, bool validated);
}