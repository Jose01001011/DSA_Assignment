import ballerina/grpc;
import ballerina/protobuf;
import ballerina/protobuf.types.wrappers;

public const string LIBRARY_DESC = "0A0D6C6962726172792E70726F746F1A1E676F6F676C652F70726F746F6275662F77726170706572732E70726F746F229A010A04426F6F6B12140A057469746C6518012001280952057469746C6512190A08617574686F725F311802200128095207617574686F723112190A08617574686F725F321803200128095207617574686F7232121A0A086C6F636174696F6E18042001280952086C6F636174696F6E12120A044953424E18052001280952044953424E12160A06737461747573180620012808520673746174757322380A045573657212160A06757365724964180120012809520675736572496412180A0770726F66696C65180220012809520770726F66696C6522A4010A0E416464426F6F6B5265717565737412140A057469746C6518012001280952057469746C6512190A08617574686F725F311802200128095207617574686F723112190A08617574686F725F321803200128095207617574686F7232121A0A086C6F636174696F6E18042001280952086C6F636174696F6E12120A044953424E18052001280952044953424E12160A06737461747573180620012808520673746174757322270A1152656D6F7665426F6F6B5265717565737412120A044953424E18012001280952044953424E223F0A1252656D6F7665426F6F6B526573706F6E736512290A0C75706461746564426F6F6B7318012003280B32052E426F6F6B520C75706461746564426F6F6B7322A7010A11557064617465426F6F6B5265717565737412120A044953424E18012001280952044953424E12140A057469746C6518022001280952057469746C6512190A08617574686F725F311803200128095207617574686F723112190A08617574686F725F321804200128095207617574686F7232121A0A086C6F636174696F6E18052001280952086C6F636174696F6E12160A067374617475731806200128085206737461747573221B0A194C697374417661696C61626C65426F6F6B735265717565737422270A114C6F63617465426F6F6B5265717565737412120A044953424E18012001280952044953424E224A0A124C6F63617465426F6F6B526573706F6E7365121A0A086C6F636174696F6E18012001280952086C6F636174696F6E12180A076D65737361676518022001280952076D657373616765223F0A11426F72726F77426F6F6B5265717565737412160A06757365724964180120012809520675736572496412120A044953424E18022001280952044953424E222E0A12426F72726F77426F6F6B526573706F6E736512180A076D65737361676518012001280952076D65737361676532A8030A0E4C6962726172795365727669636512390A086164645F626F6F6B120F2E416464426F6F6B526571756573741A1C2E676F6F676C652E70726F746F6275662E537472696E6756616C756512350A0C6372656174655F757365727312052E557365721A1C2E676F6F676C652E70726F746F6275662E537472696E6756616C75652801123F0A0B7570646174655F626F6F6B12122E557064617465426F6F6B526571756573741A1C2E676F6F676C652E70726F746F6275662E537472696E6756616C756512360A0B72656D6F76655F626F6F6B12122E52656D6F7665426F6F6B526571756573741A132E52656D6F7665426F6F6B526573706F6E7365123B0A146C6973745F617661696C61626C655F626F6F6B73121A2E4C697374417661696C61626C65426F6F6B73526571756573741A052E426F6F6B300112360A0B6C6F636174655F626F6F6B12122E4C6F63617465426F6F6B526571756573741A132E4C6F63617465426F6F6B526573706F6E736512360A0B626F72726F775F626F6F6B12122E426F72726F77426F6F6B526571756573741A132E426F72726F77426F6F6B526573706F6E7365620670726F746F33";

public isolated client class LibraryServiceClient {
    *grpc:AbstractClientEndpoint;

    private final grpc:Client grpcClient;

    public isolated function init(string url, *grpc:ClientConfiguration config) returns grpc:Error? {
        self.grpcClient = check new (url, config);
        check self.grpcClient.initStub(self, LIBRARY_DESC);
    }

    isolated remote function add_book(AddBookRequest|ContextAddBookRequest req) returns string|grpc:Error {
        map<string|string[]> headers = {};
        AddBookRequest message;
        if req is ContextAddBookRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("LibraryService/add_book", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return result.toString();
    }

    isolated remote function add_bookContext(AddBookRequest|ContextAddBookRequest req) returns wrappers:ContextString|grpc:Error {
        map<string|string[]> headers = {};
        AddBookRequest message;
        if req is ContextAddBookRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("LibraryService/add_book", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: result.toString(), headers: respHeaders};
    }

    isolated remote function update_book(UpdateBookRequest|ContextUpdateBookRequest req) returns string|grpc:Error {
        map<string|string[]> headers = {};
        UpdateBookRequest message;
        if req is ContextUpdateBookRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("LibraryService/update_book", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return result.toString();
    }

    isolated remote function update_bookContext(UpdateBookRequest|ContextUpdateBookRequest req) returns wrappers:ContextString|grpc:Error {
        map<string|string[]> headers = {};
        UpdateBookRequest message;
        if req is ContextUpdateBookRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("LibraryService/update_book", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: result.toString(), headers: respHeaders};
    }

    isolated remote function remove_book(RemoveBookRequest|ContextRemoveBookRequest req) returns RemoveBookResponse|grpc:Error {
        map<string|string[]> headers = {};
        RemoveBookRequest message;
        if req is ContextRemoveBookRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("LibraryService/remove_book", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <RemoveBookResponse>result;
    }

    isolated remote function remove_bookContext(RemoveBookRequest|ContextRemoveBookRequest req) returns ContextRemoveBookResponse|grpc:Error {
        map<string|string[]> headers = {};
        RemoveBookRequest message;
        if req is ContextRemoveBookRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("LibraryService/remove_book", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <RemoveBookResponse>result, headers: respHeaders};
    }

    isolated remote function locate_book(LocateBookRequest|ContextLocateBookRequest req) returns LocateBookResponse|grpc:Error {
        map<string|string[]> headers = {};
        LocateBookRequest message;
        if req is ContextLocateBookRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("LibraryService/locate_book", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <LocateBookResponse>result;
    }

    isolated remote function locate_bookContext(LocateBookRequest|ContextLocateBookRequest req) returns ContextLocateBookResponse|grpc:Error {
        map<string|string[]> headers = {};
        LocateBookRequest message;
        if req is ContextLocateBookRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("LibraryService/locate_book", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <LocateBookResponse>result, headers: respHeaders};
    }

    isolated remote function borrow_book(BorrowBookRequest|ContextBorrowBookRequest req) returns BorrowBookResponse|grpc:Error {
        map<string|string[]> headers = {};
        BorrowBookRequest message;
        if req is ContextBorrowBookRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("LibraryService/borrow_book", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <BorrowBookResponse>result;
    }

    isolated remote function borrow_bookContext(BorrowBookRequest|ContextBorrowBookRequest req) returns ContextBorrowBookResponse|grpc:Error {
        map<string|string[]> headers = {};
        BorrowBookRequest message;
        if req is ContextBorrowBookRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("LibraryService/borrow_book", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <BorrowBookResponse>result, headers: respHeaders};
    }

    isolated remote function create_users() returns Create_usersStreamingClient|grpc:Error {
        grpc:StreamingClient sClient = check self.grpcClient->executeClientStreaming("LibraryService/create_users");
        return new Create_usersStreamingClient(sClient);
    }

    isolated remote function list_available_books(ListAvailableBooksRequest|ContextListAvailableBooksRequest req) returns stream<Book, grpc:Error?>|grpc:Error {
        map<string|string[]> headers = {};
        ListAvailableBooksRequest message;
        if req is ContextListAvailableBooksRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeServerStreaming("LibraryService/list_available_books", message, headers);
        [stream<anydata, grpc:Error?>, map<string|string[]>] [result, _] = payload;
        BookStream outputStream = new BookStream(result);
        return new stream<Book, grpc:Error?>(outputStream);
    }

    isolated remote function list_available_booksContext(ListAvailableBooksRequest|ContextListAvailableBooksRequest req) returns ContextBookStream|grpc:Error {
        map<string|string[]> headers = {};
        ListAvailableBooksRequest message;
        if req is ContextListAvailableBooksRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeServerStreaming("LibraryService/list_available_books", message, headers);
        [stream<anydata, grpc:Error?>, map<string|string[]>] [result, respHeaders] = payload;
        BookStream outputStream = new BookStream(result);
        return {content: new stream<Book, grpc:Error?>(outputStream), headers: respHeaders};
    }
}

public client class Create_usersStreamingClient {
    private grpc:StreamingClient sClient;

    isolated function init(grpc:StreamingClient sClient) {
        self.sClient = sClient;
    }

    isolated remote function sendUser(User message) returns grpc:Error? {
        return self.sClient->send(message);
    }

    isolated remote function sendContextUser(ContextUser message) returns grpc:Error? {
        return self.sClient->send(message);
    }

    isolated remote function receiveString() returns string|grpc:Error? {
        var response = check self.sClient->receive();
        if response is () {
            return response;
        } else {
            [anydata, map<string|string[]>] [payload, _] = response;
            return payload.toString();
        }
    }

    isolated remote function receiveContextString() returns wrappers:ContextString|grpc:Error? {
        var response = check self.sClient->receive();
        if response is () {
            return response;
        } else {
            [anydata, map<string|string[]>] [payload, headers] = response;
            return {content: payload.toString(), headers: headers};
        }
    }

    isolated remote function sendError(grpc:Error response) returns grpc:Error? {
        return self.sClient->sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.sClient->complete();
    }
}

public class BookStream {
    private stream<anydata, grpc:Error?> anydataStream;

    public isolated function init(stream<anydata, grpc:Error?> anydataStream) {
        self.anydataStream = anydataStream;
    }

    public isolated function next() returns record {|Book value;|}|grpc:Error? {
        var streamValue = self.anydataStream.next();
        if (streamValue is ()) {
            return streamValue;
        } else if (streamValue is grpc:Error) {
            return streamValue;
        } else {
            record {|Book value;|} nextRecord = {value: <Book>streamValue.value};
            return nextRecord;
        }
    }

    public isolated function close() returns grpc:Error? {
        return self.anydataStream.close();
    }
}

public type ContextUserStream record {|
    stream<User, error?> content;
    map<string|string[]> headers;
|};

public type ContextBookStream record {|
    stream<Book, error?> content;
    map<string|string[]> headers;
|};

public type ContextLocateBookRequest record {|
    LocateBookRequest content;
    map<string|string[]> headers;
|};

public type ContextLocateBookResponse record {|
    LocateBookResponse content;
    map<string|string[]> headers;
|};

public type ContextUser record {|
    User content;
    map<string|string[]> headers;
|};

public type ContextRemoveBookRequest record {|
    RemoveBookRequest content;
    map<string|string[]> headers;
|};

public type ContextBorrowBookResponse record {|
    BorrowBookResponse content;
    map<string|string[]> headers;
|};

public type ContextUpdateBookRequest record {|
    UpdateBookRequest content;
    map<string|string[]> headers;
|};

public type ContextListAvailableBooksRequest record {|
    ListAvailableBooksRequest content;
    map<string|string[]> headers;
|};

public type ContextBook record {|
    Book content;
    map<string|string[]> headers;
|};

public type ContextAddBookRequest record {|
    AddBookRequest content;
    map<string|string[]> headers;
|};

public type ContextBorrowBookRequest record {|
    BorrowBookRequest content;
    map<string|string[]> headers;
|};

public type ContextRemoveBookResponse record {|
    RemoveBookResponse content;
    map<string|string[]> headers;
|};

@protobuf:Descriptor {value: LIBRARY_DESC}
public type LocateBookRequest record {|
    string ISBN = "";
|};

@protobuf:Descriptor {value: LIBRARY_DESC}
public type LocateBookResponse record {|
    string location = "";
    string message = "";
|};

@protobuf:Descriptor {value: LIBRARY_DESC}
public type User record {|
    string userId = "";
    string profile = "";
|};

@protobuf:Descriptor {value: LIBRARY_DESC}
public type RemoveBookRequest record {|
    string ISBN = "";
|};

@protobuf:Descriptor {value: LIBRARY_DESC}
public type BorrowBookResponse record {|
    string message = "";
|};

@protobuf:Descriptor {value: LIBRARY_DESC}
public type Book record {|
    string title = "";
    string author_1 = "";
    string author_2 = "";
    string location = "";
    string ISBN = "";
    boolean status = false;
|};

@protobuf:Descriptor {value: LIBRARY_DESC}
public type UpdateBookRequest record {|
    string ISBN = "";
    string title = "";
    string author_1 = "";
    string author_2 = "";
    string location = "";
    boolean status = false;
|};

@protobuf:Descriptor {value: LIBRARY_DESC}
public type ListAvailableBooksRequest record {|
|};

@protobuf:Descriptor {value: LIBRARY_DESC}
public type AddBookRequest record {|
    string title = "";
    string author_1 = "";
    string author_2 = "";
    string location = "";
    string ISBN = "";
    boolean status = false;
|};

@protobuf:Descriptor {value: LIBRARY_DESC}
public type BorrowBookRequest record {|
    string userId = "";
    string ISBN = "";
|};

@protobuf:Descriptor {value: LIBRARY_DESC}
public type RemoveBookResponse record {|
    Book[] updatedBooks = [];
|};

