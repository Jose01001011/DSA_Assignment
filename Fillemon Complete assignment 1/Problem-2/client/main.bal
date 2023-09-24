import ballerina/io;

// import ballerina/grpc;

// Define gRPC client and endpoint
LibraryServiceClient endp = check new ("http://localhost:9090");
// Define the BookRecord type
type BookRecord record {
    string ISBN;
    string title;
    boolean status;
};

public function main() returns error? {
// Define the list of users to be created
    User[] newUsers = [
        {userId: "1", profile: "User Profile 1"},
        {userId: "2", profile: "User Profile 2"},
        {userId: "3", profile: "User Profile 3"},
        {userId: "4", profile: "User Profile 4"}
        // Add more users as needed
    ];

    // Create gRPC client instance and initiate the create_users operation
    Create_usersStreamingClient createUsersClient = check  endp->create_users();

    // Stream the list of users to the server
    foreach User user in newUsers {
        check createUsersClient->sendUser(user);
        
    }
    
    // Indicate that the client has finished sending data
    check createUsersClient->complete();

    // Receive the response from the server
    string? createUsersResponse = check createUsersClient->receiveString();

    // Print the response
    io:println(createUsersResponse);

    // Handle any errors if needed

    // Return an error if an error occurred
    // return error("Error occurred during user creation");

    // Return nil or any other value if the operation was successful
    // return ();




 
    // Book 1
    AddBookRequest book1 = {
        title: "Rich Dad Poor Dad",
        author_1: "Robert Kiyosaki",
        author_2: "Sharon Lechter",
        location: "Library Shelf 1",
        status: true
    };
    string|error response1 = check endp->add_book(book1);
    io:println("Add Book 1 Response: ", response1);

    // Book 2
    AddBookRequest book2 = {
        title: "The Great Gatsby",
        author_1: "F. Scott Fitzgerald",
        author_2: "",
        location: "Library Shelf 2",
        status: true
    };
    string|error response2 = check endp->add_book(book2);
    io:println("Add Book 2 Response: ", response2);

    // Book 3
    AddBookRequest book3 = {
        title: "To Kill a Mockingbird",
        author_1: "Harper Lee",
        author_2: "",
        location: "Library Shelf 3",
        status: true
    };
    string|error response3 = check endp->add_book(book3);
    io:println("Add Book 3 Response: ", response3);

    // Invoke the update_book operation
    io:println("Updating a book...");
    UpdateBookRequest updateBookRequest = {
        ISBN: check response1,
        title: "Katsanana",
        author_1: "Tsanana2",
        author_2: "Tsatsa",
        location: "Library Shelf 7",
        status: true
    };
    string|error updateBookResponse = check endp->update_book(updateBookRequest);
    io:println("Update Book Response: ", updateBookResponse);

        // Invoke the remove_book operation
    // io:println("Removing a book...");
    
    // RemoveBookRequest removeBookRequest = {
    //     ISBN: check response2
    // };
    //  RemoveBookResponse|error  removeBookResponse = check endp->remove_book(removeBookRequest);

  
    //  if (removeBookResponse is error) {
    //     io:println("Remove Book Error: ", removeBookResponse);
    // } else {
    //     io:println("Book removed successfully.");
    // }
    
 


    // Invoke the locate_book operation
    io:println("Locating a book-----------------------");
    io:println("Please Wait..."); 
    LocateBookRequest locateBookRequest = {
        ISBN: check response3
    };
    LocateBookResponse|error locateBookResponse = check endp->locate_book(locateBookRequest);
    if (locateBookResponse is LocateBookResponse) {
        io:println("Here you go, we have found your Book");
        io:println("Book Location: ", locateBookResponse.location);
    } else {
        io:println("Failed to locate the book with ISBN: ", locateBookResponse);
        
    }

    // Invoke the borrow_book operation
    io:println("Borrowing a book...");
    BorrowBookRequest borrowBookRequest = {
        userId: "1",
        ISBN: check response3
    };
    BorrowBookResponse|error borrowBookResponse = check endp->borrow_book(borrowBookRequest);
    if (borrowBookResponse is BorrowBookResponse) {
        io:println("Borrow Book Response: ", borrowBookResponse.message);
    } else {
        io:println("Borrow Book Error: ", borrowBookResponse);
    }

    // Add more client-side operations as needed

    // Return success
    // return null;
    ListAvailableBooksRequest list_available_booksRequest = {};
    stream<Book, error?> list_available_booksResponse = check endp->list_available_books(list_available_booksRequest);
    check list_available_booksResponse.forEach(function(Book value) {
        io:println(value);
    });
     
    RemoveBookRequest remove_bookRequest = {ISBN: "1435"};
    RemoveBookResponse remove_bookResponse = check endp->remove_book(remove_bookRequest);
    io:println(remove_bookResponse);
    return null;
}
