import ballerina/io;

LibrarySystemClient ep = check new ("http://localhost:9090");

function printMenu() {

    io:println("****************************************************");
    io:println("|                    CHOOSE AN OPTION?             |");
    io:println("| 1. Add new book                                  |");
    io:println("| 2. Update existing book                          |");
    io:println("| 3. Delete book                                   |");
    io:println("| 4. Display borrowed books                        |");
    io:println("| 5. Display all available books                   |");
    io:println("| 6. Borrow a book                                 |");
    io:println("| 7. Return a book                                 |");
    io:println("| 8. Find a book                                   |");
    io:println("| 9. Create users                                  |");
    io:println("| 0. EXIT                                          |");
    io:println("****************************************************");
}

public function main() returns error? {
    while true {
        printMenu();
        string choice = io:readln("Enter choice 1 - 9: ");

        match choice {
            "0" => {
                break;
            }
            "1" => {
                var isbn = io:readln("Input ISBN: ");
                var book_name = io:readln("Input book name: ");
                var author_first_name = io:readln("Author first name: ");
                var author_middle_name = io:readln("Author middle name: ");
                var author_last_name = io:readln("Author last name: ");
                var publisher = io:readln("Publisher: ");
                var genre = io:readln("Enter genre: ");
                int|error year_published = int:fromString(io:readln("Year published: "));
                int|error edition = int:fromString(io:readln("Book edition: "));
                var section = io:readln("Enter section: ");
                int|error aisle = int:fromString(io:readln("Enter aisle: "));
                int|error floor = int:fromString(io:readln("Floor: "));

                // add_book
                if (year_published !is error && aisle !is error && floor !is error && edition !is error) {
                    book add_bookRequest = {
                        ISBN: isbn,
                        name: book_name,
                        authors: [
                            {
                                first_name: author_first_name,
                                middle_name: author_middle_name,
                                last_name: author_last_name
                            }
                        ],
                        publisher: publisher,
                        genre: genre,
                        year_published: year_published,
                        edition: edition,
                        status: "AVAILABLE",
                        book_location: {
                            section: section,
                            aisle: aisle,
                            floor: floor
                        }
                    };
                    string add_bookResponse = check ep->add_book(add_bookRequest);
                    io:println(add_bookResponse);
                    continue;
                }
                io:print("Invalid details entered");
                continue;
            }
            "2" => {
                var isbn = io:readln("Input ISBN: ");
                var book_name = io:readln("Input book name: ");
                var author_first_name = io:readln("Author first name: ");
                var author_middle_name = io:readln("Author middle name: ");
                var author_last_name = io:readln("Author last name: ");
                var publisher = io:readln("Publisher: ");
                var genre = io:readln("Enter genre: ");
                int|error year_published = int:fromString(io:readln("Year published: "));
                int|error edition = int:fromString(io:readln("Book edition: "));
                var section = io:readln("Enter section: ");
                int|error aisle = int:fromString(io:readln("Enter aisle: "));
                int|error floor = int:fromString(io:readln("Floor: "));
                //update book 
                if (year_published !is error && aisle !is error && floor !is error && edition !is error) {

                    book update_bookRequest = {
                        ISBN: isbn,
                        name: book_name,
                        authors: [
                            {
                                first_name: author_first_name,
                                middle_name: author_middle_name,
                                last_name: author_last_name
                            }
                        ],
                        publisher: publisher,
                        genre: genre,
                        year_published: year_published,
                        edition: edition,
                        status: "AVAILABLE",
                        book_location: {
                            section: section,
                            aisle: aisle,
                            floor: floor
                        }
                    };
                    string update_bookResponse = check ep->update_book(update_bookRequest);
                    io:println(update_bookResponse);
                    continue;
                }
                io:print("Details Entered are Invalid");
                continue;
            }
            "3" => {
                // remove_book
                var isbn = io:readln("ISBN: ");
                stream<book, error?> remove_bookResponse = check ep->remove_book(isbn);
                check remove_bookResponse.forEach(function(book value) {
                    io:println(value);
                });
                continue;
            }
            "4" => {
                // get_borrowed_book
                stream<book, error?> get_borrowed_bookResponse = check ep->get_borrowed_book();
                check get_borrowed_bookResponse.forEach(function(book value) {
                    io:println(value);
                });
                continue;
            }
            "5" => {
                // list_available_book
                stream<book, error?> list_available_bookResponse = check ep->list_available_book();
                check list_available_bookResponse.forEach(function(book value) {
                    io:println(value);
                });
                continue;
            }
            "6" => {
                var isbn = io:readln("ISBN: ");
                var student_number = io:readln("Enter student number: ");
                // borrow_book
                StudentRequest borrow_bookRequest = {
                    student_number: student_number,
                    ISBN: isbn
                };
                string borrow_bookResponse = check ep->borrow_book(borrow_bookRequest);
                io:println(borrow_bookResponse);
                continue;
            }
            "7" => {
                var isbn = io:readln("ISBN: ");
                var student_number = io:readln("Enter student number: ");
                // return_book
                StudentRequest return_bookRequest = {
                    student_number: student_number,
                    ISBN: isbn
                };
                string return_bookResponse = check ep->return_book(return_bookRequest);
                io:println(return_bookResponse);
                continue;
            }
            "8" => {
                var isbn = io:readln("ISBN: ");
                // locate_book
                string locate_bookRequest = isbn;
                location locate_bookResponse = check ep->locate_book(locate_bookRequest);
                io:println(locate_bookResponse);
                continue;
            }
            "9" => {
                // create_users
                UserRequest create_usersRequest = {
                    student: {
                        student_number: "ballerina",
                        first_name: "ballerina",
                        last_name: "ballerina"
                    },
                    librarian: {
                        staff_id: "ballerina",
                        first_name: "ballerina",
                        last_name: "ballerina"
                    }
                };
                Create_usersStreamingClient create_usersStreamingClient = check ep->create_users();
                check create_usersStreamingClient->sendUserRequest(create_usersRequest);
                check create_usersStreamingClient->complete();
                string? create_usersResponse = check create_usersStreamingClient->receiveString();
                io:println(create_usersResponse);
                continue;
            }
            _ => {
                io:println("Select 1 - 9");
                continue;
            }
        }
    }

}

