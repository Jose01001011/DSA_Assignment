import ballerina/http;
import ballerina/io;



 http:Client lecturerClient = check new("http://localhost:9092");
type Lecturer record {
    
};

public function main() returns error? {
    // Create an HTTP client for your service
    // Replace with your server's base URL

    // Send a GET request to retrieve all lecturers
    Lecturer[] lecturers = check lecturerClient->/getLecturers;
    io:println("GET request - Lecturers:");
    foreach var lecturer in lecturers {
        io:println(lecturer.toString());
    }


 // Replace "001" with the staff number you want to retrieve.
 io:println("-----------------------------------------");
 io:println("-----------------------------------------");
 io:println("-----------------------------------------");
 io:println("-----------------------------------------");
 io:println("-----------------------------------------");
 io:println("-----------------------------------------");
 io:println("-----Second Request Coming through------");
    string staffNumber = "003";

    // Send a GET request to retrieve a lecturer by staff number.
    http:Response|error response = lecturerClient->get("/lecturers/" + staffNumber);

    if (response is http:Response) {
        // Parse the response JSON to get the Lecturer.
        json? responseJson = check response.getJsonPayload();
        if (responseJson is json) {
            Lecturer? lecturer = <Lecturer>responseJson;
            if (lecturer is Lecturer) {
                io:println("GET request - Lecturer:");
                io:println(lecturer.toString());
            } else {
                io:println("Lecturer not found");
            }
        
    } 
    } else {
        // Handle any client-side errors.
        io:println("Error: " + response.message());
    }
    
io:println("-----------------------------------------");
 io:println("-----------------------------------------");
 io:println("-----------------------------------------");
 io:println("-----------------------------------------");
 io:println("-----------------------------------------");
 io:println("-----------------------------------------");
 io:println("-----Third Request Coming through------");
    
    // Replace "001" with the staff number you want to delete.
    // string staffNumber2 = "004";

    // Send a DELETE request to delete the lecturer.
     string|error response2 = lecturerClient->delete("/deleteLecturer/" + staffNumber);

    if (response2 is string) {
        io:println(response2);
    } else {
        // Handle any client-side errors.
        io:println("Error: " + response2.message());
    }



string courseCode = "ML303";

// Send a GET request to retrieve lecturers by course code.
Lecturer[]|error response1 = lecturerClient->get("/lecturersByCourse/" + courseCode);

if (response1 is Lecturer[]) {
    io:println("GET request - Lecturers by Course:");
    foreach var lecturer in response1 {
        io:println(lecturer.toString());
    }
} else {
    io:println("Error: " + response1.message());
}

    


    
    return ();
}


