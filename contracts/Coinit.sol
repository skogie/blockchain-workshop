pragma solidity ^0.4.4;

// This is just a simple example of a coin-like contract.
// It is not standards compatible and cannot be expected to talk to other
// coin/token contracts. If you want to create a standards-compliant
// token, see: https://github.com/ConsenSys/Tokens. Cheers!
import "./ConvertLib.sol";

contract Coinit {


	mapping (address => int) balances;

	mapping (address => string) emails;

	mapping (address => bool) valideted;

	address admin;


	function Coinit() {
		balances[tx.origin] = 100;
        admin = tx.origin;
        Genesis(tx.origin, 0);
	}

	function validateEmployee(address emplyeeAdr) isAdmin() {
		valideted[emplyeeAdr] = true;
		Validate(emplyeeAdr, true);
	}


	function createAndSendCoin(address receiver, int amount) isAdmin() {
		balances[admin] += amount;
		sendCoin(receiver, amount);
	}


	function sendCoin(address receiver, int amount) returns(bool sufficient) {
		if (balances[msg.sender] < amount) return false;
		balances[msg.sender] -= amount;
		balances[receiver] += amount;
		Transfer(msg.sender, receiver, amount);
		return true;
	}

	function getBalance(address addr) constant returns(int) {
		return balances[addr];
	}

	modifier isValidated() {
		if (valideted[msg.sender] == true) _;
	}

	modifier isAdmin() {
        if (msg.sender == admin) _;
    }

    modifier onlyWithBalanceMoreThan(int amount) {
        if (balances[msg.sender] >= amount) _;
    }

    event Transfer(address indexed _from, address indexed _to, int256 _value);

    event Validate(address indexed _employee, bool _value);
    
    event Genesis(address indexed _to, int256 _value);
}
