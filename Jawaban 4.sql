5. CTE: Buat query untuk menghitung total stok per kategori menggunakan CTE.
WITH StockCTE AS(SELECT 
	Kategori, 
	SUM(Stok)TotalStock
FROM 
	training.dbo.Produk
GROUP BY
	Kategori)
SELECT
	*
FROM
	StockCTE;

1.Buatlah sebuah CTE untuk menghitung total penjualan bulanan dari tabel Sales dan mencari bulan dengan total penjualan tertinggi. Tampilkan kolom:
Bulan
Total Penjualan Bulanan
Indikasi apakah bulan tersebut memiliki penjualan tertinggi ("Ya" atau "Tidak").

SELECT 
	SaleID, 
	SaleDate, 
	Amount
FROM 
	training.dbo.Sales;

WITH SalesCTE AS(
	SELECT 
		FORMAT(SaleDate,'yyyy-MM')bulan,
		SUM(Amount)TotalPenjualan
	FROM 
		training.dbo.Sales
	GROUP BY
		FORMAT(SaleDate,'yyyy-MM')
),
MaxSalesCTE AS(
	SELECT 
		MAX(TotalPenjualan)MaxPenjualan
	FROM 
		SalesCTE
)
SELECT
	bulan,
	TotalPenjualan,
	MaxPenjualan,
	CASE WHEN TotalPenjualan = MaxPenjualan THEN 'Ya' ELSE 'Tidak' END IndikasiPenjualan
FROM 
	SalesCTE, MaxSalesCTE
	
2.Buatlah sebuah query untuk menghitung total penjualan per karyawan, termasuk hanya karyawan yang memiliki penjualan lebih besar dari rata-rata semua penjualan.

