
Step 1: Database Setup:
Choose between MySQL or MongoDB and design a schema to store user information and performance records.

Database Setup
•	Design a schema that includes tables/collections for:
•	Users (with fields like ID, first name, last name, job title, position, role, etc.)
•	Department Objectives (with fields to store objective details and their contributions to overall goals)
•	KPIs (with fields to store KPI details, units, scores, related department objective, etc.)
Make sure MongoDB and MongoDB shell are installed
Open CMD, Then type 
“mongosh”


Then type this to create the database and collections:
use YourDatabaseName  // Switch to your database

db.createCollection("Users")
db.createCollection("DepartmentObjectives")
db.createCollection("KPIs")

Create CSV files for all 3 collections as like “rows and collumns” for each collection
SEE “Inserting_data_into_database” in the schemaGeneration file.

Step 1 complete



Step 2:
GraphQL API Development:
Define the GraphQL schema. This should encompass types, queries, and mutations required for the functionalities outlined in the problem.

Given our current progress, the next step would be to Define the GraphQL schema. This involves:
Defining types for Users, KPIs, and DepartmentObjectives.
Creating queries for fetching data, such as fetching a user's KPIs, fetching department objectives, etc.
Defining mutations for operations like creating KPIs, updating scores, adding new objectives, etc.

NOTE: See file “prob1schema.graphql”

a more detailed and refined explanation of Types, Queries, and Mutations in the GraphQL schema:

In-depth Explanation:
Types in GraphQL:

Definition:
In GraphQL, types represent the blueprint or shape of the data that can be fetched from or sent to the server. They are the fundamental building blocks of the GraphQL schema, specifying what kind of objects can be retrieved and what fields they have.
In Our Schema:
We have defined three primary types: User, DepartmentObjective, and KPI.

User Type: Represents an individual within the system, storing details like name, job title, position, role, and associated department. This reflects the personnel and their roles in the performance management system.

DepartmentObjective Type: Represents goals set by different departments. Each objective has a name, description, a contribution percentage indicating its weightage, and an associated department ID. This structure enables tracking of larger goals that employees contribute to through their KPIs.

KPI Type: Represents the Key Performance Indicators tied to each employee. These are performance metrics that supervisors evaluate. The KPI has a name, description, unit of measurement, a score, and links to both an employee and an objective.

Queries in GraphQL:

Definition:
Queries in GraphQL allow for fetching or retrieving data. They define the set of operations that can pull data from the server. It's analogous to the "READ" operation in CRUD.
In Our Schema:
We've defined various query types like getUser, getAllUsers, getDepartmentObjective, etc.

getUser and getAllUsers: These queries allow fetching individual or all users, respectively.

getDepartmentObjective and getAllDepartmentObjectives: Enable retrieval of individual or all departmental objectives.

getKPI and getAllKPIs: Facilitate fetching of individual or all Key Performance Indicators.

Mutations in GraphQL:

Definition:
Mutations in GraphQL allow for modifying data in the system. They enable operations like creating, updating, and deleting data entries. Mutations are analogous to the "CREATE", "UPDATE", and "DELETE" operations in CRUD.
In Our Schema:
We've defined various mutations to handle CRUD operations for each type.

For User: createUser, updateUser, and deleteUser allow for adding, modifying, and removing users, respectively.

For DepartmentObjective: createDepartmentObjective, updateDepartmentObjective, and deleteDepartmentObjective handle the creation, updating, and deletion of department objectives.

For KPI: createKPI, updateKPI, and deleteKPI cater to the addition, modification, and removal of KPIs.

These explanations offer an in-depth understanding of the structure and purpose of the components in the GraphQL schema. The schema acts as a contract between the client and the server, ensuring both parties have a shared understanding of the available data and operations.

Step 2 complete





STEP 3: Ballerina Service Implementation:
Implement the GraphQL service in Ballerina. This service should handle the API requests, interact with the database, and return appropriate responses.
.

├── prob1schema.graphql
├── SchemaGeneration
│   ├── DepartmentObjectives.csv
│   ├── KPIs.csv
│   └── Users.csv
├── ass2_Step_by_step_walkthrough.md
└── BallerinaService
    └── PerformanceManagementService.bal



Command into terminal: “bal new BalGraphQLService -t service”

######################################################################################

