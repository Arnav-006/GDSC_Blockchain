//SPDX-License-Identifier: Unlicensed

pragma solidity ^0.8.28;

contract A_token {
    string public name = "A Token";
    string public symbol = "ATK";
    uint8 public decimals = 18;
    uint256 public totalSupply;

    mapping(address => uint256) public balanceOf;
    mapping(address => mapping(address => uint256)) public allowance;

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);

    constructor(uint256 _initialSupply) {
        totalSupply = _initialSupply;
        balanceOf[msg.sender] = totalSupply;
    }

    function transfer(address _to, uint256 _value) public returns (bool success) {
        require(balanceOf[msg.sender] >= _value, "Insufficient balance");
        balanceOf[msg.sender] -= _value;
        balanceOf[_to] += _value;
        emit Transfer(msg.sender, _to, _value);
        return true;
    }

    function approve(address _spender, uint256 _value) public returns (bool success) {
        allowance[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
        return true;
    }

    function approve_1(address _lender, address _spender, uint256 _value) public returns (bool success) {
        allowance[_lender][_spender] = _value;
        emit Approval(_lender, _spender, _value);
        return true;
    }

    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {
        require(_value <= balanceOf[_from],"Insufficient balance");
        require(_value <= allowance[_from][_to], "Allowance exceeded");
        balanceOf[_from] -= _value;
        balanceOf[_to] += _value;
        allowance[_from][_to] -= _value;
        emit Transfer(_from, _to, _value);
        return true;
    }
}
