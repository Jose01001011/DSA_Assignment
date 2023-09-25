import 'service.types as Types;

// function to check if a lecturer is assigned to a course
public function is_assigned_to_course(Types:Course[]? courses, string course_code) returns boolean{
    if courses != () {
        foreach Types:Course course in courses {
            if course.course_code == course_code {
                return true;
            }
        }
    }

    return false;
}

public function is_in_office(Types:Office? office, int office_number) returns boolean {
    if office is Types:Office {
        if office.office_number == office_number{
            return true;
        }
    }

    return false; 
}