pragma solidity ^0.4.2;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/Coinit.sol";

contract TestCoinit {


    struct Account {
        address addr;
        int amount;
        string mail;
        string name;
        bool validated;
    }


  function testInitialBalanceUsingDeployedContract() {
    Coinit meta = Coinit(DeployedAddresses.Coinit());

    int expected = 0;

    Assert.equal(meta.getBalance(tx.origin), expected, "Owner should have 0 CoinIt initially");
  }

  function testCreateAccount() {
    Coinit meta = Coinit(DeployedAddresses.Coinit());

    /* string name = "John Doe";
    string mail = "spam@knowit.no"; */

    meta.createAccount("name", "mail");

    /* Assert.equal(meta.getName(tx.origin), name, "The name of the account that was created does not match the expected one.");
    Assert.equal(meta.getMail(tx.origin), mail, "The mail of the account that was created does not match the expected one."); */
    Assert.equal(meta.getBalance(tx.origin), 0, "The balance of the account that was created does not match the expected one.");
    Assert.equal(meta.getValidated(tx.origin), false, "The validated attribute of the account that was created does not match the expected one.");

    Assert.equal(meta.getAdmin(tx.origin), true, "Expected the address to be admin");

    meta.validateEmployee(tx.origin);
    Assert.equal(meta.getValidated(tx.origin), true, "The validated attribute of the account that was created does not match the expected one.");
  }

}