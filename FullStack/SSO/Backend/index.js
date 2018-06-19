const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');
const path = require('path');
const app = express();
const jwt = require('jsonwebtoken');
const Web3 = require('web3');
const Eth = require('ethjs');
const ethUtil = require('ethereumjs-util');
//Const variables
const TOKENPASSOWRD = "thequickbrownfoxjumpsoverthelazydog"
const registerContracts = web3.eth.contract([
  {
    "inputs": [],
    "payable": false,
    "stateMutability": "nonpayable",
    "type": "constructor"
  },
  {
    "anonymous": false,
    "inputs": [
      {
        "indexed": false,
        "name": "uName",
        "type": "string"
      },
      {
        "indexed": false,
        "name": "pass",
        "type": "bytes32"
      }
    ],
    "name": "newUser",
    "type": "event"
  },
  {
    "constant": false,
    "inputs": [
      {
        "name": "username",
        "type": "string"
      },
      {
        "name": "password",
        "type": "string"
      }
    ],
    "name": "setUser",
    "outputs": [
      {
        "name": "",
        "type": "bool"
      }
    ],
    "payable": false,
    "stateMutability": "nonpayable",
    "type": "function"
  },
  {
    "constant": false,
    "inputs": [
      {
        "name": "username",
        "type": "string"
      }
    ],
    "name": "getUser",
    "outputs": [
      {
        "name": "",
        "type": "bytes32"
      }
    ],
    "payable": false,
    "stateMutability": "nonpayable",
    "type": "function"
  },
  {
    "constant": true,
    "inputs": [],
    "name": "getAllUser",
    "outputs": [
      {
        "name": "",
        "type": "string[]"
      }
    ],
    "payable": false,
    "stateMutability": "view",
    "type": "function"
  },
  {
    "constant": true,
    "inputs": [
      {
        "name": "user",
        "type": "string"
      }
    ],
    "name": "checkExisitingUser",
    "outputs": [
      {
        "name": "",
        "type": "bool"
      }
    ],
    "payable": false,
    "stateMutability": "view",
    "type": "function"
  }
]);
const authContract = web3.eth.contract([
  {
    "constant": false,
    "inputs": [
      {
        "name": "add",
        "type": "address"
      },
      {
        "name": "username",
        "type": "string"
      },
      {
        "name": "password",
        "type": "string"
      }
    ],
    "name": "login",
    "outputs": [
      {
        "name": "",
        "type": "bool"
      }
    ],
    "payable": false,
    "stateMutability": "nonpayable",
    "type": "function"
  }
])
//addresses
const registerAddress = "0x85b295be96c26d2e15378a377a7171c09f53c025";
const authAddress = "0xe0039bf8bd6207694f4ec34d9f6accaa37e819ef";
const register = registerContracts.at(registerAddress);
const auth= authContract.at(authAddress);

// variable dec;
var token;

app.use(cors());
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

var port = process.env.PORT ||3001
//web3Auth.attach(app, "This is my secret.");
//functions
function verifyToken(token){
  jwt.verify(token,TOKENPASSOWRD,(err,decoded)=>{
    if(err){
      console.log("Something wrong with token");;
    }else{
      console.log('Token still valid');
    }
  });
}

//routes
app.get('/token',function(req,res){
  //let tokenStuff = req.body.token;
});

app.get('/loggedIn',function(req,res){
  res.send("this is a where the body goes");
})

app.post('/login',function (req,res){
  console.log(req.body);
  var username = req.body.username;
  var password = req.body.password;
  if(username===undefined || password ===undefined){ 
    return res.json({msg:"Error missing username or password"});
  }else{
    token = jwt.sign({username}, TOKENPASSOWRD, {
      expiresIn: "60000"
    })
    return res.json({msg:"Woking",token});
    //verifyToken(req.body.Token);  
  }
})


app.listen(port, function () {
  console.log('Example app listening on port 3001!')
});