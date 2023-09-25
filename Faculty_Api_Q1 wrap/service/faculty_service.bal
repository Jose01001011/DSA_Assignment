import ballerina/http;

# A service representing a network-accessible API
# bound to port `9090`.
service / on new http:Listener(9092) {

resource function post addLecturer(string staffNumber, string officeNumber, string staffName, string title) returns Lecturer|error {
    // Check if the lecturer already exists.
    if (lecturersTable.hasKey(staffNumber)) {
        return error("Lecturer already exists");
    }

    // Create an empty courses table.
   table<Course> emptyCoursesTable = table [{courseCode: "405",courseName: "Database Management", nqfLevel: 7}];
   
    // Create a new Lecturer record with the provided details and the empty courses table.
    Lecturer newLecturer = {
        staffNumber: staffNumber,
        officeNumber: officeNumber,
        staffName: staffName,
        title: title,
        courses: emptyCoursesTable
    };

    // Add the new lecturer to the lecturersTable.
    lecturersTable.add(newLecturer);

    // Return the added lecturer.
    return newLecturer;
}





    resource function get getLecturers() returns json {
    Lecturer[] lecturers = lecturersTable.toArray();
    json[] lecturerJsonArray = [];

    foreach var lecturer in lecturers {
        json lecturerJson = {
            "staffNumber": lecturer.staffNumber,
            "officeNumber": lecturer.officeNumber,
            "staffName": lecturer.staffName,
            "title": lecturer.title
            // Add more fields as needed
        };
        lecturerJsonArray.push(lecturerJson);
    }

    return lecturerJsonArray;
}

resource function get lecturers/[string staffNumber]() returns string|Lecturer {
    Lecturer? lecturer = lecturersTable[staffNumber];
    if (lecturer == null) {
        return "Lecturer not found";
    }
    return lecturer;
}



resource function delete deleteLecturer(string staffNumber) returns string|error {
    // Check if the lecturer exists
    Lecturer? existingLecturer = lecturersTable[staffNumber];
    if (existingLecturer == null) {
        return error("Lecturer not found");
    }

    // Remove the lecturer from the table
    _ = lecturersTable.remove(staffNumber);

    return "Lecturer deleted successfully";
}


resource function get lecturersByCourse(string courseCode) returns Lecturer[]|error {
    Lecturer[] lecturersWithCourse = [];
    
    foreach Lecturer lecturer in lecturersTable {
        foreach Course course in lecturer.courses {
            if (course.courseCode == courseCode) {
                lecturersWithCourse.push(lecturer);
                break;
            }
        }
    }
    
    if (lecturersWithCourse.length() == 0) {
        return error("No lecturers found for the specified course.");
    }
    
    return lecturersWithCourse;
}

resource function get lecturersInOffice(string officeNumber) returns Lecturer[]|error {
    Lecturer[] lecturersInSameOffice = [];
    
    foreach Lecturer lecturer in lecturersTable {
        if (lecturer.officeNumber == officeNumber) {
            lecturersInSameOffice.push(lecturer);
        }
    }
    
    if (lecturersInSameOffice.length() == 0) {
        return error("No lecturers found in the specified office.");
    }
    
    return lecturersInSameOffice;
}


}



public type Lecturer record {|
   readonly string staffNumber;
    string officeNumber;
    string staffName;
    string title;
    table<Course> courses;
|};

public type Office record {|
    readonly string officeNumber;
    string location;
    table<Lecturer> lecturers;
|};

public type Course record {|
    readonly string courseCode;
    string courseName;
    int nqfLevel;
|};

public final table<Lecturer> key(staffNumber) lecturersTable = table [
    {staffNumber: "001", officeNumber: "101", staffName: "Max Haikali", title: "Junior Lecturer", courses: table[
        {courseCode: "WD102", courseName: "Web Developmenent", nqfLevel: 7},
        {courseCode: "DS101", courseName: "Data Science", nqfLevel: 6}
    ]},
    {staffNumber: "002", officeNumber: "102", staffName: "Fillemon-Mekki", title: "Senior Lecturer", courses: table[
        {courseCode: "ML103", courseName: "Machine Learning", nqfLevel: 6},       {courseCode: "AI104", courseName: "Artificial Intelligence", nqfLevel: 7}
   ]},
    {staffNumber: "003", officeNumber: "103", staffName: "Jose Clayton", title: "Senior Lecturer", courses: table[
        {courseCode: "DSA105", courseName: "Distributed Systems", nqfLevel: 6}
    ]},

     {staffNumber: "004", officeNumber: "104", staffName: "Gift Liswaniso", title: "Junior Lecturer", courses: table[
        {courseCode: "DBM106", courseName: "Database Management", nqfLevel: 6}
    ]}
];



public final table<Course> key(courseCode) coursesTable = table [
    {courseCode: "DS101", courseName: "Data Science", nqfLevel: 6},
    {courseCode: "WD102", courseName: "Web Developmenent", nqfLevel: 7},
    {courseCode: "ML103", courseName: "Machine Learning", nqfLevel: 6},
    {courseCode: "AI104", courseName: "Artificial Intelligence", nqfLevel: 7},
    {courseCode: "DSA105", courseName: "Distributed Systems", nqfLevel: 6},
     {courseCode: "DBM106", courseName: "Database Management", nqfLevel: 6},
     {courseCode: "DSA107", courseName: "Data Structures & Algorithms", nqfLevel: 6}
];

public type ConflictingStaffNumberError record {|
    *http:Conflict;
    ErrorMsg body;
|};

public type ErrorMsg record {|
    string errmsg;
|};