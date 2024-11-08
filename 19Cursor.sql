--Cursors: (All types: Implicit, Explicit, Cursor FOR Loop, Parameterized Cursor) Write a
--PL/SQL block of code
--using parameterized Cursor that will merge the data availablein the newly created table
--N_RollCall with the data
--available in the table O_RollCall. If the data in the first table already exist in the second
--table then that data
--should be skipped

-- Step 1: Create the Database (if not already created)
CREATE DATABASE  PLSQL;
USE PLSQL;

-- Step 2: Create the tables for storing roll call data
CREATE TABLE  N_RollCall (
    roll INT PRIMARY KEY, 
    name VARCHAR(20), 
    division VARCHAR(20)
);

CREATE TABLE  O_RollCall (
    roll INT PRIMARY KEY, 
    name VARCHAR(20), 
    division VARCHAR(20)
);

-- Step 3: Insert data into N_RollCall table (New Roll Call)
INSERT INTO N_RollCall (roll, name, division) 
VALUES
    (1, 'Piyush', 'B'),
    (2, 'Ritesh', 'B'),
    (3, 'Sanket', 'A'),
    (4, 'Aniket', 'B'),
    (5, 'Hemant', 'B');

-- Step 4: Insert data into O_RollCall table (Old Roll Call)
INSERT INTO O_RollCall (roll, name, division) 
VALUES
    (1, 'Piyush', 'B'),
    (3, 'Sanket', 'A');

-- Step 5: Declare the Procedure to Merge Data Using a Cursor

DELIMITER //

CREATE PROCEDURE roll()
BEGIN
    -- Declare local variables to store the fetched data.
    DECLARE v_name VARCHAR(20);      -- Variable to store 'name'
    DECLARE v_division VARCHAR(20);  -- Variable to store 'division'
    DECLARE v_roll INT;              -- Variable to store 'roll'
    DECLARE done BOOLEAN DEFAULT FALSE;  -- Boolean flag to mark the end of cursor data

    -- Declare the cursor to fetch data from the 'N_RollCall' table.
    DECLARE cur_new_rollcall CURSOR FOR 
        SELECT name, roll, division FROM N_RollCall;

    -- Declare a handler that sets the 'done' flag to TRUE when no more rows are found.
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    -- Open the cursor to start fetching the data.
    OPEN cur_new_rollcall;

    -- Start looping to fetch rows from the cursor.
    read_loop: LOOP
        -- Fetch a row from the cursor into the declared variables.
        FETCH cur_new_rollcall INTO v_roll, v_name, v_division;

        -- If no more rows are found, exit the loop.
        IF done THEN
            LEAVE read_loop;
        END IF;

        -- Insert the fetched data into the 'O_RollCall' table, 
        -- or update the existing record if the 'roll' already exists.
        INSERT INTO O_RollCall(roll, name, division) 
        VALUES(v_roll, v_name, v_division)
        ON DUPLICATE KEY UPDATE
            name = VALUES(name),         -- Update 'name' if the 'roll' already exists.
            division = VALUES(division); -- Update 'division' if the 'roll' already exists.

    END LOOP;

    -- Close the cursor after finishing the loop.
    CLOSE cur_new_rollcall;

    -- Commit the transaction to apply the changes.
    COMMIT;
END //

DELIMITER ;

-- Step 6: Call the procedure to execute the merge operation
CALL roll();

-- Step 7: Display the merged data from O_RollCall table
SELECT * FROM O_RollCall;
