/*
==============================================================
			Checking If Database Exists
==============================================================
Here we check whether a database named Data_Warehouse already exists.
If the database exists, this script will delete it and create a new one.

**** Warning ****
This script drops the database named Data_Warehouse and all of its data.
Do not run this script unless you intend to recreate the database.
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

CREATE SCHEMA Gold
Go
