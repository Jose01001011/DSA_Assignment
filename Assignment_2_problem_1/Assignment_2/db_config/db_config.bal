import ballerinax/mongodb;


configurable string host = ?;
configurable int port = ?;
configurable string username = ?;
configurable string password = ?;
configurable string database = ?;
configurable string usersCollection = ?;
configurable string kpisCollection = ?;
configurable string objectivesCollection = ?;

public mongodb:ConnectionConfig mongoConfig = {
    connection: {
        host: host,
        port: port,
        auth: {
            username: username,
            password: password
        }
    },
    databaseName: database
};

public mongodb:Client mongoClient = check new (mongoConfig);
