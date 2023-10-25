import ballerina/graphql;


type HoD record {
    readonly string HoD;
    string FirstName;
    string LastName;
    string Department;
};


type Department_Objectives record {
    readonly string objectives_code;
    string objectiveName;
};


type supervisor record {
    readonly string supervisorCode;
    string FirstName;
    string LastName;
    string Department;
};


type employee record {
    readonly string employeeCode;
    string FirstName;
    string LastName;
    string Department;
    string supervisor;
    int supervisorGrade;
    int Professional_Development_KPI;
    int Student_Progress_KPI;
    int Innovative_Teaching_Methods_KPI;
    int TotalScore;
};


type successMessage record {
    string message = "Operation Successful";
};


table<Department_Objectives> key(objectives_code) objectivesTable = table [];


table<HoD> key(HoD_Code) HoD_Table = table [];


table<Supervisor> key(supervisorCode) supervisorTable = table [];


table<Employee> key(employeeCode) employeeTable = table [];

@graphql:ServiceConfig {
    graphiql: {
        enabled: true
    }
}

service / on new graphql:Listener(3000) {

    

    
    remote function createObjective(Department_Objectives objectives) returns typedesc<successMessage>|Department_Objectives|error {
        error? addNewObjective = objectivesTable.add(objectives);
        if addNewObjective is error {
            return addNewObjective;
        } else {
            return successMessage;
        }
    }

    
    remote function deleteObjective(string objectives_code) returns Department_Objectives? {
        Department_Objectives? deletedObjectives = objectivesTable.remove(objectives_code);
        return deletedObjectives;
    }

    
    remote function viewEmployeeScores(string employeeCode) returns Employee? {
        Employee? employee = employeeTable[employeeCode];
        return employee;
    }

    
    remote function assignSupervisor(string employeeCode, string supervisorCode) returns boolean {
        Employee? employee = employeeTable[employeeCode];
        Supervisor? supervisor = supervisorTable[supervisorCode];
        if (employee != null && supervisor != null) {
            employee.supervisor = supervisorCode;
            return true;
        }
        return false;
    }

    

    
    remote function deleteKPI(string employeeCode, string kpiName) returns boolean {
        Employee? employee = employeeTable[employeeCode];
        if (employee != null) {
            
            employee[kpiName] = 0; 
            return true;
        }
        return false;
    }

    
    remote function updateKPI(string employeeCode, string kpiName, int newValue) returns boolean {
        Employee? employee = employeeTable[employeeCode];
        if (employee != null) {
            
            employee[kpiName] = newValue;
            return true;
        }
        return false;
    }

    
    remote function viewEmployeeKPI(string employeeCode, string supervisorCode) returns Employee? {
        Employee? employee = employeeTable[employeeCode];
        Supervisor? supervisor = supervisorTable[supervisorCode];
        if (employee != null && employee.supervisor == supervisorCode) {
            return employee;
        }
        return null;
    }

    
    remote function gradeEmployeeKPI(string employeeCode, int grade) returns boolean {
        Employee? employee = employeeTable[employeeCode];
        if (employee != null) {
            employee.TotalScore = grade;
            return true;
        }
        return false;
    }

   
    remote function createOwnKPI(string employeeCode, string kpiName, int newValue) returns boolean {
        Employee? employee = employeeTable[employeeCode];
        if (employee != null) {
            employee[kpiName] = newValue;
            return true;
        }
        return false;
    }

   
    remote function gradeSupervisor(string employeeCode, int grade) returns boolean {
        Employee? employee = employeeTable[employeeCode];
        if (employee != null) {
            employee.supervisorGrade = grade;
            return true;
        }
        return false;
    }

    remote function viewOwnKPI(string employeeCode) returns Employee? {
    Employee? employee = employeeTable[employeeCode];
    if (employee != null) {
        return employee;
    }
    return null;
}

}