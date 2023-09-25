import 'service.types as Types;

public table<Types:Course> key(course_code) courses = table[
    {course_code: "DSA611S", name: "Distributed Systems and Applications", nqf: 7},
    {course_code: "PRG611S", name: "Programming2", nqf: 5}
];

public table<Types:Office> key(office_number) offices = table[
    {office_number: 12, building: "FCI", floor: 1, room: "Lab1"},
    {office_number: 13, building: "FCI", floor: 1, room: "lab2"},
    {office_number: 14, building: "FCI", floor: 1, room: "lab3"}
];

public table<Types:Lecturer> key(staff_number) lecturers = table[
    {staff_number: 1, name: "Ndinelago Nashandi", title: "Lecturer", email: "nnashandi@nust.na", phone_number: "+264 61 207 2000", office_number: {office_number: 12}, courses: []},
    {staff_number: 2, name: "Ndinelago Nashandi", title: "Cordinator", email: "qjose@nust.na", phone_number: "+264 61 269 6855", office_number: {office_number: 13}, courses: []},
    {staff_number: 3, name: "Isaac Makosa", title: "Lecturer", email: "misaac@gmail.na", phone_number: "+264 61 226 5550", office_number: {office_number: 14}, courses: []}
];