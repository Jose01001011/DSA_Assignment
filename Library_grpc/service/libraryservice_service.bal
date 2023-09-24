import ballerina/grpc;
import ballerina/io;
import ballerina/random;

Book[] books = [];

function generateISBN() returns string {
    // Generate a unique ISBN using math:randRange
    do {
	    // Generate a unique ISBN using math:randRange
	    int randomNum = check random:createIntInRange(1000, 9999);
        return string ISBN-${randomNum};
    } on fail var e {
    	io:println(e.cause());
    }
}

function filterAvailableBooks() returns Book[] {
    Book[] availableBooks = [];
    foreach Book book in books {
        if book.status{
            availableBooks.push(book);
        }
    }
    return availableBooks;
}
    int nextUserId = 1;
    User[] users = [];
listener grpc:Listener ep = new (9090);

@grpc:Descriptor {value: LIBRARY_DESC}
service "LibraryService" on ep {


    remote function addBook(Book value) returns string|error {
        // Generate a unique ISBN for the added book
        string ISBN = generateISBN();
        value.isbn = ISBN;
        value.status = true;

        // Add the incoming book to the list of books
        books.push(value);
        return ISBN;
    }

    remote function createUsers(stream<User, grpc:Error?> clientStream) returns string|error {
        while (true) {
            record {|User value;|}|grpc:Error? user = clientStream.next();
            if (user is grpc:Error) {
                break;
            } else {
                return "users created successfully";
                // Assign a unique user ID and add the user to the list
                // user = nextUserId;
                // nextUserId+=1;
                // users.push(user);
            } 

        }
        return "Users created successfully";
    }

    remote function updateBook(Book value) returns Book|error {
        // Find the book by ISBN and update its information
        int i = 0;
        while i < books.length() {
            if (books[i].isbn == value.isbn) {
                books[i] = value; // Update the book
                return value;
            }

            i += 1;
        }
        return error("Book not found");
    }

    remote function removeBook(string ISBN) returns BookList|error {
        // Remove the book with the specified ISBN from the list
        int i =0;
        while i < books.length() {
            if (books[i].isbn == ISBN) {
                _ = books.remove(i);
                return { books: books }; // Return the updated list of books
            }

            i += 1;
        }
        return error("Book not found");
    }

    remote function listAvailableBooks(Empty value) returns BookList|error {
        Book[] availableBooks = filterAvailableBooks();
        return { books: availableBooks };
    }

    remote function locateBook(string ISBN) returns string|error {
        // Search for the book by ISBN
        foreach Book book in books {
            if (book.isbn == ISBN) {
                if (book.status) {
                    return "Location: " + book.location;
                } else {
                    return "Book is not available";
                }
            }
        }
        return error("Book not found");
    }

    remote function borrowBook(BorrowRequest value) returns string|error {
        // Check if the user exists
        boolean userExists = false;

        foreach User u in users {
            if (u.user_id == value.user_id) {
                userExists = true;
                break;
            }
        }

        if (!userExists) {
            return error("User not found");
        }

        // Search for the book by ISBN
        int i = 0;
        while i < books.length() {
            if (books[i].isbn == value.isbn) {
                if (books[i].status) {
                    books[i].status = false;
                    return "Book borrowed successfully";
                } else {
                    return "Book is already borrowed";
                }
            }

            i += 1;
        }
        return error("Book not found");
    }

    
}
