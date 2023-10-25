Sure, let's create some default data to insert into each of the collections (`Users`, `DepartmentObjectives`, and `KPIs`) using MongoDB commands.

### 1. Inserting data into `Users` Collection

```javascript
db.Users.insert({
    "firstName": "Jane",
    "lastName": "Doe",
    "jobTitle": "Lecturer",
    "position": "Senior",
    "role": "Employee"
});
```

### 2. Inserting data into `DepartmentObjectives` Collection

```javascript
db.DepartmentObjectives.insert({
    "objectiveName": "Increase Research Output",
    "description": "Aim to enhance the research output by 20% compared to the previous year.",
    "contributionPercentage": 30
});
```

### 3. Inserting data into `KPIs` Collection

```javascript
db.KPIs.insert({
    "employeeId": ObjectId("INSERT_EMPLOYEE_OBJECT_ID_HERE"),
    "objectiveId": ObjectId("INSERT_OBJECTIVE_OBJECT_ID_HERE"),
    "kpiName": "Research Output",
    "description": "Increase individual research output by 15%.",
    "unit": "percentage",
    "score": 4.5,
    "supervisorId": ObjectId("INSERT_SUPERVISOR_OBJECT_ID_HERE")
});
```

### Notes:

- Ensure that MongoDB is running and that you’re using the correct database. You can select a database using `use DATABASE_NAME`.
  
- In the `KPIs` collection insert command, you will need to replace the placeholder ObjectIDs (`INSERT_EMPLOYEE_OBJECT_ID_HERE`, `INSERT_OBJECTIVE_OBJECT_ID_HERE`, `INSERT_SUPERVISOR_OBJECT_ID_HERE`) with actual ObjectIDs from your `Users` and `DepartmentObjectives` collections.

  To find these ObjectIDs, you might use a command like:
  ```javascript
  db.Users.findOne({"firstName": "Jane"})
  ```
  and similarly for other collections to get the `_id` field.

### Additional Insertion:

If you want to insert more than one document at a time, you can use `insertMany` and provide an array of documents to insert. For example:

```javascript
db.Users.insertMany([
    {"firstName": "John", "lastName": "Smith", "jobTitle": "Professor", "position": "Head", "role": "HoD"},
    {"firstName": "Emily", "lastName": "White", "jobTitle": "Assistant", "position": "Junior", "role": "Employee"}
]);
```

Ensure to adjust the default data as per your use case and requirements. If you have further queries or need assistance with another step, feel free to ask!