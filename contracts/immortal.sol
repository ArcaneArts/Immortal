// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.4.16 <0.9.0;

contract Immortal {
    // Fired when data is put
    event putEvent(address indexed from, string key, string value);

    // Fired when data is removed
    event removeEvent(address indexed from, string key);

    // The owner of this smart contract
    address owner;

    // Maps users to their data (string => string)
    mapping (address => mapping(string => string)) data;

    // Upon creation, sets the creator
    constructor()
    {
        owner = msg.sender;
    }

    // Allows any user to write to their data
    function put(string memory key, string memory value) public payable {
        data[msg.sender][key] = value;
        emit writeEvent(msg.sender, key, value);
    }

    // Allows any user to delete a key from their data
    function remove(string memory key) public payable {
        delete data[msg.sender][key];
        emit removeEvent(msg.sender, key);
    }

    // Gets the data at a given user/key
    function getData(address me, string memory key) public view returns (string memory) {
        return data[me][key];
    }
}