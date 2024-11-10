

-- Step 1: Create the Borrower and Fine tables with a single primary key
CREATE TABLE  Borrower (
    Roll_no INT PRIMARY KEY,  -- Use Roll_no as the single primary key
    Name VARCHAR(50),
    DateofIssue DATE,
    NameofBook VARCHAR(100),
    Status CHAR(1) DEFAULT 'I'  -- 'I' for Issued, 'R' for Returned
);

CREATE TABLE Fine (
    Fine_ID INT PRIMARY KEY AUTO_INCREMENT,  -- Use a single primary key for Fine table
    Roll_no INT,
    Date DATE,
    Amt DECIMAL(10, 2)
);

-- Step 2: Define the ReturnBook procedure
CREATE PROCEDURE ReturnBook(IN p_roll_no INT, IN p_book_name VARCHAR(50))
BEGIN
    DECLARE v_date_of_issue DATE;
    DECLARE v_days_diff INT;
    DECLARE v_fine_amt DECIMAL(10, 2) DEFAULT 0;
    DECLARE v_status CHAR(1);

    -- Step 3: Retrieve the date of issue and current status of the book
    SELECT DateofIssue, Status INTO v_date_of_issue, v_status
    FROM Borrower
    WHERE Roll_no = p_roll_no AND NameofBook = p_book_name;

    -- Step 4: Check if the book is currently issued
    IF v_status = 'I' THEN
        -- Calculate the number of days since the book was issued
        SET v_days_diff = DATEDIFF(CURDATE(), v_date_of_issue);

        -- Calculate fine based on the number of days
        IF v_days_diff BETWEEN 15 AND 30 THEN
            SET v_fine_amt = v_days_diff * 5;
        ELSEIF v_days_diff > 30 THEN
            SET v_fine_amt = (30 * 5) + ((v_days_diff - 30) * 50);
        END IF;

        -- Update the status of the book to 'R' (Returned)
        UPDATE Borrower
        SET Status = 'R'
        WHERE Roll_no = p_roll_no AND NameofBook = p_book_name;

        -- If there is a fine, insert it into the Fine table
        IF v_fine_amt > 0 THEN
            INSERT INTO Fine (Roll_no, Date, Amt)
            VALUES (p_roll_no, CURDATE(), v_fine_amt);
        END IF;

    ELSE
        -- If the book is not currently issued, show a simple message and exit procedure
        SELECT 'Error: Book not currently issued or already returned' AS ErrorMessage;
        LEAVE;  -- Exit the procedure if the book status is not 'I'
    END IF;
END //

-- Reset the delimiter back to default
DELIMITER ;

-- Step 3: Insert sample data into the Borrower table with specific dates
INSERT INTO Borrower (Roll_no, Name, DateofIssue, NameofBook, Status)
VALUES 
(1, 'Alice', '2024-10-20', 'Data Science 101', 'I'),
(2, 'Bob', '2024-10-05', 'Introduction to SQL', 'I');

-- Step 4: Call the procedure to process the book return for each student
CALL ReturnBook(1, 'Data Science 101');
CALL ReturnBook(2, 'Introduction to SQL');

-- Step 5: Display the contents of the Fine table to check the results
SELECT * FROM Fine;
