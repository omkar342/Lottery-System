# Building a Simple Lottery System in Solidity

Lotteries have been around for centuries, and they continue to be popular today. In recent years, blockchain technology has been used to create fair and transparent lottery systems. In this tutorial, we will discuss how to create a simple lottery system in Solidity, which is a programming language used for creating smart contracts on the Ethereum blockchain. We will use Remix IDE, which is a web-based IDE for Solidity programming.

Our lottery system will have the following features:

- Only the manager of the contract can select the winner.
- To participate, users must send at least 1 ether to the contract.
- When the manager selects the winner, the entire balance of the contract is transferred to the winner.
- The list of participants is cleared after a winner is selected.

## Getting Started

### Prerequisites

To follow this tutorial, you will need the following:

- A web browser
- An internet connection
- A basic understanding of Solidity and smart contracts

### Functions

- `getBalance()`: Returns the current balance of the contract.
- `random()`: Generates a random number based on the previous block hash, timestamp, and number of participants.
- `selectWinner()`: Selects a winner and transfers the entire balance of the contract to the winner's address.

## Step 1: Create a new Solidity file in Remix IDE

Open Remix IDE in your browser and create a new Solidity file. Name the file "Lottery.sol". The first line of the file should be the SPDX-License-Identifier, which specifies the license that the code is released under. We will use the GPL-3.0 license.

`solidity // SPDX-License-Identifier: GPL-3.0 `

## Step 2: Define the contract

The next step is to define the contract. Our contract will be called "Lottery". We will define the contract variables and constructor.

```
pragma solidity >= 0.5.0 < 0.9.0;

contract Lottery {

    address public manager;
    address payable [] public participants;

    constructor(){
        manager = msg.sender;
    }

    // Other functions will be added later

}
```

In this code, we define two variables: "manager", which will store the Ethereum address of the contract manager, and "participants", which will be an array of payable addresses representing the users who have sent ether to the contract. We also define a constructor function that sets the value of "manager" to the address of the person who deploys the contract.

## Step 3: Add the receive function

The receive function is a special function that is called when someone sends ether to the contract. We will use this function to add participants to the lottery.

```
receive() external payable {
    require(msg.value == 1 ether, "Exactly 1 ether is required to participate in this Lottery");
    participants.push(payable(msg.sender));
}
```

In this code, we check that the amount of ether sent is exactly 1 ether, and then we add the sender's address to the "participants" array.

## Step 4: Add the getBalance function

We will add a function that allows the manager to check the balance of the contract.

```
function getBalance() public view returns (uint){
    require(msg.sender == manager, "You don't have access to it.");
    return address(this).balance;
}
```

In this code, we use the "require" statement to check that the caller is the manager of the contract. If the caller is not the manager, the function will not execute. The function returns the balance of the contract.

## Step 5: Add the random function

We will add a function that generates a random number based on the current block's previous block hash, timestamp, and the number of participants in the lottery.

```
function random() public view returns (uint){
    return uint(keccak256(abi.encode(block.prevhash, block.timestamp, participant.length)));
}
```

In this code, we use the "keccak256" hash function to generate a random number based on the previous block hash, timestamp, and number of participants. We use the "abi.encode" function to encode the parameters into a byte array that can be passed as an argument to the "keccak256" function. Finally, we convert the hash output into an unsigned integer using the "uint" typecast and return the result.

The purpose of this function is to generate a random number that will be used to determine the winner of the lottery. By including the previous block hash and timestamp, the function ensures that the result is unpredictable and cannot be manipulated by anyone. The number of participants is also included to add some variability to the result, as the outcome of the lottery should depend on the number of participants.

## Step 6: Test the contract

We will test the contract by deploying it on the Rinkeby test network and interacting with it using Remix IDE. To do this, we will:

Connect Remix IDE to the Rinkeby test network
Compile the contract
Deploy the contract
Send ether to the contract to participate in the lottery
Call the "selectWinner" function to select a winner
To connect Remix IDE to the Rinkeby test network, follow the instructions in Step 3. Once you have connected to the Rinkeby test network, compile and deploy the contract.

To participate in the lottery, send at least 1 ether to the contract using the "Send" button in Remix IDE. Make sure to use an Ethereum address that is not the contract manager.

To select a winner, call the "selectWinner" function using the "Transact" button in Remix IDE. Make sure to use the contract manager's address to call this function.

## Step 7: Conclusion

In this blog, we have discussed how to create a simple lottery system in Solidity using Remix IDE. Our lottery system is fair and transparent, and it allows anyone to participate by sending ether to the contract. The contract manager is the only person who can select a winner, ensuring that the lottery is conducted in a secure and trustworthy manner.
