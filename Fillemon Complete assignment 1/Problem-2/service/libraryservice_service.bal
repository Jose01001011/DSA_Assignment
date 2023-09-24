import ballerina/grpc;
import ballerina/random;
import ballerina/log;


listener grpc:Listener ep = new (9090);


type BookRecord record {
    string title;
    string author_1;
    string? author_2;
    string location;
    string ISBN;
    boolean status;
};


@grpc:Descriptor {value: LIBRARY_DESC}
service "LibraryService" on ep {

     remote  function add_book(AddBookRequest value) returns (string|error) {
        // Generate a unique ISBN for the book
        string|error uniqueISBN = generateUniqueISBN();
        // Create a BookRecord with the provided values
        BookRecord newBook = {
            title: value.title,
            author_1: value.author_1,
            author_2: value.author_2,
            location: value.location,
            ISBN: check uniqueISBN,
            status: value.status
        };
        // Add the new book to the library
        libraryBooks.push(newBook);
        
        // Return the unique ISBN as a response
        return uniqueISBN;
    }
    // Other remote functions (create_users, update_book, remove_book, etc.) go here

    

   remote function update_book(UpdateBookRequest value) returns string|error {
    // Find the book in the libraryBooks array based on ISBN
    int bookIndex = findBookIndexByISBN(value.ISBN);
    
    if (bookIndex == -1) {
        // Book not found, return an error
        return "Book not found";
    } else {
        // Update the book details with the provided values
        libraryBooks[bookIndex].title = value.title;
        libraryBooks[bookIndex].author_1 = value.author_1;
        libraryBooks[bookIndex].author_2 = value.author_2;
        libraryBooks[bookIndex].location = value.location;
        libraryBooks[bookIndex].status = value.status;
        
        // Return a success message
        return "Book updated successfully";
    }
}
remote function remove_book(RemoveBookRequest value) returns RemoveBookResponse|error {
    // Find the book in the libraryBooks array based on ISBN
    int bookIndex = findBookIndexByISBN(value.ISBN);

    if (bookIndex == -1) {
        // Book not found, return an error
        return error("Book not found");
    } else {
        // Remove the book from the libraryBooks array
        _ = libraryBooks.remove(bookIndex);

        // Create a response with the updated list of books
        RemoveBookResponse response = {updatedBooks:<Book[]>libraryBooks};

        // Return the response
        return response;
    }
}






  remote function locate_book(LocateBookRequest value) returns LocateBookResponse|error {
    // Find the book in the libraryBooks array based on ISBN
    int bookIndex = findBookIndexByISBN(value.ISBN);

    if (bookIndex == -1) {
        // Book not found, return an error
        return error("Book not found");
    } else {
        // Book found, return its location
        string location = libraryBooks[bookIndex].location;
        LocateBookResponse response = {
            location: location
        };
        return response;
    }
}

remote function borrow_book(BorrowBookRequest value) returns BorrowBookResponse|error {
    string userId = value.userId;
    string ISBN = value.ISBN;
    BorrowBookResponse response = {};

    // Check if the user (student) exists in the users array
    boolean userExists = isUserExists(userId);

    if (!userExists) {
        // User does not exist
        return {message: "User with ID " + userId + " does not exist."};
    }

    // Find the index of the book with the provided ISBN
    int bookIndex = findBookIndexByISBN(ISBN);

    if (bookIndex != -1) {
        // Book with the provided ISBN found in the library
        BookRecord book = libraryBooks[bookIndex];

        // Check if the book is available to be borrowed
        if (book.status) {
            // Implement logic to update the book's status to "not available"
            // Associate the book with the borrower's user ID
            
            // Return a response indicating successful borrowing
            response.message = "Book with ISBN " + ISBN + " has been borrowed successfully by User ID " + userId + ".";
            return response;
        } else {
            // Book is not available for borrowing
            return {message: "Book with ISBN " + ISBN + " is not available for borrowing."};
        }
    } else {
        // Book with the provided ISBN not found in the library
        return {message: "Book with ISBN " + ISBN + " not found in the library."};
    }
}


       remote function create_users(stream<User, grpc:Error?> clientStream) returns string|error {
        check clientStream.forEach(function(User user) {
            // Add the user to the users array
            users.push(user);

            // Log the received user information (optional)
            log:printInfo("Received User: " + user.profile + "\n");
        });

        // Return a success message
        return "Users have been added successfully";
    }
remote function list_available_books(ListAvailableBooksRequest value) returns stream<BookRecord, error?> {
        // Create a stream to send available books
        stream<BookRecord, error?> availableBooksStream = new;

        // Iterate through the libraryBooks array
        foreach BookRecord book in libraryBooks {
            if (book.status) {
                // If the book is available, send it to the client
                
                log:printInfo("Sending available book - ISBN: " + book.ISBN + ", Title: " + book.title);
            }
        }

       
        
        return availableBooksStream;
    }
}


// Function to check if the book with the provided ISBN exists and is available in the library



// Function to generate a unique ISBN (you can implement this logic)
    // Function to generate a unique ISBN
  // Function to generate a unique ISBN
    // Function to generate a unique ISBN
    isolated function generateUniqueISBN() returns string|error {
        // Generate a random number between 1 and 10000
        int min = 1;
        int max = 10000;
        // int randomNum = random(min, max);
        int randomNum = check random:createIntInRange(min, max);
        return "ISBN-" + randomNum.toString();
    }

// Function to find the index of a book by ISBN
// Function to find the index of a book by ISBN
// Function to find the index of a book by ISBN
function findBookIndexByISBN(string ISBN) returns int {
    foreach var book in libraryBooks {
        if (book.ISBN == ISBN) {
            return libraryBooks.indexOf(book) ?: 0;
        }
    }
    return -1; // Book not found
}

// Function to check if the user (student) exists in the users array
function isUserExists(string userId) returns boolean {
    // Iterate through the users array and check if the user exists
    foreach User user in users {
        if (user.userId == userId) {
            return true;
        }
    }
    return false;
}
// Define an array to store book records
BookRecord[] libraryBooks = [];
User[] users = [];

