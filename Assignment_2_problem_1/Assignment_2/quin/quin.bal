import ballerina/http;
import ballerina/crypto;

type User record {
    string username;
    string hashedPassword;
    string[] roles;
};

configurable map<User> users = ?;

service /auth on new http:Listener(8080) {

    resource function post login(http:Caller caller, http:Request req) returns error? {
        json payload;
        // Get the JSON payload and handle the possible error
        var result = req.getJsonPayload();
        if result is json {
            payload = result;
        } else {
            return error("Invalid payload");
        }

        // Extract username and password
        string username = payload.username.toString();
        string password = payload.password.toString();

        // Get the user and check the password
        User|error user = getUserByUsername(username);
        if user is User {
            if checkPassword(user.hashedPassword, password) {
                // Create a session and set a cookie
                string sessionId = createSession(user.username);
                http:Cookie cookie = new;
                cookie.name = "sessionId";
                cookie.value = sessionId;
                _ = caller->addCookies([cookie]);
                return;
            }
            return error("Invalid username or password");
        } else {
            return error("User not found");
        }
    }
}

// Other functions remain the same
