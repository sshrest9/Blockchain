pragma solidity ^0.4.18;

contract AuthUser{
    bool status = false;
      
    //event LoginAttempt(address sender, string challenge);
    // function login1(string challenge){
    //     LoginAttempt(msg.sender, challenge);
    // }   
    function login(address add,string username, string password) public returns(bool){
        bytes memory emptyUsername = bytes(username);
        bytes memory emptyPassword = bytes(password);
        if(emptyUsername.length==0||emptyPassword.length==0){
            // return("Please enter username and password");
        }else{
            Register user = Register(add);
            bytes32 currPassword = keccak256(password);
            bytes32 userPassword = user.getUser(username);
            
            bool checkPassword = comparePassword(userPassword,currPassword);
            if(checkPassword){
                status = true; 
                return status;
            }else{
                status = false;
            }
            //return("User logged in");
        }
    }   
    function comparePassword (bytes32 a, bytes32 b) view private returns (bool){return a == (b);}
}

contract Register{
    function getUser(string username) public returns(bytes32);
}