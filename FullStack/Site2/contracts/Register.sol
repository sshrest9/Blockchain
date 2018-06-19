pragma solidity ^0.4.18;
pragma experimental ABIEncoderV2;
contract Register{
    constructor() public{
        var user = logins["test"];

        user.uName = "test";
        user.pWord = "pass";

        userArray.push("test") - 1;
    }
    bool existingUser = false;
    struct userLogin{
        uint id;
        string uName;
        bytes32 pWord;
    }

    event newUser(
        string uName,
        bytes32 pass
    );
    mapping (string => userLogin) logins;
    string[] private userArray;
    
    function setUser(string username, string password)public returns(bool){
        var user = logins[username];
        bool check = checkExisitingUser(username);
        if(check){
            return false;
        }else{
            bytes32 encryptedPassword = keccak256(password);
        
            user.uName = username;
            user.pWord = encryptedPassword;

            userArray.push(username) - 1;
            emit newUser(username,encryptedPassword);
            return true;
        }

    }
    
    function getUser(string username) public returns(bytes32){
        return(logins[username].pWord);
    }
    function getAllUser() view public returns(string[]){
        return userArray;
    }
    
    function checkExisitingUser(string user) view public returns(bool){
        uint arrayLength = userArray.length;
        for(uint i = 0; i < arrayLength;i++){
            string userInArray = userArray[i];
            
            existingUser = compareStrings(user,userInArray);
        }
        if(existingUser){
            return true;
        }else{
            return false;
        }            
    }
    
    function compareStrings (string a, string b) view private returns (bool){return keccak256(a) == keccak256(b);}
}