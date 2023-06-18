// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

/*
Create a single contract called EmployeeStorage. It should not inherit from any other contracts. It should have the following functions:

State Variables
The contract should have the following state variables, optimized to minimize storage:

A private variable shares storing the employee's number of shares owned
Employees with more than 5,000 shares count as directors and are stored in another contract
Public variable name which store the employee's name
A private variable salary storing the employee's salary
Salaries range from 0 to 1,000,000 dollars
A public variable idNumber storing the employee's ID number
Employee numbers are not sequential, so this field should allow any number up to 2^256-1
Constructor
When deploying the contract, utilize the constructor to set:
    shares
    name
    salary
    idNumber

For the purposes of the test, you must deploy the contract with the following values:
    shares - 1000
    name - Pat
    salary - 50000
    idNumber - 112358132134

    1000, "Pat", 50000, 112358132134
*/

contract EmployeeStorage {
    uint16 private shares; // math.log(5000, 2) 12.28771237954945
    uint32 private salary; // math.log(1000000, 2) = 19.931568569324174
    string private name;
    uint256 private idNumber;

    error TooManyShares(uint256 shares);

    constructor(
        uint16 _shares,
        string memory _name,
        uint32 _salary,
        uint256 _idNumber
    ) {
        shares = _shares;
        name = _name;
        salary = _salary;
        idNumber = _idNumber;
    }

    // Write a function called viewSalary that returns the value in salary.
    function viewSalary() public view returns (uint32) {
        return salary;
    }

    // Write a function called viewShares that returns the value in shares.
    function viewShares() public view returns (uint16) {
        return shares;
    }

    /*
    Add a public function called grantShares that increases the number of shares allocated to an employee by _newShares. It should:

        Add the provided number of shares to the shares
        If this would result in more than 5000 shares, revert with a custom error called TooManyShares that returns the number of shares the employee would have with the new amount added
        If the number of _newShares is greater than 5000, revert with a string message, "Too many shares"
    */
    function grantShares(uint16 _newShares) public {
        if (_newShares > 5000) {
            revert("To many shares");
        }
        uint16 newSharesCount = shares + _newShares;
        if (newSharesCount > 5000) {
            revert TooManyShares(newSharesCount);
        }

        shares = newSharesCount;
    }

    function checkForPacking(uint256 _slot) public view returns (uint256 r) {
        assembly {
            r := sload(_slot)
        }
    }

    function debugResetShares() public {
        shares = 1000;
    }
}
