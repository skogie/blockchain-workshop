pragma solidity ^0.4.2;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/Coinit.sol";

contract TestCoinit {

  function testInitialBalanceUsingDeployedContract() {
    Coinit meta = Coinit(DeployedAddresses.Coinit());

    int expected = 0;

    Assert.equal(meta.getBalance(tx.origin), expected, "Owner should have 10000 MetaCoin initially");
  }

  function testInitialBalanceWithNewMetaCoin() {
    Coinit meta = new Coinit();

    int expected = 0;

    Assert.equal(meta.getBalance(tx.origin), expected, "Owner should have 10000 MetaCoin initially");
  }
}