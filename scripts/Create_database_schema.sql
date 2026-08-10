/*
==============================================================
			Checking Database If Exist or not
==============================================================
Here we create check their is no database already name as Data_Warehouse.
If their are any database, This code will delete the database and create a new.

**** Warning ****
This script drop the database name Data_Warehouse and it's data too. So don't directly run
until you don't want that dasebase.
*/


IF EXISTS (Select 1 FROM sys.databases WHERE name = 'Data_Warehouse')
BEGIN
DROP DATABASE Data_Warehouse
PRINT 'Old Data_Warehouse Deleted Successfully'
End

GO

CREATE DATABASE Data_Warehouse
PRINT 'Data_Warehouse Created Successfully'
Go

/*
==============================================================
			Checking Schema For the Data_Warehouse
==============================================================
*/ 

USE Data_Warehouse
GO


----------------BRONZE LEVEL------------------

CREATE SCHEMA Bronze
Go

----------------SILVER LEVEL------------------

CREATE SCHEMA Silver
Go

---------------- GOLD LEVEL ------------------

CREATE SCHEMA Gold
Go
