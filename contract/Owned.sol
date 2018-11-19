pragma solidity ^0.4.24;

contract Owned {
    address public owner;
    address public newOwner;
    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }
    function transferOwnership(address _newOwner) public onlyOwner {
        newOwner = _newOwner;
    }
    function acceptOwnership() public {
        require(msg.sender == newOwner);
        owner = newOwner;
    }
}
