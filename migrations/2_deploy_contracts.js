var SupplyChainList = artifacts.require("./SupplyChainList.sol");

module.exports = function(deployer) {
  deployer.deploy(SupplyChainList);
}
