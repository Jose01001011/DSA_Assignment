Certainly! Let's create some sample data for the `Users`, `DepartmentObjectives`, and `KPIs` collections, formatted as CSV files.

### 1. Users CSV

```csv
ID,FirstName,LastName,JobTitle,Position,Role,DepartmentID
1,Jane,Doe,Lecturer,Senior,Employee,1
2,John,Smith,Professor,Head,HoD,1
3,Emily,White,Assistant Professor,Junior,Supervisor,1
```

### 2. DepartmentObjectives CSV

```csv
ID,ObjectiveName,Description,ContributionPercentage,DepartmentID
1,Increase Research Output,Enhance the research output by 20% compared to the previous year.,30,1
2,Improve Student Satisfaction,Increase student satisfaction by 15% in the annual survey.,20,1
```

### 3. KPIs CSV

```csv
ID,EmployeeID,ObjectiveID,KPIName,Description,Unit,Score,SupervisorID
1,1,1,Research Output,Increase individual research output by 15%,Percentage,4.5,3
2,1,2,Student Feedback,Improve student feedback score by 10%,Percentage,4,3
```

### Notes:
- **ID**: The ID fields are unique identifiers. When importing into MongoDB, these would typically be replaced by the `ObjectId` type.
- **DepartmentID** in `Users` and `KPIs` and **ObjectiveID** in `KPIs` act as foreign keys and reference `ID` in `DepartmentObjectives`.
- **EmployeeID** and **SupervisorID** in `KPIs` reference `ID` in `Users`.

### To Save as CSV Files:
- Copy each section of CSV data and paste it into a text editor.
- Save each section with a `.csv` file extension (e.g., `users.csv`, `department_objectives.csv`, `kpis.csv`).

Once you've created these CSV files, you can import them into MongoDB using `mongoimport` with the `--type csv` option, or utilize them in another database or application that supports CSV import.

If you have any specific data or additional fields you'd like to include in the CSV files, or if you have further questions, feel free to let me know!