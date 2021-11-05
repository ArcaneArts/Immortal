// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.4.16 <0.9.0;

contract Immortal {
    event putEvent(address indexed from, string key, string value);
    event removeEvent(address indexed from, string key);

    mapping (address => mapping(string => string)) data;
    address owner;
    uint public fee = 0;

    constructor() public { owner = msg.sender;}

    modifier paid() { require(msg.value >= fee, "Value must contain at least the fee in WEI"); _;}
    modifier administrative() {require(msg.sender == owner, "You are not the owner. You cannot do this.");_;}

    function adminSetFeeWei(uint newFeeWei) public payable administrative {
        fee = newFeeWei;
    }

    function adminWithdraw() public administrative {
        msg.sender.transfer(address(this).balance);
    }

    function put(string memory key, string memory value) public payable paid {
        data[msg.sender][key] = value;
        emit putEvent(msg.sender, key, value);
    }

    function remove(string memory key) public payable paid {
        delete data[msg.sender][key];
        emit removeEvent(msg.sender, key);
    }

    function get(string memory key) public view returns (string memory) {
        return data[msg.sender][key];
    }
}