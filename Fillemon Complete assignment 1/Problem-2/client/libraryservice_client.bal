// import ballerina/io;

// LibraryServiceClient ep = check new ("http://localhost:9090");

// public function main() returns error? {
//     AddBookRequest add_bookRequest = {title: "ballerina", author_1: "ballerina", author_2: "ballerina", location: "ballerina", ISBN: "ballerina", status: true};
//     string add_bookResponse = check ep->add_book(add_bookRequest);
//     io:println(add_bookResponse);

//     UpdateBookRequest update_bookRequest = {ISBN: "ballerina", title: "ballerina", author_1: "ballerina", author_2: "ballerina", location: "ballerina", status: true};
//     string update_bookResponse = check ep->update_book(update_bookRequest);
//     io:println(update_bookResponse);

//     RemoveBookRequest remove_bookRequest = {ISBN: "ballerina"};
//     RemoveBookResponse remove_bookResponse = check ep->remove_book(remove_bookRequest);
//     io:println(remove_bookResponse);

//     LocateBookRequest locate_bookRequest = {ISBN: "ballerina"};
//     LocateBookResponse locate_bookResponse = check ep->locate_book(locate_bookRequest);
//     io:println(locate_bookResponse);

//     BorrowBookRequest borrow_bookRequest = {userId: "ballerina", ISBN: "ballerina"};
//     BorrowBookResponse borrow_bookResponse = check ep->borrow_book(borrow_bookRequest);
//     io:println(borrow_bookResponse);

//     ListAvailableBooksRequest list_available_booksRequest = {};
//     stream<Book, error?> list_available_booksResponse = check ep->list_available_books(list_available_booksRequest);
//     check list_available_booksResponse.forEach(function(Book value) {
//         io:println(value);
//     });

//     User create_usersRequest = {userId: "ballerina", profile: "ballerina"};
//     Create_usersStreamingClient create_usersStreamingClient = check ep->create_users();
//     check create_usersStreamingClient->sendUser(create_usersRequest);
//     check create_usersStreamingClient->complete();
//     string? create_usersResponse = check create_usersStreamingClient->receiveString();
//     io:println(create_usersResponse);
// }

