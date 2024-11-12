// Create the collection and insert documents
/*
4------>
MongoDB - Aggregation and Indexing: Design and Develop MongoDB Queries using aggregation and
indexing with suitable example using MongoDB.
Create collection student{ Rollno ,Name, Class, Div, Subject, Marks, Address} and enter 6 entries or
more. And perform the following:
1. Find the maximum marks of student in DS who stay in the same city
2. Calculates the average of given marks.
3. Inserts the any value to an array in the resulting document.
4. Create a simple and compound index on name and class.
5. Delete index of name.
6. Implement aggregation pipeline using pipeline operations(example : $sort, $ match ,$group etc in
single statement)

3--------->
1. Find average of total marks in TOC.
2. Find the number of students division wise.
3. Find students of div B who scored min marks in DBMS.
4. Find total sum of marks in SPOS of students staying pune
5. Find the division wise count of students whose DBMS marks.
6. Find the count of each city.
7. Create the simple and compound Indexing on column.
*/
db.students.insertMany([
    { rollno: 1, name: "Jeetu", class: "TE", div: "B", subject: "DS", marks: 80, address: { city: "Warje" }},
    { rollno: 2, name: "Sachin", class: "SE", div: "A", subject: "DBMS", marks: 65, address: { city: "Jejuri" }},
    { rollno: 3, name: "Amit", class: "TE", div: "A", subject: "DS", marks: 90, address: { city: "Warje" }},
    { rollno: 4, name: "Priya", class: "SE", div: "B", subject: "DS", marks: 70, address: { city: "Warje" }},
    { rollno: 5, name: "Ravi", class: "TE", div: "B", subject: "DBMS", marks: 75, address: { city: "Jejuri" }},
    { rollno: 6, name: "Sunil", class: "SE", div: "A", subject: "TOC", marks: 85, address: { city: "Pune" }},
    { rollno: 7, name: "Nina", class: "TE", div: "B", subject: "TOC", marks: 95, address: { city: "Pune" }},
    { rollno: 8, name: "Manish", class: "SE", div: "A", subject: "SPOS", marks: 88, address: { city: "Pune" }},
    { rollno: 9, name: "Karan", class: "TE", div: "B", subject: "SPOS", marks: 92, address: { city: "Pune" }},
    { rollno: 10, name: "Neha", class: "TE", div: "B", subject: "SPOS", marks: 70, address: { city: "Mumbai" }}
]);

// 1. Find the maximum marks of student in DS who stay in the same city
db.students.aggregate([
    { $match: { subject: "DS" } },
    { $group: { _id: "$address.city", maxMarks: { $max: "$marks" } } }
]);

// 2. Calculate the average of given marks
db.students.aggregate([
    { $group: { _id: null, avgMarks: { $avg: "$marks" } } }
]);

// 3. Insert a value to an array in the resulting document
db.students.updateMany(
    { subject: "DS" },
    { $push: { remarks: "Good performance" } }
);

// 4. Create a simple and compound index on name and class
db.students.createIndex({ name: 1 });
db.students.createIndex({ class: 1, div: 1 });

// 5. Delete index on name
db.students.dropIndex({ name: 1 });

// 6. Implement aggregation pipeline using pipeline operations (e.g., $sort, $match, $group)
db.students.aggregate([
    { $match: { subject: "TOC" } },
    { $group: { _id: "$div", totalMarks: { $sum: "$marks" } } },
    { $sort: { totalMarks: -1 } }
]);

// Additional Queries as per your request:

// 1. Find average of total marks in TOC
db.students.aggregate([
    { $match: { subject: "TOC" } },
    { $group: { _id: null, avgMarks: { $avg: "$marks" } } }
]);

// 2. Find the number of students division wise
db.students.aggregate([
    { $group: { _id: "$div", studentCount: { $sum: 1 } } }
]);

// 3. Find students of div B who scored min marks in DBMS
db.students.aggregate([
    { $match: { subject: "DBMS", div: "B" } },
    { $group: { _id: "$div", minMarks: { $min: "$marks" } } }
]);

// 4. Find total sum of marks in SPOS of students staying in Pune
db.students.aggregate([
    { $match: { subject: "SPOS", "address.city": "Pune" } },
    { $group: { _id: "$subject", totalMarks: { $sum: "$marks" } } }
]);

// 5. Find division-wise count of students whose DBMS marks are above 70
db.students.aggregate([
    { $match: { subject: "DBMS", marks: { $gt: 70 } } },
    { $group: { _id: "$div", count: { $sum: 1 } } }
]);

// 6. Find the count of each city
db.students.aggregate([
    { $group: { _id: "$address.city", cityCount: { $sum: 1 } } }
]);

// 7. Create the simple and compound indexing on columns
db.students.createIndex({ "name": 1 });
db.students.createIndex({ "class": 1, "div": 1 });
