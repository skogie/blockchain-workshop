pragma solidity ^0.4.13;

contract Coinit {
    
    struct Account {
        address addr;
        int balance;
        bool validated;
        bool exist;
        string name;
        string email;
    }

    struct TinyAccount {
        address addr;
        int balance;
    }

    mapping (address => Account) public accounts;

    address[] public accountsArray;

    TinyAccount[] private amountToBePaidOut;

    address public admin;

    function Coinit() {
        Genesis(msg.sender);
        admin = msg.sender;
    }

    function isOwner() constant returns(bool) {
        return admin == msg.sender;
    }
    
    function createAccount(string _name, string _email) returns(bool success) {
        accounts[msg.sender] = Account({addr: msg.sender, balance: 0, validated: false, exist: true, name: _name, email: _email});
        CreateAccount(msg.sender, 0, false, true, _name, _email);
        return true;
    }

    function accountExists() constant returns(bool) {
        return accounts[msg.sender].exist;
    }

    function validateAccount(address _accountAddr) isAdmin returns(bool) {
        Account acc = accounts[_accountAddr];
        if (!acc.validated) {
            accounts[_accountAddr].validated = true;
            accountsArray.push(_accountAddr);
            Validate(_accountAddr, true);   
        }
    }

    function getValidated(address _addr) constant returns(bool) {
        return accounts[_addr].validated;
    }

    function getBalance(address _addr) constant returns(int) {
        return accounts[_addr].balance;
    }

    function createAndSendCoin(address _receiver, int _amount) isAdmin returns(bool) {
        int prevBalance = accounts[_receiver].balance;
        accounts[_receiver].balance = prevBalance + _amount;
        return true;
    }

    function sendCoin(address _receiver, int _amount) returns(bool sufficient) {
        require(_amount > 0 && accounts[msg.sender].balance >= _amount);
        accounts[msg.sender].balance -= _amount;
        accounts[_receiver].balance += _amount;
        Transfer(msg.sender, _receiver, _amount);
        return true;
    }

    function createAndGiveMoneyToAllValidatedAccounts(int _amount) isAdmin {
        for (uint i = 0; i < accountsArray.length; i++) {
            createAndSendCoin(accountsArray[i], _amount);
        }
    }

    function getNumberOfValidatedAccounts() constant returns(uint) {
        return accountsArray.length;
    }

    function markForPayOutOnNextSalary(address _addr, int _amount) isAdmin returns(bool sufficient) {
        amountToBePaidOut.push(TinyAccount(_addr, _amount));
        MarkForPayOut(_addr, _amount);
        return true;
    }

    function payOutOnNextSalary(int _amount) returns(bool sufficient) {
        amountToBePaidOut.push(TinyAccount(msg.sender, _amount));
        MarkForPayOut(msg.sender, _amount);
        return true;
    }
    
    function payOut() isAdmin {
        for (uint i = 0; i < amountToBePaidOut.length; i++) {
            address addr = amountToBePaidOut[i].addr;
            int amount = amountToBePaidOut[i].balance;
            accounts[addr].balance -= amount;
            PayOut(addr, amount);
        }
        delete amountToBePaidOut;
    }
    
    function kill() isAdmin {
        selfdestruct(admin);
    }

    modifier isAdmin() {
        require(msg.sender == admin);
        _;
    }

    event CreateAccount(address indexed _addr, int _balance, bool _validated, bool _exist, string _name, string _email);

    event Transfer(address indexed _from, address indexed _to, int _value);

    event Validate(address indexed _account, bool _value);
    
    event Genesis(address indexed _admin);

    event MarkForPayOut(address indexed _account, int _value);

    event PayOut(address indexed _account, int _value);


}