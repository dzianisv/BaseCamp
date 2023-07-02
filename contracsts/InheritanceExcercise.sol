// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;


/* Deployment
Salesperson(55555, 12345, 20)
EngineeringManager(54321, 11111, 200000)
InheritanceSubmission(Salesperson.address, EnEngineeringManager.address);


/** Employee
Create an abstract contract called employee. It should have:
    A public variable storing idNumber
    A public variable storing managerId
    A constructor that accepts arguments for and sets both of these variables
    A virtual function called getAnnualCost that returns a uint
*/
abstract contract Employee {
    uint public idNumber;
    uint public managerId;

    constructor(uint _idNumber, uint _managerId) {
        idNumber = _idNumber;
        managerId = _managerId;
    }

    function getAnnualCost() public virtual returns (uint);
}


/*
Employee
Create an abstract contract called employee. It should have:

    A public variable storing idNumber
    A public variable storing managerId
    A constructor that accepts arguments for and sets both of these variables
    A virtual function called getAnnualCost that returns a uint
*/
contract Salaried is Employee {
    uint public annualSalary;

    constructor(uint _idNumber, uint _managerId, uint _annualSalary) Employee(_idNumber, _managerId) {
        annualSalary = _annualSalary;
    }

    function getAnnualCost() public override view returns (uint) {
        return annualSalary;
    }
}

/*
Implement a contract called Hourly. It should:
    Inherit from Employee
    Have a public variable storing hourlyRate
    Include any other necessary setup and implementation
*/
contract Hourly is Employee {
    uint public hourlyRate;

    constructor(uint _idNumber, uint _managerId, uint _hourlyRate) Employee(_idNumber, _managerId) {
        hourlyRate = _hourlyRate;
    }

    function getAnnualCost() public view override returns (uint) {
        return hourlyRate * 2080;
    }
}

/*
Implement a contract called Hourly. It should:
    Inherit from Employee
    Have a public variable storing hourlyRate
    Include any other necessary setup and implementation
*/
contract Manager {
    uint[] public employeeIds;

    function addReport(uint _idNumber) public {
        employeeIds.push(_idNumber);
    }

    function resetReports() public {
        delete employeeIds;
    }
}

// Salesperson contract
contract Salesperson is Hourly {
    constructor(uint _idNumber, uint _managerId, uint _hourlyRate) Hourly(_idNumber, _managerId, _hourlyRate) {}
}

// EngineeringManager contract
contract EngineeringManager is Salaried, Manager {
    constructor(uint _idNumber, uint _managerId, uint _annualSalary) Salaried(_idNumber, _managerId, _annualSalary) {}
}

// Deployment contract
contract InheritanceSubmission {
    address public salesPerson;
    address public engineeringManager;

    constructor(address _salesPerson, address _engineeringManager) {
        salesPerson = _salesPerson;
        engineeringManager = _engineeringManager;
    }
}
