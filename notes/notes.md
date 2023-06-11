# BaseCamp

![](notes.md-images/2023-06-08-17-22-13.webp)

# Introdcution
TuringComplete - means that any program that can be represented in code can theoretically be expressed and executed on the network

The Limitations of Web2
- Privacy & Control:
- Censorship
- Lack of transparency
- Security vulnerabilities
- Limited interoperability

The limitatoins of Web3:
- Speed
- Storage
- Smart contract limitations
- All data is public


# EVM

![](notes.md-images/2023-06-08-17-11-50.webp)

- World State: Represents the entire Ethereum network, including all accounts and their associated storage.
- Accounts: Entities that interact with the Ethereum network, including Externally Owned Accounts (EOAs) and Contract Accounts.
- Storage: A key-value store associated with each contract account, containing the contract's state and data.
- Execution Stack: A last-in, first-out (LIFO) data structure for temporarily storing values during opcode execution.

- Memory: A runtime memory used by smart contracts during execution.
- Program Counter: A register that keeps track of the position of the next opcode to be executed.

![](notes.md-images/2023-06-08-16-21-39.webp)

the EVM runs the smart contract, it modifies the blockchain's world state and consumes gas accordingly. However, if the transaction is found to be invalid, it will be dismissed by the network without further processing.

![](notes.md-images/2023-06-08-16-57-24.webp)

Some common opcodes include:
ADD: Adds two values from the stack.
SUB: Subtracts two values from the stack.
MSTORE: Stores a value in memory.
SSTORE: Stores a value in contract storage.
CALL: Calls another contract or sends ether.

## Gas

1 WEI = 10^-18 ETH
1 GWEI = 10^-9 ETH

### Memory types
![](notes.md-images/2023-06-08-17-10-58.webp)
#### Stack
For example, an opcode that performs an addition operation might push the two operands onto the stack, perform the addition, and then pop the result off the top of the stack.

#### Memory


#### Contract storage


# Smart-Contract development

## Tools
- hardhat.org
- getwaffle.io
- truffletsuite.com

- remix.ethereum.org

## Limits
### Gas
When you were learning about time complexity, you probably heard the term space complexity once, and then it was never mentioned again. This is because normally, computation is expensive, and storage is practically free. The opposite is true on the EVM. It costs a minimum of 20,000 gas to initialize a variable, and a minimum of 5,000 to change it. Meanwhile, the cost to add two numbers together is 3 gas. This means it is often much cheaper to repeatedly derive a value that is calculated from other values than it is to calculate it once and save it.

If the gas estimate is wrong, the transaction will fail, but it will still cost the gas used up until the point it failed!

### Size
EIP-170 introduced a compiled byte-code size limit of 24 kB to Ethereum Smart Contracts, that are approximately 300-500 lines of Solidity.

Can be bypassed by https://eips.ethereum.org/EIPS/eip-2535

### Stack
The EVM operates with a stack that can hold 1,024 values, but it can only access the top 16. "Stack to Deep" error because you're trying to work with too many variables at once.

In Solidity/EVM, your functions are limited to a total of 16 variables that are input, output, or initialized by the function.


## Language limitations

```solidity
// Bad code example: Does not work
function Greeter(string memory _name) external pure returns (string memory) {
    return "Hello " + _name + "!";
}
```
> TypeError: Operator + not compatible with types literal_string "Hello " and string memory.

You might think that there is some sort of type casting or conversion error that could be solved by explicitly casting the string literal to string memory, or vice versa. This is a great instinct. Solidity is a very explicit language.


## Types

- `uint256` to `int8` casting
```
uint256 first = 1;
int8 second = int8(int256(first));
```
- `type(uint).max`
- Smaller sized integers are used to optimize gas usage in storage operations, but there is a cost. The EVM operates with 256 bit words, so operations involving smaller data types must be cast first, which costs gas.
- `uint` is an alias for uint256 and can be considered the default.
- `address` = bytes20
- conversions from bytes20 and uint160 are allowed.
- `address`:: balance, transfer, call, staticall, delegatecall
- `string`:: concat,
- `enum` Flavors { Vanilla, Chocolate, Strawberry, Coffee }
- `constant`: file/contract level
- The `immutable` keyword is used to declare variables that are set once within the constructor, which are then never changed:
Flavors chosenFlavor = Flavors.Coffee;
- `pure`: unctions that promise not to read from or modify the state of the blockchain. That is, a pure function can't modify or even read variables from the contract's state.
- `view`: This is for functions that promise not to modify the state. view functions can read data from the contract's state, but they can't change state.
- The four types are `external`, `public`, `internal`, and `private`, and they control the visibility of functions to other contracts.


# Testnets
## L1
- Goerli: Launched in early 2019, Goerli initially utilized a multi-client proof-of-authority consensus model to improve stability and security. Following the Merge, it transitioned to a proof-of-stake consensus mechanism, maintaining its cross-client compatibility and making it an ideal choice for developers. Goerli's strong community support and collaboration, as the first community-driven testnet for Ethereum, contribute to ongoing maintenance, improvements, and feature enhancements, ensuring a robust testing environment for developers.

- Sepolia: As one of the two maintained primary testnets alongside Goerli, Sepolia is designed for developers seeking a lighter weight chain for faster synchronization and interaction. While Goerli is optimal for stakers and developers working with large existing states, Sepolia provides a more streamlined experience for testing and development.

## L2
- Base Goerli: As new Layer-2 networks emerged that settled on Ethereum's Layer-1, the need for testnets dedicated to these L2 networks also arose. For instance, the L2 network Base has its own testnet, known as Base Goerli. This testnet settles on the Ethereum Goerli L1 testnet, providing an environment for testing L2-specific features and smart contracts.

- Optimism Goerli: Optimism, an Ethereum Layer-2 scaling solution utilizing Optimistic Rollups, has its own testnet called Optimism Goerli. This testnet is built on the Ethereum Goerli L1 testnet and offers a testing environment for developers to experiment with Optimism's Layer-2 features, smart contracts, and dapps.

## Faucets
- https://faucet.quicknode.com/ethereum/goerli

![](notes.md-images/2023-06-11-18-18-22.webp)
![](notes.md-images/2023-06-11-18-18-54.webp)
- https://bwarelabs.com/faucets

## Deployment

![](notes.md-images/2023-06-11-18-57-25.webp)
![](notes.md-images/2023-06-11-18-58-04.webp)
![](notes.md-images/2023-06-11-18-58-20.webp)

[tx](https://goerli.basescan.org/tx/0xa97800186455d6d91ef474d2ffcb1dcfec5c9f9c47df913af9309184ac46ee80)
![](notes.md-images/2023-06-11-19-00-34.webp)

`0xB5990Cd4F9EEaE2E1a5Db3289A43cF6aB299373F`


# First Achivements

