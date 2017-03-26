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

    // Get initial balances of first and second account.
    var account_one = accounts[0];
    var account_two = accounts[1];
    var account_three = accounts[2];

    var account_one_starting_balance;
    var account_two_starting_balance;
    var account_one_ending_balance;
    var account_two_ending_balance;
    var account_three_ending_balance;

    var amount = 10;


    return Coinit.deployed().then(function(instance) {
      return instance.createAndSendCoin.sendTransaction(account_two, 10, {from: account_one});
      }).then(function(instance) {
        return instance.getBalance.call(account_two);
        }).then(function(balance) {
          account_two_ending_balance = balance.valueOf();
          console.log(balance.valueOf());
          assert.equal(account_two_ending_balance, 10, "Amount wasn't correctly created and sent to the receiver");
      });

      return instance.getBalance.call(account_one).then(function(balance) {
        account_one_starting_balance = balance.toNumber();
        return instance.getBalance.call(account_two);
      }).then(function(balance) {
        account_two_ending_balance = balance.toNumber();
        return instance.sendCoin(account_three, 5, {from: account_two});
      }).then(function() {
        return instance.getBalance.call(account_two);
      }).then(function(balance) {
        account_two_ending_balance = balance.toNumber();
        return instance.getBalance.call(account_three);
      }).then(function(balance) {
        account_three_ending_balance = balance.toNumber();

        assert.equal(account_one_ending_balance, 10, "Account 1 should have balance 0,-");
        assert.equal(account_two_ending_balance, 5, "Amount wasn't correctly sent to the receiver");
        assert.equal(account_three_ending_balance, 6, "Amount wasn't correctly sent to the receiver");
      });

      return instance.sendCoin.call(account_three, 5, {from: account_two}).then(function() {
        
      });





    });
});
