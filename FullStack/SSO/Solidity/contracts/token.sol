pragma solidity ^0.4.19;

contract Token{
    uint inc =1;
    struct tokenList{
        string username;
        bytes32 token;
        uint time;
    }

    mapping (string => tokenList) validUsers;
    string[] private validTokenArray;
    
    function generateToken(string a)public returns(bytes32){
        var user = validUsers[a];
        bytes32 token;
        token = keccak256(a,inc);
        //token = keccak256(inc);
        inc++;
        user.username = a;
        user.token = token;
        user.time = block.timestamp;
        validTokenArray.push(a) - 1;
        return token;
    }
    
    function getToken(string a) view public returns(string){
        bool valid = validateToken(a);
        if(valid){
            return "temp";
        }else{
            return "error";
        }
    }
    
    function validateToken(string a) private returns(bool){
        var user = validUsers[a];
        uint diff = block.timestamp - user.time;
        if(diff >= 60){
            return false;
        }else{
            return true;
        }
    }
}