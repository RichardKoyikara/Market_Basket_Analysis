
----------------------- To Return All the Data From the [dbo].[Transcations_Records] Table-------------------------------------------
Select 
	* 
From
	[dbo].[Transcations_Records]

-- The Number Of Initial Rows in the Table(541909 Rows)--
Select 
	COUNT(*) AS Total_Number_Of_Rows
From
	[dbo].[Transcations_Records]

------------------------------------------- The Data Cleaning & Pre-Processing Process-------------------------------------------------

-------------------------- Removing the NULL Values from the [dbo].[Transcations_Records] table ----------------------------
-- COUNT of Rows having Null Values--
Select 
	COUNT(*) AS Count_Of_Rows_having_NullValues 
From 
	[dbo].[Transcations_Records] 
Where 
	([InvoiceNo] is Null) OR 
	([StockCode] is Null) OR 
	([Description] is Null) OR 
	([Quantity] is Null) OR 
	([InvoiceDate] is Null) OR
	([UnitPrice] is Null) OR
	([CustomerID] is Null) OR
	([Country] is Null);

-- There are 135080 Rows Which Contains the Null Values--
--Removing the Rows having Null values--
Delete From [dbo].[Transcations_Records]
Where
	([InvoiceNo] is Null) OR 
	([StockCode] is Null) OR 
	([Description] is Null) OR 
	([Quantity] is Null) OR 
	([InvoiceDate] is Null) OR
	([UnitPrice] is Null) OR
	([CustomerID] is Null) OR
	([Country] is Null);

Select 
	Count(*) AS Total_Number_Of_Rows
From 
	[dbo].[Transcations_Records];

-- After Removing the Null values there are 406829 Rows--------


----------------------- Removing Leading Spaces From the [Description] Column in the [dbo].[Transcations_Records] Table---------------------
UPDATE 
	[dbo].[Transcations_Records]
SET 
	[Description] = LTRIM([Description]);

---------------------- Removing Trailing Spaces From the [Description] Column in the [dbo].[Transcations_Records] Table------------------
UPDATE 
	[dbo].[Transcations_Records]
SET 
	[Description] = RTRIM([Description]);

---------------------Changing The datatype of [InvoiceNo] Column to String---------------------------------------------
ALTER TABLE 
	[dbo].[Transcations_Records]
ALTER COLUMN 
	[InvoiceNo] Varchar(25);

---------------------Removing the Rows that contains POSTAGE in the [Description] Column---------------------------------------------
DELETE FROM 
	[dbo].[Transcations_Records]
WHERE 
	[Description] = 'POSTAGE';
---- After Removing rows according to the Above condition there are 405633 Rows---------

-------------Separating And Creating New the [Invoice_Date] and [Invoice_Time] Columns in the [Transcations_Records] Table---------------

ALTER TABLE 
	[dbo].[Transcations_Records]
ADD 
	[Invoice_Date] AS CONVERT(DATE, [InvoiceDate]) PERSISTED,
    [Invoice_Time] AS CONVERT(TIME, [InvoiceDate]) PERSISTED;

--------------Deleting the Records that has neqative values in the [Quantity] Column----------------------------------

DELETE FROM 
	[dbo].[Transcations_Records]
WHERE 
	[Quantity] like '-%';

