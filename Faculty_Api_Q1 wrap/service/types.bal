// AUTO-GENERATED FILE.
// This file is auto-generated by the Ballerina OpenAPI tool.

public type Lecturer record {
    string staffNumber?;
    string officeNumber?;
    string staffName?;
    string title?;
    Course[] courses?;
};

public type Course record {
    string courseName?;
    string courseCode?;
    int nqfLevel?;
};
