pragma solidity ^0.4.18;

contract AuthUser{
    bool status = false;
      
    //event LoginAttempt(address sender, string challenge);
    // function login1(string challenge){
    //     LoginAttempt(msg.sender, challenge);
    // }   
    event newUser(
        string uName,
        bytes32 token
    );
    function login(address add,address addToken,string username, string password) public returns(bool){
        bytes memory emptyUsername = bytes(username);
        bytes memory emptyPassword = bytes(password);
        if(emptyUsername.length==0||emptyPassword.length==0){
            return(false);
        }else{
            Register user = Register(add);
            bytes32 userPassword = user.getUser(username);
            
            bool checkPassword = comparePassword(userPassword,password);
            if(checkPassword){
                status = true;
                Token token = Token(addToken);
                bytes32 userToken = token.generateToken(username);
                emit newUser(username,userToken);

                return(true);

            }else{
                status = false;
                return(status);
            }
            
        }
    } 
    function comparePassword (bytes32 a, string b) view private returns (bool){return a == keccak256(b);}
}

contract Register{
    function getUser(string username) public returns(bytes32);
}
contract Token{
    function generateToken(string a)public returns(bytes32); 
}