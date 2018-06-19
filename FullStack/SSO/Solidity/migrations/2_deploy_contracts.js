// var Adoption = artifacts.require("Adoption");
var Register = artifacts.require("Register");
var AuthUser = artifacts.require("AuthUser");
module.exports = function(deployer) {
  // deployer.deploy(Adoption);
  deployer.deploy(Register);
  deployer.deploy(AuthUser);
};