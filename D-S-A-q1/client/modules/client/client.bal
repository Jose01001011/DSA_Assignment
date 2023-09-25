import ballerina/http;
import 'client.types as Types;
import 'client.utils as Utils;

# Manage Staff, Staff Offices and Staff Office Allocations
public isolated client class Client {
    final http:Client clientEp;
    # Gets invoked to initialize the `connector`.
    #
    # + clientConfig - The configurations to be used when initializing the `connector` 
    # + serviceUrl - URL of the target service 
    # + return - An error if connector initialization failed 
    public isolated function init(http:ClientConfiguration clientConfig =  {}, string serviceUrl = "http://localhost:9000/faculty_management_api/v1") returns error? {
        http:Client httpEp = check new (serviceUrl, clientConfig);
        self.clientEp = httpEp;
        return;
    }
    # Fetch all lecturers
    #
    # + return - All lecturers Retrieved 
    remote isolated function getAllLecturers() returns Types:Lecturer[]|error {
        string resourcePath = string `/lecturers`;
        Types:Lecturer[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Add a new lecturer
    # + payload - the payload
    # + return - Lecturer added successfully 
    remote isolated function addLecturer(Types:Lecturer payload) returns Types:InlineResponse201|error {
        string resourcePath = string `/lecturers`;
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody, "application/json");
        Types:InlineResponse201 response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Retrieve A Single Lecturer
    # + staffNumber - the lecturer's staff number
    # + return - Lecturer Retrieved 
    remote isolated function retrieveLecturer(int staffNumber) returns Types:Lecturer|error {
        string resourcePath = string `/lecturers/${Utils:getEncodedUri(staffNumber)}`;
        Types:Lecturer response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Update A Single Lecturer
    # + staffNumber - the lecturer's staff number
    # + payload - the object representing the lecturer
    # + return - Lecturer Updated 
    remote isolated function updateLecturer(int staffNumber, Types:Lecturer payload) returns Types:Lecturer|error {
        string resourcePath = string `/lecturers/${Utils:getEncodedUri(staffNumber)}`;
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody, "application/json");
        Types:Lecturer response = check self.clientEp->put(resourcePath, request);
        return response;
    }
    # Delete A Single Lecturer
    # + staffNumber - the lecturer's staff number
    # + return - Lecturer Deleted 
    remote isolated function deleteLecturer(int staffNumber) returns Types:Lecturer|error {
        string resourcePath = string `/lecturers/${Utils:getEncodedUri(staffNumber)}`;
        Types:Lecturer response = check self.clientEp-> delete(resourcePath);
        return response;
    }
    # Fetch all courses
    #
    # + return - All courses Retrieved 
    remote isolated function getAllCourses() returns Types:Course[]|error {
        string resourcePath = string `/courses`;
        Types:Course[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Add a new course
    # + payload - the object representing the course
    # + return - Course added successfully 
    remote isolated function addCourse(Types:Course payload) returns Types:InlineResponse2011|error {
        string resourcePath = string `/courses`;
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody, "application/json");
        Types:InlineResponse2011 response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Retrieve A Single Course
    # + courseCode - the pk of the course
    # + return - Course Retrieved 
    remote isolated function retrieveCourse(string courseCode) returns Types:Course|error {
        string resourcePath = string `/courses/${Utils:getEncodedUri(courseCode)}`;
        Types:Course response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Update A Single Course
    # + courseCode - the pk of the course
    # + payload - the object representing the course
    # + return - Course Updated 
    remote isolated function updateCourse(string courseCode, Types:Course payload) returns Types:Course|error {
        string resourcePath = string `/courses/${Utils:getEncodedUri(courseCode)}`;
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody, "application/json");
        Types:Course response = check self.clientEp->put(resourcePath, request);
        return response;
    }
    # Delete A Single Course
    # + courseCode - the pk of the course
    # + return - Course Deleted 
    remote isolated function deleteCourse(string courseCode) returns Types:Course|error {
        string resourcePath = string `/courses/${Utils:getEncodedUri(courseCode)}`;
        Types:Course response = check self.clientEp-> delete(resourcePath);
        return response;
    }
    # Retrieve All Lecturers Teaching A Course
    # + courseCode - the pk of the course
    # + return - Lecturers Retrieved 
    remote isolated function retrieveLecturersTeachingCourse(string courseCode) returns Types:Lecturer[]|error {
        string resourcePath = string `/courses/${Utils:getEncodedUri(courseCode)}/lecturers`;
        Types:Lecturer[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Assign a lecturers to a course
    # + courseCode - the pk of the course
    # + payload - the object representing the course
    # + return - Lecturer Assigned 
    remote isolated function assignLecturerToCourse(string courseCode, Types:Lecturer payload) returns Types:Lecturer|error {
        string resourcePath = string `/courses/${Utils:getEncodedUri(courseCode)}/lecturers`;
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody, "application/json");
        Types:Lecturer response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Fetch all offices
    #
    # + return - All offices Retrieved 
    remote isolated function getAllOffices() returns Types:Office[]|error {
        string resourcePath = string `/offices`;
        Types:Office[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Add a new office
    # + payload - the object representing the office
    # + return - Office added successfully 
    remote isolated function addOffice(Types:Office payload) returns Types:InlineResponse2012|error {
        string resourcePath = string `/offices`;
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody, "application/json");
        Types:InlineResponse2012 response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Retrieve A Single Office
    # + officeNumber - the office number
    # + return - Office Retrieved 
    remote isolated function retrieveOffice(int officeNumber) returns Types:Office|error {
        string resourcePath = string `/offices/${Utils:getEncodedUri(officeNumber)}`;
        Types:Office response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Update A Single Office
    # + officeNumber - the office number
    # + payload - the object representing the office
    # + return - Office Updated 
    remote isolated function updateOffice(int officeNumber, Types:Office payload) returns Types:Office|error {
        string resourcePath = string `/offices/${Utils:getEncodedUri(officeNumber)}`;
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody, "application/json");
        Types:Office response = check self.clientEp->put(resourcePath, request);
        return response;
    }
    # Delete A Single Office
    # + officeNumber - the office number
    # + return - Office Deleted 
    remote isolated function deleteOffice(int officeNumber) returns Types:Office|error {
        string resourcePath = string `/offices/${Utils:getEncodedUri(officeNumber)}`;
        Types:Office response = check self.clientEp-> delete(resourcePath);
        return response;
    }
    # Retrieve lecturers in an office
    # + officeNumber - the office number
    # + return - Lecturers Retrieved 
    remote isolated function retrieveLecturersInOffice(int officeNumber) returns Types:Lecturer[]|error {
        string resourcePath = string `/offices/${Utils:getEncodedUri(officeNumber)}/lecturers`;
        Types:Lecturer[] response = check self.clientEp->get(resourcePath);
        return response;
    }
}
