--Database Trigger (All Types: Row level and Statement level triggers, Before and After Triggers).
--Write a database trigger on Library table. The System should keep track of the records that are being updated
--or deleted. The old value of updated or deleted records should be added in Library_Audit table.

-- Step 1: Create the Database
CREATE DATABASE Library_M;
USE Library_M;

-- Step 2: Create the Library Table
CREATE TABLE Library_M (
    BookID INT PRIMARY KEY,
    Title VARCHAR(255),
    Author VARCHAR(255),
    PublishedDate DATE
);

-- Step 3: Create the Library_Audit Table (for audit logging)
CREATE TABLE Library_Audit (
    AuditID INT AUTO_INCREMENT PRIMARY KEY,
    BookID INT,
    Title VARCHAR(255),
    Author VARCHAR(255),
    PublishedDate DATE,
    OperationType VARCHAR(10),  -- 'INSERT', 'UPDATE', 'DELETE'
    OperationTime TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Step 4: Create Trigger for AFTER INSERT (to log new records inserted)
DELIMITER //

CREATE TRIGGER AfterLibraryInsert
AFTER INSERT ON Library_M
FOR EACH ROW
BEGIN
    INSERT INTO Library_Audit (BookID, Title, Author, PublishedDate, OperationType)
    VALUES (NEW.BookID, NEW.Title, NEW.Author, NEW.PublishedDate, 'INSERT');
END //

DELIMITER ;

-- Step 5: Create Trigger for AFTER UPDATE (to log old values before update)
DELIMITER //

CREATE TRIGGER AfterLibraryUpdate
AFTER UPDATE ON Library_M
FOR EACH ROW
BEGIN
    INSERT INTO Library_Audit (BookID, Title, Author, PublishedDate, OperationType)
    VALUES (OLD.BookID, OLD.Title, OLD.Author, OLD.PublishedDate, 'UPDATE');
END //

DELIMITER ;

-- Step 6: Create Trigger for AFTER DELETE (to log old values before delete)
DELIMITER //

CREATE TRIGGER AfterLibraryDelete
AFTER DELETE ON Library_M
FOR EACH ROW
BEGIN
    INSERT INTO Library_Audit (BookID, Title, Author, PublishedDate, OperationType)
    VALUES (OLD.BookID, OLD.Title, OLD.Author, OLD.PublishedDate, 'DELETE');
END //

DELIMITER ;

-- Step 7: Insert sample data into Library_M table
INSERT INTO Library_M (BookID, Title, Author, PublishedDate) VALUES
(1, 'Shri Man Yogi', 'Rangeya Raghav', '1958-03-01'),
(2, 'Pulakit', 'P. L. Deshpande', '1970-05-15'),
(3, 'Katha Sangrah', 'Suhas Shirsath', '1985-09-25'),
(4, 'Tisra Tas', 'Sunil Gavai', '2005-06-11'),
(5, 'Mritunjay', 'Shankar N. Navare', '1971-08-30'),
(6, 'Hundred Years', 'P. K. Paranjape', '2000-12-10'),
(7, 'Beauty of Life', 'Sadashiv Godbole', '1992-11-19'),
(8, 'Janmbhumi', 'Shankar N. Navare', '1982-02-05'),
(9, 'Potapani', 'Sanjay Patil', '2010-04-20'),
(10, 'Shivaji', 'M. Gandhi', '1998-07-07');

-- Step 8: Display records from Library_M table
SELECT * FROM Library_M;

-- Step 9: Display records from Library_Audit table (to see the audit log initially)
SELECT * FROM Library_Audit;

-- Step 10: Perform updates and deletes (to trigger the audit)
-- Update a record in Library_M table (this will trigger the AFTER UPDATE trigger)
UPDATE Library_M SET Author = 'Suresh Patil' WHERE BookID = 4;

-- Delete a record from Library_M table (this will trigger the AFTER DELETE trigger)
DELETE FROM Library_M WHERE BookID = 1;

-- Step 11: Display the audit log after updates and deletes
SELECT * FROM Library_Audit;

-- Step 12: Display the remaining records in the Library_M table
SELECT * FROM Library_M;
