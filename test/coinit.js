var Coinit = artifacts.require("./Coinit.sol");

contract('MetaCoin', function(accounts) {
  it("should put 0 MetaCoin in the first account", function() {
    return Coinit.deployed().then(function(instance) {
      return instance.getBalance.call(accounts[0]);
    }).then(function(balance) {
      assert.equal(balance.valueOf(), 0, "0 wasn't in the first account");
    });
  });
});
