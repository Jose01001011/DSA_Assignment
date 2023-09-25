import ballerina/io;
import 'client.types as Types;
import 'client.'client as Client;

public function main() returns error?{
    Client:Client staff_client = check new Client:Client();
    io:println("************************************************************************");
    io:println("|                         SELECT AN OPTION                             |");
    io:println("|                                                                      |");
    io:println("| 1. Display All Lecturers                                             |");
    io:println("| 2. Add a new lecturer                                                |");
    io:println("| 3. Update lecturer information                                       |");
    io:println("| 4. Display details of a specific lecturer                            |");
    io:println("| 5. Delete a lecturer                                                 |");
    io:println("| 6. Display all the lecturers that teach a certain course             |");
    io:println("| 7. Display all the lecturers that sit in the same office             |");
    io:println("************************************************************************");

    string choice =  io:readln();


    if choice == "1" {
        Types:LecturerArr lecturers = check staff_client->getAllLecturers();
        io:println(lecturers);
    }
    if choice == "2" {
        int staff_number = check int:fromString(io:readln("Please input the staff number: "));
        string name = io:readln("Input fullname: ");
        string title = io:readln("Input title: ");
        string email = io:readln("Input email address: ");
        string phone_number = io:readln("Input phone numer: ");

        Types:OfficeArr offices = check staff_client->getAllOffices();
        io:println(offices);

        int office = check int:fromString(io:readln("Input office number: "));

        Types:Lecturer lecturer = {staff_number:staff_number, name:name, title:title, email:email, phone_number:phone_number, office_number: {office_number: office}};
        Types:InlineResponse201 lecturerResult = check staff_client->addLecturer(lecturer);
        io:println(lecturerResult);

    }
    if choice == "3" {
        int staff_number = check int:fromString(io:readln("Please input staff number: "));
        Types:Lecturer lecturer = check staff_client->retrieveLecturer(staff_number);

        string change_to = io:readln("What do you wand changed? (name, title, email, phone_number, office_number): ");
        if change_to == "name" {
            string name = io:readln("Change it to: ");
            lecturer.name = name;
        }
        if change_to == "title" {
            string title = io:readln("Change it to: ");
            lecturer.title = title;
        }
        if change_to == "email" {
            string email = io:readln("Change it to: ");
            lecturer.email = email;
        }
        if change_to == "phone_number" {
            string phone_number = io:readln("Change it to: ");
            lecturer.phone_number = phone_number;
        }
        if change_to == "office_number" {
            Types:OfficeArr offices = check staff_client->getAllOffices();
            io:println(offices);

            int office = check int:fromString(io:readln("Change it to: "));
            lecturer.office_number = {office_number: office};
        }

        Types:Lecturer lecturerResult = check staff_client->updateLecturer(staff_number, lecturer);
        io:println(lecturerResult);

    }
    if choice == "4"{
        int staff_number = check int:fromString(io:readln("Please input staff number: "));
        Types:Lecturer lecturer = check staff_client->retrieveLecturer(staff_number);
        io:println(lecturer);
    }
    if choice == "5"{
        int staff_number = check int:fromString(io:readln("Enter the staff number: "));
        Types:InlineResponse201 lecturerResult = check staff_client->deleteLecturer(staff_number);
        io:println(lecturerResult);
    }
    if choice == "6"{
        string course_code = io:readln("Please input staff number: ");
        Types:LecturerArr lecturers = check staff_client->retrieveLecturersTeachingCourse(course_code);
        io:println(lecturers);
    }
    if choice == "7"{
        int office_number = check int:fromString(io:readln("Please input office number: "));
        Types:LecturerArr lecturers = check staff_client->retrieveLecturersInOffice(office_number);
        io:println(lecturers);
    }
}