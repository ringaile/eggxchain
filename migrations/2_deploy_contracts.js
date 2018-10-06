var ChainList = artifacts.require("./ChainList.sol");
var Greeter = artifacts.require("./Greeter.sol");
var SupplyChainList = artifacts.require("./SupplyChainList.sol");

module.exports = function(deployer) {
  deployer.deploy(ChainList);
  deployer.deploy(Greeter, "Hello");
  deployer.deploy(SupplyChainList);
}
