import ballerina/graphql;
import ballerina/io;

type response record {|
    record {|anydata dt;|} data;
|};

public function main() returns error? {
    io:println("welcome to the HR Service Client");
    io:println("Please choose your access level:");
    io:println("1. HOD");
    io:println("2. supervisor");
    io:println("3. employee");

    string accessLevel = io:readln("enter your access stages (1/2/3): ");

    string password = io:readln("enter your password (password for all users is '1234'): ");

    if (password != "1234") {
        io:println("Invalid password. Exiting.");
        return;
    }

    if (accessLevel == "3") {
        string employeeCode = io:readln("enter your employee id: ");
    } else if (accessLevel == "2") {
        string supervisorCode = io:readln("enter your supervisor id: ");
    } else if (accessLevel == "1") {
        string hodCode = io:readln("enter your HoD code: ");
    } else {
        io:println("access denied to stage. Exiting.");
        return;
    }

    graphql:Client graphqlClient = check new ("http://localhost:3000/graphql");

  
    if (accessLevel == "1") {
        string objectiveCode = io:readln("enter department objectives id: ");
        string nameObjective = io:readln("enter department objectives name: ");

        string createObj = string `
    mutation createObjective($objectives_code:String!,$objectiveName:String!){
        createObjective(newObjective:{objectives_code:$objectives_code,objectiveName:$objectiveName})
    }`;

        response createObjectiveResponse = check graphqlClient->execute(createObj, {"objectives_code": objectiveCode, "objectiveName": nameObjective});

        io:println("Response ", createObjectiveResponse);
    }

   
    if (accessLevel == "1") {
        string objectiveCodeToDelete = io:readln("Enter department objectives code to delete: ");

        string deleteObj = string `
    mutation deleteObjective($objectives_code:String!){
        deleteObjective(objectiveToBeDeleted:{objectives_code:$objectives_code})
    }`;

        response deleteObjectiveResponse = check graphqlClient->execute(deleteObj, {"objectives_code": objectiveCodeToDelete});

        io:println("Response ", deleteObjectiveResponse);
    }

   
    if (accessLevel == "1" || accessLevel == "2" || accessLevel == "3") {
        string employeeCodeToView = io:readln("Enter employee code to view scores: ");

        string viewScore = string `
            query {
                viewEmployeeScores(employeeCode: $employeeCodeToView) {
                    employeeCode
                    FirstName
                    lastName
                    department
                    supervisor
                    supervisorSCore
                    performance_development_KPI
                    student_Progress_KPI
                    innovative_teaching_methods_KPI
                    totalScore
                }
            }`;

        response viewScoreResponse = check graphqlClient->execute(viewScore, {"employeeCodeToView": employeeCodeToView});
        io:println("Response ", viewScoreResponse);
    }

   
    if (accessLevel == "1" || accessLevel == "2" || accessLevel == "3") {
        string employeeCodeToAssign = io:readln("Enter employee code to assign to a supervisor: ");
        string supervisorCodeToAssign = io:readln("Enter supervisor code: ");

        string doc = string `
    mutation assignSupervisor($employeeCode:String!,$supervisorCode:String!){
        assignSupervisor(newSupervisor:{employeeCode:$employeeCode,supervisorCode:$supervisorCode})
    }`;

        response assignSupervisorResponse = check graphqlClient->execute(doc, {"employeeCode": employeeCodeToAssign, "supervisorCode": supervisorCodeToAssign});

        io:println("Response ", assignSupervisorResponse);

    }

}