import ballerina/grpc;
import ballerina/math;

// Define a string constant for service descriptor
const string LIBRARY_DESC = "Library Service";

// Define a list to store books globally
type Book record {
    string title;
    string author_1;
    string? author_2;
    string location;
    string ISBN;
    boolean available;
};

Book[] books = [];

type User record {
    int userId;
    string profile;
};

type BookList record {
    Book[] books;
};

listener grpc:Listener ep = new (9090);

@grpc:Descriptor {value: LIBRARY_DESC}
service "LibraryService" on ep {
    User[] users = [];
    int nextUserId = 1;

    remote function addBook(Book value) returns string|error {
        // Generate a unique ISBN for the added book
        string ISBN = generateISBN();
        value.ISBN = ISBN;
        value.available = true;

        // Add the incoming book to the list of books
        books.push(value);
        return ISBN;
    }

    remote function createUsers(stream<User, grpc:Error?> clientStream) returns string|error {
        while (true) {
            var user, err = clientStream.next();
            if (err is grpc:EOS) {
                break;
            } else if (err != null) {
                return err;
            } else if (user is User) {
                // Assign a unique user ID and add the user to the list
                user.userId = nextUserId;
                nextUserId++;
                users.push(user);
            }
        }
        return "Users created successfully";
    }

    remote function updateBook(Book value) returns Book|error {
        // Find the book by ISBN and update its information
        for (int i = 0; i < books.length(); i++) {
            if (books[i].ISBN == value.ISBN) {
                books[i] = value; // Update the book
                return value;
            }
        }
        return error("Book not found");
    }

    remote function removeBook(string ISBN) returns BookList|error {
        // Remove the book with the specified ISBN from the list
        for (int i = 0; i < books.length(); i++) {
            if (books[i].ISBN == ISBN) {
                books.remove(i);
                return { books: books }; // Return the updated list of books
            }
        }
        return error("Book not found");
    }

    remote function listAvailableBooks(Empty value) returns BookList|error {
        Book[] availableBooks = filterAvailableBooks();
        return { books: availableBooks };
    }

    remote function locateBook(string ISBN) returns string|error {
        // Search for the book by ISBN
        for (Book book in books) {
            if (book.ISBN == ISBN) {
                if (book.available) {
                    return "Location: " + book.location;
                } else {
                    return "Book is not available";
                }
            }
        }
        return error("Book not found");
    }

    remote function borrowBook(User user, string ISBN) returns string|error {
        // Check if the user exists
        boolean userExists = false;
        for (User u in users) {
            if (u.userId == user.userId) {
                userExists = true;
                break;
            }
        }

        if (!userExists) {
            return error("User not found");
        }

        // Search for the book by ISBN
        for (int i = 0; i < books.length(); i++) {
            if (books[i].ISBN == ISBN) {
                if (books[i].available) {
                    books[i].available = false;
                    return "Book borrowed successfully";
                } else {
                    return "Book is already borrowed";
                }
            }
        }
        return error("Book not found");
    }

    function generateISBN() returns string {
        // Generate a unique ISBN using math:randRange
        int randomNum = math:randRange(1000, 9999);
        return "ISBN-" + string(randomNum);
    }

    function filterAvailableBooks() returns Book[] {
        Book[] availableBooks = [];
        for (Book book in books) {
            if (book.available) {
                availableBooks.push(book);
            }
        }
        return availableBooks;
    }
}
