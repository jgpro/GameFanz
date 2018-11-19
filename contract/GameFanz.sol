pragma solidity ^0.4.25;

import "./SafeMath.sol";
import "./Owned.sol";
import "./IERC20.sol";

contract GameFanz is IERC20, Owned {
    using SafeMath for uint256;
    
    // Constructor - Sets the token Owner
    constructor() public {
        owner = msg.sender;
        _balances[msg.sender] = supply;
        contractAddress = this;
    }
    
    // Events
    event Error(string err);
    event Mint(uint mintAmount, uint newSupply);
    
    // Token Setup
    string public constant name = "GameFanz";
    string public constant symbol = "GFN";
    uint256 public constant decimals = 8;
    uint256 public constant supply = 80000000000 * 10 ** decimals;
    address public contractAddress;
    
    mapping (address => bool) public claimed;
    
    // Balances for each account
    mapping(address => uint256) _balances;
 
    // Owner of account approves the transfer of an amount to another account
    mapping(address => mapping (address => uint256)) public _allowed;
 
    // Get the total supply of tokens
    function totalSupply() public constant returns (uint) {
        return supply;
    }
 
    // Get the token balance for account `tokenOwner`
    function balanceOf(address tokenOwner) public constant returns (uint balance) {
        return _balances[tokenOwner];
    }
 
    // Get the allowance of funds beteen a token holder and a spender
    function allowance(address tokenOwner, address spender) public constant returns (uint remaining) {
        return _allowed[tokenOwner][spender];
    }
 
    // Transfer the balance from owner's account to another account
    function transfer(address to, uint value) public returns (bool success) {
        require(_balances[msg.sender] >= value);
        _balances[msg.sender] = _balances[msg.sender].sub(value);
        _balances[to] = _balances[to].add(value);
        emit Transfer(msg.sender, to, value);
        return true;
    }
    
    // Sets how much a sender is allowed to use of an owners funds
    function approve(address spender, uint value) public returns (bool success) {
        _allowed[msg.sender][spender] = value;
        emit Approval(msg.sender, spender, value);
        return true;
    }
    
    // Transfer from function, pulls from allowance
    function transferFrom(address from, address to, uint value) public returns (bool success) {
        require(value <= balanceOf(from));
        require(value <= allowance(from, to));
        _balances[from] = _balances[from].sub(value);
        _balances[to] = _balances[to].add(value);
        _allowed[from][to] = _allowed[from][to].sub(value);
        emit Transfer(from, to, value);
        return true;
    }
    
    function buyGFN() public payable returns (bool success) {
        if (msg.value == 0 && claimed[msg.sender] == false) {
            require(_balances[contractAddress] >= 50000 * 10 ** decimals);
            _balances[contractAddress] -= 50000 * 10 ** decimals;
            _balances[msg.sender] += 50000 * 10 ** decimals;
            claimed[msg.sender] = true;
            return true;
        } else if (msg.value == 0.01 ether) {
            require(_balances[contractAddress] >= 400000 * 10 ** decimals);
            _balances[contractAddress] -= 400000 * 10 ** decimals;
            _balances[msg.sender] += 400000 * 10 ** decimals;
            return true;
        } else if (msg.value == 0.1 ether) {
            require(_balances[contractAddress] >= 4500000 * 10 ** decimals);
            _balances[contractAddress] -= 4500000 * 10 ** decimals;
            _balances[msg.sender] += 4500000 * 10 ** decimals;
            return true;
        } else if (msg.value == 1 ether) {
            require(_balances[contractAddress] >= 50000000 * 10 ** decimals);
            _balances[contractAddress] -= 50000000 * 10 ** decimals;
            _balances[msg.sender] += 50000000 * 10 ** decimals;
            return true;
        } else {
            revert();
        }
    }
    
    
}
