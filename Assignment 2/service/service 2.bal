import ballerina/graphql;
import ballerinax/mongodb;
import ballerina/uuid;

type User record {
    string id;
    string firstName;
    string lastName;
    string jobTitle;
    string position;
    string role; 
};

type Objective record {
    string id;
    string department;
    string description;
    float weight;
};

type KPI record {
    string id;
    string employeeId;
    string description;
    string unit;
    float weight;
};

type Score record {
    string id;
    string employeeId;
    string kpiId;
    float value;
};

type Assignment record {
    string id;
    string employeeId;
    string supervisorId;
};


mongodb:ConnectionConfig mongoConfig = {
    connection: {
        host: "localhost",
        port: 27017,
        auth: {
            username: "",
            password: ""
        },
        options: {
            sslEnabled: false,
            serverSelectionTimeout: 5000
        }
    },
    databaseName: "performance-management"
};

mongodb:Client db = check new (mongoConfig);
configurable string userCollection = "Users";
configurable string objectiveCollection = "Objectives";
configurable string kpiCollection = "KPIs";
configurable string scoreCollection = "Scores";
configurable string assignmentCollection = "Assignment";

service /performanceManagement on new graphql:Listener(8080) {

    remote function createUser(User newuser) returns error|string {
        // Insert user information into the database
        map<json> userDoc = <map<json>>newuser.toJson();
        _ = check db->insert(userDoc, userCollection, "");
        return string `${newuser.firstName} added successfully`;
    }

    // Mutation to create department objectives
    remote function createDepartmentObjective(Objective depobjective) returns error|string {
        map<json> objectiveDoc = <map<json>>depobjective.toJson();
        _ = check db->insert(objectiveDoc, objectiveCollection, "");
        return "Department objective created successfully";
    }

    remote function deleteDepartmentObjective(string id) returns error|string {
    mongodb:Error|int deleteItem = db->delete(objectiveCollection, "", {id: id}, false);
    if deleteItem is mongodb:Error {
        return error("Failed to delete Objective lol");
    } else {
        if deleteItem > 0 {
            return string `${id}  objective deleted successfully`;
        } else {
            return string `objective not found`;
        }
    }

    }

    remote function viewEmployeeTotalScore(string employeeId) returns float|error {

        stream<Score, error?> scoreDocs = check db->find(scoreCollection);

        float totalScore = 0.0;

        check from Score scoreDoc in scoreDocs 
        do {
            float scoreValue = <float>scoreDoc["value"];
            totalScore = totalScore + scoreValue;
        };
        return totalScore;
    }

    remote function assignEmployeeToSupervisor(string employeeId, string supervisorId) returns string|error {
        
        stream<Assignment, error?> assignments = check db->find(assignmentCollection, 'limit = 1);
        record { Assignment value; }? existingAssignment = check assignments.next();

        if (existingAssignment == ()) {
            
            Assignment assignment = {
                id: uuid:createType1AsString(),
                employeeId: employeeId,
                supervisorId: supervisorId
            };

           
            map<json> assignmentDoc = <map<json>>assignment.toJson();
            _ = check db->insert(assignmentDoc, assignmentCollection, "");

            return "Employee assigned to supervisor successfully";
        } else {
            
            return "Employee is already assigned to a supervisor";
        }
    }
}