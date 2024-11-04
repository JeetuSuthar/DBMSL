Insert the data as shown in the above tables
2. Update the street of branchNo 1001 to MG
3. Delete the owner who has fname as ‘AMIT’
4. List the clients who pay Rent more than 10000
5. List the name of staff who have salary greater than average salary of all staff.
6. Find the type and rooms of properties in pune
7. Find the name of staffs who work as salesman or saleswomen
8. Find the no. of properties which are of type flat.

-- 1. Insert the data as shown in the above tables
INSERT INTO Branch (branchno, street, city, postcode) VALUES 
(1001, 'Hinjewadi', 'Pune', '411041'),
(1002, 'Baner', 'Pune', '411058');

INSERT INTO Staff (staffno, fname, lname, position, sex, DOB, salary, branchno) VALUES 
(101, 'John', 'Doe', 'Manager', 'M', '1985-06-15', 50000, 1001),
(102, 'Jane', 'Smith', 'Saleswoman', 'F', '1990-08-20', 45000, 1002),
(103, 'Amit', 'Kumar', 'Salesman', 'M', '1988-12-10', 47000, 1001);

INSERT INTO PrivateOwner (OUID, fname, lname, address) VALUES 
(301, 'Amit', 'Sharma', '123 Elm St'),
(302, 'Alice', 'Johnson', '456 Maple St');

INSERT INTO Client (CUID, fname, lname, rent) VALUES 
(201, 'Bob', 'Brown', 15000),
(202, 'Charlie', 'Davis', 8000);

INSERT INTO PropertyforRent (propertyNo, street, city, postcode, type, rooms, rent, ownerno, staffno, branchno) VALUES 
(1, 'Broadway', 'Pune', '411041', 'Apartment', 3, 12000, 301, 101, 1001),
(2, 'Green Street', 'Pune', '411058', 'Flat', 2, 8000, 302, 102, 1002);

-- 2. Update the street of branchNo 1001 to MG
UPDATE Branch
SET street = 'MG'
WHERE branchno = 1001;

-- 3. Delete the owner who has fname as ‘AMIT’
DELETE FROM PrivateOwner
WHERE fname = 'Amit';

-- 4. List the clients who pay Rent more than 10000
SELECT *
FROM Client
WHERE rent > 10000;

-- 5. List the name of staff who have salary greater than average salary of all staff.
SELECT fname, lname
FROM Staff
WHERE salary > (SELECT AVG(salary) FROM Staff);

-- 6. Find the type and rooms of properties in Pune
SELECT type, rooms
FROM PropertyforRent
WHERE city = 'Pune';

-- 7. Find the name of staffs who work as salesman or saleswomen
SELECT fname, lname
FROM Staff
WHERE position='Salesman' OR position='Salesman';

-- 8. Find the number of properties which are of type flat.
SELECT COUNT(*) AS flat_count
FROM PropertyforRent
WHERE type = 'Flat';
