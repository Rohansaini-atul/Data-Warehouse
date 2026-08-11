/*
===================================================================================================
					STORED PROCEDURE

What it does : Uses 'BULK INSERT' to load data from a '.csv' source file 
               into the Bronze layer. It also truncates any prior data before 
               inserting new records.

===================================================================================================

Parameters   : This stored procedure does not take any parameters.

Example      : EXEC bronze.load_bronze
===================================================================================================
*/

CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
DECLARE @start_time DATETIME , @end_time DATETIME, @end_batch_time DATETIME,@start_batch_time DATETIME
	BEGIN TRY
		PRINT '=====================================';
		PRINT 'Loading Data .....';
		PRINT '=====================================';
	
		PRINT '-------------------------------------';
		PRINT 'Loading Crm Data ...'
		PRINT '-------------------------------------';

		PRINT '>> Truncating : Bronze.crm_cust_info';
		SET @start_batch_time = GETDATE();

		TRUNCATE TABLE bronze.crm_cust_info;

		PRINT '>> Inserting Data : Bronze.crm_cust_info';
		SET @start_time = GETDATE();

		BULK INSERT bronze.crm_cust_info  -- WORK LIKE pd.read_csv
		FROM 'C:\Users\computer\Desktop\New folder\SQL\sql-data-warehouse-project-main\datasets\source_crm\cust_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Insertion Time :' + CAST(DATEDIFF(SECOND,@start_time,@end_time)AS NVARCHAR) + 'seconds';

		PRINT '>> Truncating : Bronze.crm_prd_info';

		TRUNCATE TABLE bronze.crm_prd_info;


		PRINT '>> Inserting Data : Bronze.crm_prd_info';
		SET @start_time = GETDATE();

		BULK INSERT bronze.crm_prd_info
		FROM 'C:\Users\computer\Desktop\New folder\SQL\sql-data-warehouse-project-main\datasets\source_crm\prd_info.csv'
		WITH 
		(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK  -- Lock the table while loading. Good to increasing loading performance
		);
		SET @end_time = GETDATE();
		PRINT '>> Insertion Time :' + CAST(DATEDIFF(SECOND,@start_time,@end_time)AS NVARCHAR) + 'seconds';



		PRINT '>> Truncating : Bronze.crm_sales_details';

		TRUNCATE TABLE bronze.crm_sales_details;

		PRINT '>> Inserting Data : Bronze.crm_sales_details';
		SET @start_time = GETDATE();

		BULK INSERT bronze.crm_sales_details
		FROM 'C:\Users\computer\Desktop\New folder\SQL\sql-data-warehouse-project-main\datasets\source_crm\sales_details.csv'
		WITH 
		(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);

		SET @end_time = GETDATE();
		PRINT '>> Insertion Time :' + CAST(DATEDIFF(SECOND,@start_time,@end_time)AS NVARCHAR) + 'seconds';

		PRINT '-------------------------------------';
		PRINT 'Loading Erp Data ...'
		PRINT '-------------------------------------';

		PRINT '>> Truncating : Bronze.erp_cust_az12';

		TRUNCATE TABLE bronze.erp_cust_az12;


		PRINT '>> Inserting Data : Bronze.erp_cust_az12';
		SET @start_time = GETDATE();

		BULK INSERT bronze.erp_cust_az12
		FROM 'C:\Users\computer\Desktop\New folder\SQL\sql-data-warehouse-project-main\datasets\source_erp\cust_az12.csv'
		WITH
		(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Insertion Time :' + CAST(DATEDIFF(SECOND,@start_time,@end_time)AS NVARCHAR) + 'seconds';

		PRINT '>> Truncating : Bronze.erp_loc_a101';

		TRUNCATE TABLE bronze.erp_loc_a101;

		PRINT '>> Inserting Data : Bronze.erp_loc_a101';
		SET @start_time = GETDATE();

		BULK INSERT bronze.erp_loc_a101
		FROM 'C:\Users\computer\Desktop\New folder\SQL\sql-data-warehouse-project-main\datasets\source_erp\loc_a101.csv'
		WITH
		(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Insertion Time :' + CAST(DATEDIFF(SECOND,@start_time,@end_time)AS NVARCHAR) + 'seconds';

		PRINT '>> Truncating : Bronze.erp_px_cat_g1v2';

		TRUNCATE TABLE bronze.erp_px_cat_g1v2;

		PRINT '>> Inserting Data : Bronze.erp_px_cat_g1v2';
		SET @start_time = GETDATE();

		BULK INSERT bronze.erp_px_cat_g1v2
		FROM 'C:\Users\computer\Desktop\New folder\SQL\sql-data-warehouse-project-main\datasets\source_erp\px_cat_g1v2.csv'
		WITH
		(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		SET @end_batch_time = GETDATE();
		PRINT '>>>>>>>>>>>>>';
		PRINT 'Loading time for bronze layer...' + CAST(DATEDIFF(SECOND,@start_batch_time,@end_batch_time) AS NVARCHAR) + 'seconds';
		PRINT '>>>>>>>>>>>>>';

		PRINT '>> Insertion Time :' + CAST(DATEDIFF(SECOND,@start_time,@end_time)AS NVARCHAR) + 'seconds';
	END TRY
	BEGIN CATCH
		PRINT 'ERROR MESSAGE IS' + ERROR_MESSAGE();
		PRINT 'ERROR NO. IS' + CAST(ERROR_NUMBER() AS NVARCHAR);
		PRINT 'ERROR STATE IS' + CAST(ERROR_STATE() AS NVARCHAR);
	END CATCH

END
