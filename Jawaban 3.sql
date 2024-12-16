--1. Subquery: Tampilkan nama produk dan kategori untuk produk yang memiliki harga lebih tinggi daripada rata-rata harga semua produk.
SELECT 
	NamaProduk, 
	Kategori
FROM 
	training.dbo.Produk
WHERE Harga>(SELECT 
				AVG(Harga) 
			FROM 
				training.dbo.Produk);
--2. Conditional Expression: Tambahkan kolom Ketersediaan (Virtual Column) untuk menampilkan status produk:
--Tersedia jika stok lebih dari 10.
--Habis jika stok 0.
--Terbatas untuk stok antara 1 hingga 10.
SELECT 
	ProdukID, 
	NamaProduk, 
	Kategori, 
	Harga, 
	Stok, 
	TanggalDitambahkan,
	CASE WHEN Stok>10 THEN 'Tersedia' WHEN Stok BETWEEN 1 AND 10 THEN 'Terbatas' WHEN Stok = 0 Then 'Habis' END Ketersediaan
FROM 
	training.dbo.Produk
--3. Subquery dan Join: Tampilkan nama produk, kategori, jumlah terjual untuk semua transaksi.
SELECT 
	pr.NamaProduk,
	pr.Kategori,
	jl.JumlahTerjual
FROM 
	training.dbo.Penjualan jl
RIGHT JOIN 
	training.dbo.Produk pr ON jl.ProdukID = pr.ProdukID
	;
--4. Analisis Conditional Expression: Hitung total pendapatan per kategori. 
SELECT 
	pr.Kategori,
	SUM(jl.JumlahTerjual)total_jual
FROM 
	training.dbo.Penjualan jl
RIGHT JOIN 
	training.dbo.Produk pr ON jl.ProdukID = pr.ProdukID
GROUP BY 
	pr.Kategori 
	
;
--5. CTE: Buat query untuk menghitung total stok per kategori menggunakan CTE.
--6. CTE dan Join: Gunakan CTE untuk menghitung penjualan per produk, lalu gabungkan dengan tabel produk untuk menampilkan nama produk, kategori.




