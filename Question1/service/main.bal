import ballerina/http;

service /stafff on new http:Listener(9090) {
    resource function get .() returns error? {
    }
}
