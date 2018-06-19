pragma solidity ^0.4.19;

contract Token{
    uint inc =1;
    struct tokenList{
        string username;
        bytes32 token;
        uint time;
    }

    mapping (bytes32 => tokenList) validUsers;
    bytes32[] private validTokenArray;
    
    function generateToken(string a)public returns(bytes32){
        bytes32 token;
        token = keccak256(a,inc);
        var user = validUsers[token];

        inc++;
        user.username = a;
        user.token = token;
        user.time = block.timestamp;
        validTokenArray.push(token) - 1;
        return token;
    }
    
    function getToken(bytes32 a) view public returns(string){
        bool valid = validateToken(a);
        if(valid){
            return "temp";
        }else{
            return "error";
        }
    }
    
    function validateToken(bytes32 token) private returns(bool){
        var user = validUsers[token];
        uint diff = now - user.time;
        if(diff >= 172800){ //2 days
            return false;
        }else{
            return true;
        }
    }
    
    //Using token becuase the user need to be logged into the account already
    //before allowing users to use third party 
    //
    function thirdPartyAuth(bytes32 token) public returns (bool,bytes32){
        bool check  = validateToken(token);
        if(check){
            //generate Token for third party
            var authToken = generateThirdPartyToken();
            return (true,authToken);
        }else{
            //get user to login
            return (false,0);
        }
    }
    
    function generateThirdPartyToken() public returns(bytes32){
        bytes32 Token3rd;
        Token3rd = keccak256(block.number, block.timestamp);
        
        return Token3rd;
    }
}