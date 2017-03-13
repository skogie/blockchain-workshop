var Coinit = artifacts.require("./Coinit.sol");

contract('MetaCoin', function(accounts) {
  it("should put 0 MetaCoin in the first account", function() {
    return Coinit.deployed().then(function(instance) {
      return instance.getBalance.call(accounts[0]);
    }).then(function(balance) {
      assert.equal(balance.valueOf(), 0, "0 wasn't in the first account");
    });
  });
  it("should send coin correctly", function() {
    var meta = Coinit.deployed();
    meta.getBalance

    // Get initial balances of first and second account.
    var account_one = accounts[0];
    var account_two = accounts[1];

    var account_one_starting_balance;
    var account_two_starting_balance;
    var account_one_ending_balance;
    var account_two_ending_balance;

    var amount = 10;


    return Coinit.deployed().then(function(instance) {
      return instance.getBalance.call(account_one).then(function(balance) {
        account_one_starting_balance = balance.toNumber();
        return instance.getBalance.call(account_two);
      }).then(function(balance) {
        account_two_starting_balance = balance.toNumber();
        return instance.sendCoin(account_two, amount, {from: account_one});
      }).then(function() {
        return instance.getBalance.call(account_one);
      }).then(function(balance) {
        account_one_ending_balance = balance.toNumber();
        return instance.getBalance.call(account_two);
      }).then(function(balance) {
        account_two_ending_balance = balance.toNumber();

        assert.equal(account_one_ending_balance, account_one_starting_balance - amount, "Amount wasn't correctly taken from the sender");
        assert.equal(account_two_ending_balance, account_two_starting_balance + amount, "Amount wasn't correctly sent to the receiver");
      });
    });

  });
});
