// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.5.0 <0.9.0;

contract Lottery {
    address public manager; // the address of the contract manager
    address payable[] public participants; // an array of participant addresses

    constructor() {
        manager = msg.sender; // set the manager to the contract deployer
    }

    receive() external payable {
        require(
            msg.value == 1 ether,
            "At least 1 ether is required to participate in this Lottery"
        ); // require participants to send at least 1 ether
        participants.push(payable(msg.sender)); // add the participant to the array
    }

    function getBalance() public view returns (uint) {
        require(msg.sender == manager, "You don't have access to it."); // restrict access to the manager only
        return address(this).balance; // return the contract balance
    }

    function random() public view returns (uint) {
        return
            uint(
                keccak256(
                    abi.encode(
                        block.prevrandao,
                        block.timestamp,
                        participants.length
                    )
                )
            ); // generate a random value based on the previous block hash, current time, and number of participants
    }

    function selectWinner() public {
        require(msg.sender == manager, "You don't have access to it."); // restrict access to the manager only
        require(
            participants.length >= 3,
            "Not enough participants have participated."
        ); // require at least 3 participants to have entered the lottery
        uint randomValue = random(); // generate a random value
        uint index = randomValue % participants.length; // calculate the index of the winner
        address payable winner = participants[index]; // select the winner address
        winner.transfer(getBalance()); // transfer the contract balance to the winner
        participants = new address payable[](0); // reset the participants array to an empty array
    }
}
