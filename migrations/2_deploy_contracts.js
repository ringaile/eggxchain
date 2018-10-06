var ChainList = artifacts.require("./ChainList.sol");
var Greeter = artifacts.require("./Greeter.sol");

module.exports = function(deployer) {
  deployer.deploy(ChainList);
  deployer.deploy(Greeter);
}
