var AuthUser = artifacts.require("./AuthUser.sol");
var Register = artifacts.require("./Register.sol");
var Token = artifacts.require("./Token.sol");

module.exports = function(deployer) {
  deployer.deploy(AuthUser);
  deployer.deploy(Register);
  deployer.deploy(Token);
};
