import ballerina/graphql;
import ballerinax/mongodb;

configurable string host = ?;
configurable int port = ?;
configurable string username = ?;
configurable string password = ?;
configurable string database = ?;
configurable string collection = ?;
configurable string usersCollection = ?;
configurable string kpisCollection = ?;
configurable string objectivesCollection = ?;

mongodb:ConnectionConfig mongoConfig = {
    connection: {
        host: host,
        port: port,
        quin: {
            username: username,
            password: password
        },
        options: {
            sslEnabled: false, 
            serverSelectionTimeout: 5000
        }
    },
    databaseName: ""
};

type Client record {
    
};

mongodb:Client mongoClient = check new (mongoConfig);

public type User record {
    string ID;
    string FirstName;
    string LastName;
    string JobTitle;
    string Position;
    string Role;
    int DepartmentID;
};


public type DepartmentObjective record {
    string ObjectiveID;
    string ObjectiveName;
    string Description;
    int ContributionPercentage;
    string DepartmentID;
};



public type KPI record {
    string KPIID;
    int EmployeeID;
    int ObjectiveID;
    string KPIName;
    string Description;
    string Unit;
    float Score;
    int SupervisorID;
};


service /graphql on new graphql:Listener(4000) {
    // Resolver for the 'getUser' query. This function fetches a user by their ID.
// Resolver for the 'getUser' query. This function fetches a user by their ID.


//***QUERIES AND MUTATIONS FOR USERS---USERS---USERS---USERS---USERS---USERS---USERS---USERS---USERS---USERS---USERS---USERS---USERS
resource function get getUser(string ID) returns User|error {
    // Creating a filter to match the user by their ID.
    map<json> filter = {"ID": ID};

    // Using the 'find' function of the mongoClient to fetch the user based on the provided ID.
    var result = mongoClient->find("usersCollection", "AssignmentName", filter, (), (), -1, -1, User);

    // Checking the type of the result. If it's a stream, it means documents were found matching the filter.
    if (result is stream<User, error?>) {
        var userResult = result.next();

        // Checking if the result contains a User record.
        if (userResult is record {| User value; |}) {
            return userResult.value;  // Return the matched user.
        } else if (userResult is error) {
            return userResult;  // Return the error if any occurred.
        } else {
            return error("User not found");  // If no user was found, return an error.
        }
    } else if (result is error) {
        return result;  // Return the error if the find operation failed.
    }
}

// Mutation to add a new user.
resource function post addUser(User userInput) returns User|error {
    // Convert User record to map<json> before insertion
    map<json> userJson = {
        "ID": userInput.ID,
        "FirstName": userInput.FirstName,
        "LastName": userInput.LastName,
        "JobTitle": userInput.JobTitle,
        "Position": userInput.Position,
        "Role": userInput.Role,
        "DepartmentID": userInput.DepartmentID
    };

    // Inserting the user into the "Users" collection.
    var insertResult = mongoClient->insert(userJson, "usersCollection", "Assignment2Name");
    
    if (insertResult is ()) {  // If the insert operation was successful, return the inserted user.
        return userInput;
    } else {  // If there was an error during insertion, return the error.
        return insertResult;
    }
}

// Mutation to update a user by ID.
resource function put updateUser(string ID, User userInput) returns User|error {
    // Convert User record to map<json> for the update statement
    map<json> userUpdate = {
        "$set": {
            "FirstName": userInput.FirstName,
            "LastName": userInput.LastName,
            "JobTitle": userInput.JobTitle,
            "Position": userInput.Position,
            "Role": userInput.Role,
            "DepartmentID": userInput.DepartmentID
        }
    };
    
    map<json> filter = {"ID": ID};

    // Updating the user in the "Users" collection.
    var updateResult = mongoClient->update(userUpdate, "usersCollection", "Assignment2Name", filter, false, false);
    
    if (updateResult is int && updateResult > 0) {  // If the update operation was successful, return the updated user.
        return userInput;
    } else {  // If there was an error during the update or no document was updated, return an error.
        return error("Failed to update the user or no matching user found.");
    }
}

// Mutation to delete a user by ID.
resource function delete deleteUser(string ID) returns string|error {
    map<json> filter = {"ID": ID};

    // Deleting the user from the "Users" collection.
    var deleteResult = mongoClient->delete("usersCollection", "Assignment2Name", filter, false);
    
    if (deleteResult is int && deleteResult > 0) {  // If the delete operation was successful, return a success message.
        return "User successfully deleted.";
    } else {  // If there was an error during deletion or no document was deleted, return an error.
        return error("Failed to delete the user or no matching user found.");
    }
}
//*****END OF USERS-----END OF USERS-----END OF USERS-----END OF USERS-----END OF USERS-----END OF USERS-----END OF USERS-----END OF USERS

//*****QUERIES AND MUTATIONS FOR KPIs---MUTATIONS FOR KPIs---MUTATIONS FOR KPIs---MUTATIONS FOR KPIs---MUTATIONS FOR KPIs******

// Resolver for the 'getKPI' query. This function fetches a KPI by its KPIID.
resource function get getKPI(string KPIID) returns KPI|error {
    map<json> filter = {"KPIID": KPIID};
    var result = mongoClient->find("kpisCollection", "Assignment2Name", filter, (), (), -1, -1, KPI);
    if (result is stream<KPI, error?>) {
        var kpiResult = result.next();
        if (kpiResult is record {| KPI value; |}) {
            return kpiResult.value;  
        } else if (kpiResult is error) {
            return kpiResult;  
        } else {
            return error("KPI not found");  
        }
    } else if (result is error) {
        return result;
    }
}

// Mutation to add a new KPI.
resource function post addKPI(KPI kpiInput) returns KPI|error {
    map<json> kpiJson = {
        "KPIID": kpiInput.KPIID,
        "EmployeeID": kpiInput.EmployeeID,
        "ObjectiveID": kpiInput.ObjectiveID,
        "KPIName": kpiInput.KPIName,
        "Description": kpiInput.Description,
        "Unit": kpiInput.Unit,
        "Score": kpiInput.Score,
        "SupervisorID": kpiInput.SupervisorID
    };
    var insertResult = mongoClient->insert(kpiJson, "kpisCollection", "Assignment2Name");
    if (insertResult is ()) {  
        return kpiInput;
    } else {  
        return insertResult;
    }
}

// Mutation to update a KPI by KPIID.
resource function put updateKPI(string KPIID, KPI kpiInput) returns KPI|error {
    map<json> kpiUpdate = {
        "$set": {
            "EmployeeID": kpiInput.EmployeeID,
            "ObjectiveID": kpiInput.ObjectiveID,
            "KPIName": kpiInput.KPIName,
            "Description": kpiInput.Description,
            "Unit": kpiInput.Unit,
            "Score": kpiInput.Score,
            "SupervisorID": kpiInput.SupervisorID
        }
    };
    map<json> filter = {"KPIID": KPIID};
    var updateResult = mongoClient->update(kpiUpdate, "kpisCollection", "Assignment2Name", filter, false, false);
    if (updateResult is int && updateResult > 0) {
        return kpiInput;
    } else {
        return error("Failed to update the KPI or no matching KPI found.");
    }
}

// Mutation to delete a KPI by KPIID.
resource function delete deleteKPI(string KPIID) returns string|error {
    map<json> filter = {"KPIID": KPIID};
    var deleteResult = mongoClient->delete("kpisCollection", "Assignment2Name", filter, false);
    if (deleteResult is int && deleteResult > 0) {
        return "KPI successfully deleted.";
    } else {
        return error("Failed to delete the KPI or no matching KPI found.");
    }
}

//*****END_OF_KPIs--END_OF_KPIs--END_OF_KPIs--END_OF_KPIs--END_OF_KPIs--END_OF_KPIs--END_OF_KPIs--END_OF_KPIs******

//*****MUTATIONS FOR DepartmentObjectives---MUTATIONS FOR DepartmentObjectives---MUTATIONS FOR DepartmentObjectives---MUTATIONS FOR DepartmentObjectives---MUTATIONS FOR DepartmentObjectives******

// Resolver for the 'getDepartmentObjective' query. This fetches a DepartmentObjective by its ObjectiveID.
resource function get getDepartmentObjective(string ObjectiveID) returns DepartmentObjective|error {
    map<json> filter = {"ObjectiveID": ObjectiveID};
    var result = mongoClient->find("objectivesCollection", "Assignment2Name", filter, (), (), -1, -1, DepartmentObjective);
    if (result is stream<DepartmentObjective, error?>) {
        var deptObjectiveResult = result.next();
        if (deptObjectiveResult is record {| DepartmentObjective value; |}) {
            return deptObjectiveResult.value;
        } else if (deptObjectiveResult is error) {
            return deptObjectiveResult;
        } else {
            return error("Department Objective not found");
        }
    } else if (result is error) {
        return result;
    }
}

// Mutation to add a new DepartmentObjective.
resource function post addDepartmentObjective(DepartmentObjective deptObjInput) returns DepartmentObjective|error {
    map<json> deptObjJson = {
        "ObjectiveID": deptObjInput.ObjectiveID,
        "ObjectiveName": deptObjInput.ObjectiveName,
        "Description": deptObjInput.Description,
        "ContributionPercentage": deptObjInput.ContributionPercentage,
        "DepartmentID": deptObjInput.DepartmentID
    };
    var insertResult = mongoClient->insert(deptObjJson, "objectivesCollection", "Assignment2Name");
    if (insertResult is ()) {
        return deptObjInput;
    } else {
        return insertResult;
    }
}

// Mutation to update a DepartmentObjective by ObjectiveID.
resource function put updateDepartmentObjective(string ObjectiveID, DepartmentObjective deptObjInput) returns DepartmentObjective|error {
    map<json> deptObjUpdate = {
        "$set": {
            "ObjectiveName": deptObjInput.ObjectiveName,
            "Description": deptObjInput.Description,
            "ContributionPercentage": deptObjInput.ContributionPercentage,
            "DepartmentID": deptObjInput.DepartmentID
        }
    };
    map<json> filter = {"ObjectiveID": ObjectiveID};
    var updateResult = mongoClient->update(deptObjUpdate, "objectivesCollection", "Assignment2Name", filter, false, false);
    if (updateResult is int && updateResult > 0) {
        return deptObjInput;
    } else {
        return error("Failed to update the DepartmentObjective or no matching DepartmentObjective found.");
    }
}

// Mutation to delete a DepartmentObjective by ObjectiveID.
resource function delete deleteDepartmentObjective(string ObjectiveID) returns string|error {
    map<json> filter = {"ObjectiveID": ObjectiveID};
    var deleteResult = mongoClient->delete("objectivesCollection", "Assignment2Name", filter, false);
    if (deleteResult is int && deleteResult > 0) {
        return "DepartmentObjective successfully deleted.";
    } else {
        return error("Failed to delete the DepartmentObjective or no matching DepartmentObjective found.");
    }
}

//*****END_OF_DepartmentObjectives--END_OF_DepartmentObjectives--END_OF_DepartmentObjectives--END_OF_DepartmentObjectives--END_OF_DepartmentObjectives--END_OF_DepartmentObjectives--END_OF_DepartmentObjectives--END_OF_DepartmentObjectives******



}
