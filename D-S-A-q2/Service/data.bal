table<book> key(ISBN) testBooks = table [
    {
        "authors": [
            {
                "first_name": "Mike",
                "middle_name": "Furry",
                "last_name": "Tyson"
            }
        ],
        "book_location": {
            "aisle": 2,
            "floor": 1,
            "section": "Geometry"
        },
        "edition": 3,
        "genre": "Adventure",
        "ISBN": "12",
        "name": "Earth",
        "publisher": "Namibia University of Science and Technology",
        "status": AVAILABLE,
        "year_published": 2023
    },
    {
        "authors": [
            {
                "first_name": "Daniela",
                "middle_name": "Pombili",
                "last_name": "Ipinge"
            }
        ],
        "book_location": {
            "floor": 3,
            "aisle": 6,
            "section": "Nature"
        },
        "edition": 2,
        "genre": "Action",
        "ISBN": "123",
        "name": "Timeless",
        "publisher": "Elsevier",
        "status": AVAILABLE,
        "year_published": 2001
    }
];

table<student> key(student_number) testStudents = table [
    {
        "first_name": "Fillemon",
        "last_name": "Meki",
        "student_number": "220106436"
    },
    {
        "first_name": "Deon",
        "last_name": "Eben",
        "student_number": "221070001"
    }
];
table<librarian> key(staff_id) testLibrarians = table [
    {
        "first_name": "Michael",
        "last_name": "Ndhlukula",
        "staff_id": "22"
    },
    {
        "first_name": "Miika",
        "last_name": "Hangara",
        "staff_id": "33"
    }
];

table<admin> key(staff_id) testAdmins = table [
     {
        "first_name": "Mike",
        "last_name": "Tyson",
        "staff_id": "44"
    }
];
