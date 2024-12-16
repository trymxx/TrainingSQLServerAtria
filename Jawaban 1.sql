SELECT LEN('BElajar')

--1. Agregasi dengan Fungsi String
--Soal:
--Gabungkan semua nama karyawan dalam satu departemen.

SELECT 
    UPPER(SUBSTRING(NamaKaryawan, 3, 3)) + '-ACTIVE' AS Hasil
FROM Karyawan
WHERE LEN(NamaKaryawan) > 5;


--2. Konversi Format Tanggal
--Soal:
--Tampilkan TanggalTransaksi dalam format DD-MMM-YYYY HH:MM:SS AM/PM dan hitung jumlah hari hingga tanggal saat ini.
SELECT 
	TransaksiID 
	,FORMAT(TanggalTransaksi, 'dd-MMM-yyyy hh:MM:ss tt') AS TanggalTransaksi 
	,DATEDIFF(DAY,TanggalTransaksi , GETDATE()) SelisihHari
FROM training.dbo.Transaksi;


--3. Kalkulasi dengan Fungsi Waktu
--Soal:
--Hitung total jam kerja setiap karyawan dalam format XX jam YY menit.
SELECT 
	NamaKaryawan
	,JamMasuk
	,JamKeluar
	,DATEDIFF(MINUTE, JamMasuk, JamKeluar) TotalJamKerjaMenit
	,CONVERT(varchar(5), DATEADD(minute, DATEDIFF(MINUTE, JamMasuk, JamKeluar), 0), 114) TotalJamKerjaJam
FROM 
	Presensi
