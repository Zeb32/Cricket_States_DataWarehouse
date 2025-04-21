-----------------------------------------------------------------------------------
/* This Script Creates Stored Procedure by the Name of bronze.load_branze to First
Truncate (Empty the Table) and Then Bulk upload the Data into Table. Lastly it calls
Or Executes the Stored Procedure we Created */
-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------


CREATE OR ALTER PROCEDURE bronze.load_branze AS -- Create Procedure
BEGIN
	PRINT 'Loading Bronze Layer'; -- Print Messages
	PRINT '--------------------';
	PRINT 'Loading Batting Data';
	PRINT '--------------------';

	TRUNCATE TABLE bronze.batting_ODI; -- Truncate The Table
	BULK INSERT bronze.batting_ODI  -- Insert Data into Table
	FROM 'E:\PROJECTS\MY SQL PROJECT\CRICKET STATES\DATA SETS\Batting\ODI data.csv'
	WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
		);

	TRUNCATE TABLE bronze.batting_T20;
	BULK INSERT bronze.batting_T20 
	FROM 'E:\PROJECTS\MY SQL PROJECT\CRICKET STATES\DATA SETS\Batting\t20.csv'
	WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
		);

	TRUNCATE TABLE bronze.batting_TEST;
	BULK INSERT bronze.batting_TEST 
	FROM 'E:\PROJECTS\MY SQL PROJECT\CRICKET STATES\DATA SETS\Batting\test.csv'
	WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
		);

	PRINT '--------------------';
	PRINT 'Loading Bowling Data';
	PRINT '--------------------';

	TRUNCATE TABLE bronze.bowling_ODI;
	BULK INSERT bronze.bowling_ODI 
	FROM 'E:\PROJECTS\MY SQL PROJECT\CRICKET STATES\DATA SETS\Bowling\Bowling_ODI.csv'
	WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
		);

	TRUNCATE TABLE bronze.bowling_T20;
	BULK INSERT bronze.bowling_T20 
	FROM 'E:\PROJECTS\MY SQL PROJECT\CRICKET STATES\DATA SETS\Bowling\Bowling_t20.csv'
	WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
		);

	TRUNCATE TABLE bronze.bowling_TEST;
	BULK INSERT bronze.bowling_TEST 
	FROM 'E:\PROJECTS\MY SQL PROJECT\CRICKET STATES\DATA SETS\Bowling\Bowling_test.csv'
	WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
		);
END;

-- Call or Execute the Stored Procedure
EXEC bronze.load_branze;
