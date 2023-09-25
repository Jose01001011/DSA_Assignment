import ballerina/grpc;
import ballerina/protobuf;
import ballerina/protobuf.types.empty;
import ballerina/protobuf.types.wrappers;

public const string LIBRARYSYSTEM_DESC = "0A136C69627261727953797374656D2E70726F746F120D6C69627261727953797374656D1A1E676F6F676C652F70726F746F6275662F77726170706572732E70726F746F1A1B676F6F676C652F70726F746F6275662F656D7074792E70726F746F22770A0B557365725265717565737412300A0773747564656E7418012001280B32162E6C69627261727953797374656D2E73747564656E74520773747564656E7412360A096C696272617269616E18022001280B32182E6C69627261727953797374656D2E6C696272617269616E52096C696272617269616E224B0A0E53747564656E745265717565737412250A0E73747564656E745F6E756D626572180120012809520D73747564656E744E756D62657212120A044953424E18022001280952044953424E226C0A0773747564656E7412250A0E73747564656E745F6E756D626572180120012809520D73747564656E744E756D626572121D0A0A66697273745F6E616D65180220012809520966697273744E616D65121B0A096C6173745F6E616D6518032001280952086C6173744E616D6522620A096C696272617269616E12190A0873746166665F6964180120012809520773746166664964121D0A0A66697273745F6E616D65180220012809520966697273744E616D65121B0A096C6173745F6E616D6518032001280952086C6173744E616D65225E0A0561646D696E12190A0873746166665F6964180120012809520773746166664964121D0A0A66697273745F6E616D65180220012809520966697273744E616D65121B0A096C6173745F6E616D6518032001280952086C6173744E616D6522C6020A04626F6F6B12120A044953424E18012001280952044953424E12120A046E616D6518022001280952046E616D65122F0A07617574686F727318032003280B32152E6C69627261727953797374656D2E617574686F725207617574686F7273121C0A097075626C697368657218042001280952097075626C697368657212140A0567656E7265180520012809520567656E726512250A0E796561725F7075626C6973686564180620012805520D796561725075626C697368656412180A0765646974696F6E180720012805520765646974696F6E12320A0673746174757318082001280E321A2E6C69627261727953797374656D2E626F6F6B5F7374617475735206737461747573123C0A0D626F6F6B5F6C6F636174696F6E18092001280B32172E6C69627261727953797374656D2E6C6F636174696F6E520C626F6F6B4C6F636174696F6E22650A06617574686F72121D0A0A66697273745F6E616D65180120012809520966697273744E616D65121F0A0B6D6964646C655F6E616D65180220012809520A6D6964646C654E616D65121B0A096C6173745F6E616D6518032001280952086C6173744E616D65225A0A0D626F72726F7765645F626F6F6B120E0A0269641801200128095202696412250A0E73747564656E745F6E756D626572180220012809520D73747564656E744E756D62657212120A044953424E18032001280952044953424E22500A086C6F636174696F6E12180A0773656374696F6E180120012809520773656374696F6E12140A056169736C6518022001280552056169736C6512140A05666C6F6F721803200128055205666C6F6F722A2D0A0B626F6F6B5F737461747573120D0A09415641494C41424C451000120F0A0B554E415641494C41424C4510013288050A0D4C69627261727953797374656D124A0A0C6372656174655F7573657273121A2E6C69627261727953797374656D2E55736572526571756573741A1C2E676F6F676C652E70726F746F6275662E537472696E6756616C75652801123D0A086164645F626F6F6B12132E6C69627261727953797374656D2E626F6F6B1A1C2E676F6F676C652E70726F746F6275662E537472696E6756616C756512400A0B7570646174655F626F6F6B12132E6C69627261727953797374656D2E626F6F6B1A1C2E676F6F676C652E70726F746F6275662E537472696E6756616C756512420A0B72656D6F76655F626F6F6B121C2E676F6F676C652E70726F746F6275662E537472696E6756616C75651A132E6C69627261727953797374656D2E626F6F6B300112420A116765745F626F72726F7765645F626F6F6B12162E676F6F676C652E70726F746F6275662E456D7074791A132E6C69627261727953797374656D2E626F6F6B300112440A136C6973745F617661696C61626C655F626F6F6B12162E676F6F676C652E70726F746F6275662E456D7074791A132E6C69627261727953797374656D2E626F6F6B3001124A0A0B626F72726F775F626F6F6B121D2E6C69627261727953797374656D2E53747564656E74526571756573741A1C2E676F6F676C652E70726F746F6275662E537472696E6756616C7565124A0A0B72657475726E5F626F6F6B121D2E6C69627261727953797374656D2E53747564656E74526571756573741A1C2E676F6F676C652E70726F746F6275662E537472696E6756616C756512440A0B6C6F636174655F626F6F6B121C2E676F6F676C652E70726F746F6275662E537472696E6756616C75651A172E6C69627261727953797374656D2E6C6F636174696F6E620670726F746F33";

public isolated client class LibrarySystemClient {
    *grpc:AbstractClientEndpoint;

    private final grpc:Client grpcClient;

    public isolated function init(string url, *grpc:ClientConfiguration config) returns grpc:Error? {
        self.grpcClient = check new (url, config);
        check self.grpcClient.initStub(self, LIBRARYSYSTEM_DESC);
    }

    isolated remote function add_book(book|ContextBook req) returns string|grpc:Error {
        map<string|string[]> headers = {};
        book message;
        if req is ContextBook {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("librarySystem.LibrarySystem/add_book", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return result.toString();
    }

    isolated remote function add_bookContext(book|ContextBook req) returns wrappers:ContextString|grpc:Error {
        map<string|string[]> headers = {};
        book message;
        if req is ContextBook {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("librarySystem.LibrarySystem/add_book", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: result.toString(), headers: respHeaders};
    }

    isolated remote function update_book(book|ContextBook req) returns string|grpc:Error {
        map<string|string[]> headers = {};
        book message;
        if req is ContextBook {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("librarySystem.LibrarySystem/update_book", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return result.toString();
    }

    isolated remote function update_bookContext(book|ContextBook req) returns wrappers:ContextString|grpc:Error {
        map<string|string[]> headers = {};
        book message;
        if req is ContextBook {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("librarySystem.LibrarySystem/update_book", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: result.toString(), headers: respHeaders};
    }

    isolated remote function borrow_book(StudentRequest|ContextStudentRequest req) returns string|grpc:Error {
        map<string|string[]> headers = {};
        StudentRequest message;
        if req is ContextStudentRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("librarySystem.LibrarySystem/borrow_book", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return result.toString();
    }

    isolated remote function borrow_bookContext(StudentRequest|ContextStudentRequest req) returns wrappers:ContextString|grpc:Error {
        map<string|string[]> headers = {};
        StudentRequest message;
        if req is ContextStudentRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("librarySystem.LibrarySystem/borrow_book", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: result.toString(), headers: respHeaders};
    }

    isolated remote function return_book(StudentRequest|ContextStudentRequest req) returns string|grpc:Error {
        map<string|string[]> headers = {};
        StudentRequest message;
        if req is ContextStudentRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("librarySystem.LibrarySystem/return_book", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return result.toString();
    }

    isolated remote function return_bookContext(StudentRequest|ContextStudentRequest req) returns wrappers:ContextString|grpc:Error {
        map<string|string[]> headers = {};
        StudentRequest message;
        if req is ContextStudentRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("librarySystem.LibrarySystem/return_book", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: result.toString(), headers: respHeaders};
    }

    isolated remote function locate_book(string|wrappers:ContextString req) returns location|grpc:Error {
        map<string|string[]> headers = {};
        string message;
        if req is wrappers:ContextString {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("librarySystem.LibrarySystem/locate_book", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <location>result;
    }

    isolated remote function locate_bookContext(string|wrappers:ContextString req) returns ContextLocation|grpc:Error {
        map<string|string[]> headers = {};
        string message;
        if req is wrappers:ContextString {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("librarySystem.LibrarySystem/locate_book", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <location>result, headers: respHeaders};
    }

    isolated remote function create_users() returns Create_usersStreamingClient|grpc:Error {
        grpc:StreamingClient sClient = check self.grpcClient->executeClientStreaming("librarySystem.LibrarySystem/create_users");
        return new Create_usersStreamingClient(sClient);
    }

    isolated remote function remove_book(string|wrappers:ContextString req) returns stream<book, grpc:Error?>|grpc:Error {
        map<string|string[]> headers = {};
        string message;
        if req is wrappers:ContextString {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeServerStreaming("librarySystem.LibrarySystem/remove_book", message, headers);
        [stream<anydata, grpc:Error?>, map<string|string[]>] [result, _] = payload;
        BookStream outputStream = new BookStream(result);
        return new stream<book, grpc:Error?>(outputStream);
    }

    isolated remote function remove_bookContext(string|wrappers:ContextString req) returns ContextBookStream|grpc:Error {
        map<string|string[]> headers = {};
        string message;
        if req is wrappers:ContextString {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeServerStreaming("librarySystem.LibrarySystem/remove_book", message, headers);
        [stream<anydata, grpc:Error?>, map<string|string[]>] [result, respHeaders] = payload;
        BookStream outputStream = new BookStream(result);
        return {content: new stream<book, grpc:Error?>(outputStream), headers: respHeaders};
    }

    isolated remote function get_borrowed_book() returns stream<book, grpc:Error?>|grpc:Error {
        empty:Empty message = {};
        map<string|string[]> headers = {};
        var payload = check self.grpcClient->executeServerStreaming("librarySystem.LibrarySystem/get_borrowed_book", message, headers);
        [stream<anydata, grpc:Error?>, map<string|string[]>] [result, _] = payload;
        BookStream outputStream = new BookStream(result);
        return new stream<book, grpc:Error?>(outputStream);
    }

    isolated remote function get_borrowed_bookContext() returns ContextBookStream|grpc:Error {
        empty:Empty message = {};
        map<string|string[]> headers = {};
        var payload = check self.grpcClient->executeServerStreaming("librarySystem.LibrarySystem/get_borrowed_book", message, headers);
        [stream<anydata, grpc:Error?>, map<string|string[]>] [result, respHeaders] = payload;
        BookStream outputStream = new BookStream(result);
        return {content: new stream<book, grpc:Error?>(outputStream), headers: respHeaders};
    }

    isolated remote function list_available_book() returns stream<book, grpc:Error?>|grpc:Error {
        empty:Empty message = {};
        map<string|string[]> headers = {};
        var payload = check self.grpcClient->executeServerStreaming("librarySystem.LibrarySystem/list_available_book", message, headers);
        [stream<anydata, grpc:Error?>, map<string|string[]>] [result, _] = payload;
        BookStream outputStream = new BookStream(result);
        return new stream<book, grpc:Error?>(outputStream);
    }

    isolated remote function list_available_bookContext() returns ContextBookStream|grpc:Error {
        empty:Empty message = {};
        map<string|string[]> headers = {};
        var payload = check self.grpcClient->executeServerStreaming("librarySystem.LibrarySystem/list_available_book", message, headers);
        [stream<anydata, grpc:Error?>, map<string|string[]>] [result, respHeaders] = payload;
        BookStream outputStream = new BookStream(result);
        return {content: new stream<book, grpc:Error?>(outputStream), headers: respHeaders};
    }
}

public client class Create_usersStreamingClient {
    private grpc:StreamingClient sClient;

    isolated function init(grpc:StreamingClient sClient) {
        self.sClient = sClient;
    }

    isolated remote function sendUserRequest(UserRequest message) returns grpc:Error? {
        return self.sClient->send(message);
    }

    isolated remote function sendContextUserRequest(ContextUserRequest message) returns grpc:Error? {
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

    public isolated function next() returns record {|book value;|}|grpc:Error? {
        var streamValue = self.anydataStream.next();
        if (streamValue is ()) {
            return streamValue;
        } else if (streamValue is grpc:Error) {
            return streamValue;
        } else {
            record {|book value;|} nextRecord = {value: <book>streamValue.value};
            return nextRecord;
        }
    }

    public isolated function close() returns grpc:Error? {
        return self.anydataStream.close();
    }
}

public client class LibrarySystemStringCaller {
    private grpc:Caller caller;

    public isolated function init(grpc:Caller caller) {
        self.caller = caller;
    }

    public isolated function getId() returns int {
        return self.caller.getId();
    }

    isolated remote function sendString(string response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendContextString(wrappers:ContextString response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendError(grpc:Error response) returns grpc:Error? {
        return self.caller->sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.caller->complete();
    }

    public isolated function isCancelled() returns boolean {
        return self.caller.isCancelled();
    }
}

public client class LibrarySystemLocationCaller {
    private grpc:Caller caller;

    public isolated function init(grpc:Caller caller) {
        self.caller = caller;
    }

    public isolated function getId() returns int {
        return self.caller.getId();
    }

    isolated remote function sendLocation(location response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendContextLocation(ContextLocation response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendError(grpc:Error response) returns grpc:Error? {
        return self.caller->sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.caller->complete();
    }

    public isolated function isCancelled() returns boolean {
        return self.caller.isCancelled();
    }
}

public client class LibrarySystemBookCaller {
    private grpc:Caller caller;

    public isolated function init(grpc:Caller caller) {
        self.caller = caller;
    }

    public isolated function getId() returns int {
        return self.caller.getId();
    }

    isolated remote function sendBook(book response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendContextBook(ContextBook response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendError(grpc:Error response) returns grpc:Error? {
        return self.caller->sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.caller->complete();
    }

    public isolated function isCancelled() returns boolean {
        return self.caller.isCancelled();
    }
}

public type ContextBookStream record {|
    stream<book, error?> content;
    map<string|string[]> headers;
|};

public type ContextUserRequestStream record {|
    stream<UserRequest, error?> content;
    map<string|string[]> headers;
|};

public type ContextBook record {|
    book content;
    map<string|string[]> headers;
|};

public type ContextStudentRequest record {|
    StudentRequest content;
    map<string|string[]> headers;
|};

public type ContextLocation record {|
    location content;
    map<string|string[]> headers;
|};

public type ContextUserRequest record {|
    UserRequest content;
    map<string|string[]> headers;
|};

@protobuf:Descriptor {value: LIBRARYSYSTEM_DESC}
public type borrowed_book record {|
    readonly string id = "";
    string student_number = "";
    string ISBN = "";
|};

@protobuf:Descriptor {value: LIBRARYSYSTEM_DESC}
public type student record {|
    readonly string student_number = "";
    string first_name = "";
    string last_name = "";
|};

@protobuf:Descriptor {value: LIBRARYSYSTEM_DESC}
public type author record {|
    string first_name = "";
    string middle_name = "";
    string last_name = "";
|};

@protobuf:Descriptor {value: LIBRARYSYSTEM_DESC}
public type book record {|
    readonly string ISBN = "";
    string name = "";
    author[] authors = [];
    string publisher = "";
    string genre = "";
    int year_published = 0;
    int edition = 0;
    book_status status = AVAILABLE;
    location book_location = {};
|};

@protobuf:Descriptor {value: LIBRARYSYSTEM_DESC}
public type librarian record {|
    readonly string staff_id = "";
    string first_name = "";
    string last_name = "";
|};

@protobuf:Descriptor {value: LIBRARYSYSTEM_DESC}
public type admin record {|
    readonly string staff_id = "";
    string first_name = "";
    string last_name = "";
|};

@protobuf:Descriptor {value: LIBRARYSYSTEM_DESC}
public type StudentRequest record {|
    string student_number = "";
    string ISBN = "";
|};

@protobuf:Descriptor {value: LIBRARYSYSTEM_DESC}
public type location record {|
    string section = "";
    int aisle = 0;
    int floor = 0;
|};

@protobuf:Descriptor {value: LIBRARYSYSTEM_DESC}
public type UserRequest record {|
    student? student = null;
    librarian? librarian = null;
|};

public enum book_status {
    AVAILABLE, UNAVAILABLE
}

