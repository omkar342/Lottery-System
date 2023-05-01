// SPDX-License-Identifier: GPL-3.0

pragma solidity >= 0.5.0 < 0.9.0;

contract Lottery {

    address public manager;
    address payable [] public participants;

    constructor(){
        manager = msg.sender;
    }

    receive() external payable {
        require(msg.value == 1 ether, "At least 1 ether is required to participate in this Lottery");
        participants.push(payable(msg.sender));
    }

    function getBalance() public view returns (uint){
        require(msg.sender == manager, "You don't have access to it.");
        return address(this).balance;
    }

    function random() public view returns (uint){
        return uint(keccak256(abi.encode(block.prevrandao, block.timestamp, participants.length)));
    }

    function selectWinner() public {
        require(msg.sender == manager, "You don't have access to it.");
        require(participants.length >= 3, "Not enough participants have participated.");
        uint randomValue = random();
        uint index = randomValue % participants.length;
        address payable winner = participants[index];
        winner.transfer(getBalance());
        participants = new address payable[](0);
    }

}
