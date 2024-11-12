// Insert entries of 10 or more students
db.students.insertMany([
  { first_name: "Jeetu", last_name: "Singh", age: 20, gender: "male", class: "TE", div: "A", grd_point: 45, city: "Warje", state: "MH", course: "BTech" },
  { first_name: "Riyansh", last_name: "Yadav", age: 18, gender: "male", class: "SE", div: "A", grd_point: 40, city: "Pune", state: "MH", course: "BTech" },
  { first_name: "Evanshika", last_name: "Sharma", age: 17, gender: "female", class: "TE", div: "B", grd_point: 36, city: "Nagpur", state: "MH", course: "BTech" },
  { first_name: "Sanjay", last_name: "Kumar", age: 21, gender: "male", class: "SE", div: "A", grd_point: 33, city: "Bangalore", state: "KA", course: "BTech" },
  { first_name: "Bhakti", last_name: "Patil", age: 19, gender: "female", class: "TE", div: "B", grd_point: 29, city: "Mumbai", state: "MH", course: "BTech" },
  { first_name: "Ravi", last_name: "Jadhav", age: 22, gender: "male", class: "TE", div: "A", grd_point: 50, city: "Warje", state: "MH", course: "MCA" },
  { first_name: "Amit", last_name: "Shukla", age: 19, gender: "male", class: "SE", div: "B", grd_point: 32, city: "Pune", state: "MH", course: "BTech" },
  { first_name: "Sonali", last_name: "Jadhav", age: 20, gender: "female", class: "TE", div: "A", grd_point: 45, city: "Nagpur", state: "MH", course: "MCA" },
  { first_name: "Siddhi", last_name: "Patil", age: 18, gender: "female", class: "SE", div: "A", grd_point: 35, city: "Bangalore", state: "KA", course: "BTech" },
  { first_name: "Riya", last_name: "Gupta", age: 22, gender: "female", class: "TE", div: "B", grd_point: 47, city: "Pune", state: "MH", course: "MCA" }
]);

// Query 1: Select all documents from the collection "student" which satisfy the following condition:
// a. Gender of student is male and
// b. Class of the student is TE A or
// c. grd_point of the student is greater than equal to 31
db.students.find({
  $and: [
    { gender: "male" },
    {
      $or: [
        { class: "TE", div: "A" },
        { grd_point: { $gte: 31 } }
      ]
    }
  ]
});

// Query 2: Select documents from the collection "student" who belong to "Bangalore" and whose age is less than or equal to 19
db.students.find({
  city: "Bangalore",
  age: { $lte: 19 }
});

// Query 3: Update course to "MCA" from collection "student" where first name is "Bhakti"
db.students.updateOne(
  { first_name: "Bhakti" },
  { $set: { course: "MCA" } }
);

// Query 4: Update city to Nagpur and state to MH for student with last name "Soniminde"
db.students.updateOne(
  { last_name: "Soniminde" },
  { $set: { city: "Nagpur", state: "MH" } }
);

// Query 5: Delete students who have cancelled admission (state is "KA")
db.students.deleteMany({ state: "KA" });

// Query 6: Delete document where first name is "Evanshika" and age is less than 18
db.students.deleteOne({
  first_name: "Evanshika",
  age: { $lt: 18 }
});

// Query 7: Use NOR operator and other arithmetic operators (example: age not equal to 20 and grd_point >= 30)
db.students.find({
  $nor: [
    { age: 20 }, // age not equal to 20
    { grd_point: { $lt: 30 } } // grd_point less than 30
  ]
});

// Query 8: Use save method to insert or update a student record
db.students.save({
  first_name: "John", last_name: "Doe", age: 25, gender: "male", class: "TE", div: "A", grd_point: 35, city: "Mumbai", state: "MH", course: "MCA"
});

// Query 9: Select documents where gender is female or class is TE B and grd_point >= 31
db.students.find({
  $or: [
    { gender: "female" },
    {
      $and: [
        { class: "TE", div: "B" },
        { grd_point: { $gte: 31 } }
      ]
    }
  ]
});

// Query 10: Update age to 20 for student whose first name is "Riyansh"
db.students.updateOne(
  { first_name: "Riyansh" },
  { $set: { age: 20 } }
);

// Query 11: Delete document from collection student where first name is "Evanshika" and age is less than 18
db.students.deleteOne({
  first_name: "Evanshika",
  age: { $lt: 18 }
});

// Query 12: Delete document from collection student where last name is "Jadhav" and belongs to class TE B
db.students.deleteOne({
  last_name: "Jadhav",
  class: "TE",
  div: "B"
});

// Query 13: Find students with nor and other arithmetic operators
db.students.find({
  $nor: [
    { age: 20 },
    { grd_point: { $lt: 30 } }
  ]
});
