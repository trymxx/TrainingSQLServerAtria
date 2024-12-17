1.Dirty Read Buat transaksi yang menunjukkan data dibaca sebelum di-commit oleh transaksi lain. ga dicommit taapi rollback. update di table orders

SELECT OrderID, CustomerID, OrderDate, Amount, Status
FROM TrainingConcurrency.dbo.Orders;
--Update Tanpa COmmit
BEGIN TRANSACTION;
UPDATE 
	Orders 
SET 
	Status = 'Processing'
WHERE 
	OrderId = 13;
--Membaca Tanpa Commit
SET TRANSACTION ISOLATION LEVEL 
READ UNCOMMITTED;
BEGIN TRANSACTION;
SELECT 
	*
FROM 	
	Orders 
WITH 
	(NOLOCK)
WHERE 
	OrderId= 13
--Rollback Perubahan
ROLLBACK;


2. Non-repeatable Read Tunjukkan perbedaan hasil baca karena transaksi lain melakukan perubahan.
--Membaca Data
SET TRANSACTION ISOLATION LEVEL 
READ COMMITTED;
BEGIN TRANSACTION;

SELECT 
	*
FROM 	
	Orders 
WHERE 
	OrderId= 2

BEGIN TRANSACTION;
UPDATE 
	Orders 
SET 
	Status = 'PRO'
WHERE 
	OrderId = 2;
COMMIT;
3. Phantom Read Demonstrasikan transaksi yang membaca hasil berbeda karena ada penyisipan data oleh transaksi lain.


4. Serializable Tunjukkan isolasi penuh sehingga transaksi lain tidak dapat menyisipkan data pada rentang yang sedang diakses.

5. Snapshot Tunjukkan bagaimana snapshot isolation memberikan konsistensi tanpa mengunci data.
