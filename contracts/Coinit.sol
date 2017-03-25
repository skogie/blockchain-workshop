pragma solidity ^0.4.8;

// This is just a simple example of a coin-like contract.
// It is not standards compatible and cannot be expected to talk to other
// coin/token contracts. If you want to create a standards-compliant
// token, see: https://github.com/ConsenSys/Tokens. Cheers!

contract Coinit {
    
    struct Account {
        address addr;
        int amount;
        string mail;
        string name;
        bool validated;
        bool exist;
    }
    
    struct TinyAccount {
        address addr;
        int amount;
    }
    
    mapping (address => Account) accounts;
    
    address[] accountsArray;

    TinyAccount[] amountToBePaidOut;

    address admin;

    function Coinit() {
        admin = msg.sender;
        Genesis(msg.sender, 0);
    }

    function validateEmployee(address _emplyeeAdr) isAdmin() {
        Account acc = accounts[_emplyeeAdr];
        accounts[_emplyeeAdr].validated = true;
        accountsArray.push(_emplyeeAdr);
        Validate(_emplyeeAdr, true);
    }
    
    function createAccount(string _name, string _mail) {
        accounts[msg.sender] = Account(msg.sender, 0, _name, _mail, false, true);
        AccountCreated(msg.sender, 0, _name, _mail, false);
    }

    function createAndSendCoin(address _receiver, int _amount) isAdmin() {
        accounts[_receiver].amount += _amount;
        Transfer(msg.sender, _receiver, _amount);
    }

    function sendCoin(address _receiver, int _amount) returns(bool sufficient) {
        if (accounts[msg.sender].amount < _amount) return false;
        accounts[msg.sender].amount -= _amount;
        accounts[_receiver].amount += _amount;
        Transfer(msg.sender, _receiver, _amount);
        return true;
    }

    function payOutOnNextSalary(int _amount) returns(bool sufficient) {
        if (getBalance() < _amount) return false;
        // accounts[msg.sender].amount -= _amount;
        //amountToBePaidOut.push(TinyAccount(msg.sender, _amount));
        PayOut(msg.sender, _amount);
        return true;
    }
    
    function payOut() isAdmin {
        /*for (uint i = 0; i < amountToBePaidOut.length; i++) {
            address addr = amountToBePaidOut[i].addr;
            int amount = amountToBePaidOut[i].amount;
            //accounts[addr].amount -= amount;
            PayOut(addr, amount);
        }*/
        //delete amountToBePaidOut;
    }
    
    function createAndGiveMoneyToAllEmployees(int _amount) isAdmin {
        for (uint i = 0; i < accountsArray.length; i++) {
            createAndSendCoin(accountsArray[i], _amount);
        }
    }

    function accountExists() constant returns(bool) {
        return accounts[msg.sender].exist == true;
    }

    function getBalance(address _addr) constant returns(int) {
        return accounts[_addr].amount;
    }
    
    function getBalance() constant returns(int) {
        return accounts[msg.sender].amount;
    }

    function getName(address _addr) constant returns(string) {
        return accounts[_addr].name;
    }

    function getMail(address _addr) constant returns(string) {
        return accounts[_addr].mail;
    }

    function getValidated(address _addr) constant returns(bool) {
        return accounts[_addr].validated;
    }

    function getAdmin() isAdmin constant returns(bool) {
        return true;
    }

    modifier isValidated() {
        if (accounts[msg.sender].validated == true) _;
    }

    modifier isAdmin() {
        if (msg.sender != admin) _;
    }

    modifier onlyWithBalanceMoreThan(int _amount) {
        if (accounts[msg.sender].amount >= _amount) _;
    }

    event Transfer(address indexed _from, address indexed _to, int256 _value);

    event Validate(address indexed _employee, bool _value);
    
    event Genesis(address indexed _to, int256 _value);

    event PayOut(address indexed _account, int256 _value);
    
    event AccountCreated(address _addr, int amount, string _name, string _mail, bool validated);
}
