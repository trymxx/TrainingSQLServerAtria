1. Membuat Pengguna dan Memberikan Izin Dasar
Tugas:

Buat tiga pengguna: User_A, User_B, dan Manager.
Berikan User_A izin SELECT pada tabel Penjualan.
Tambahkan User_B ke peran khusus TimPenjualan dengan izin SELECT pada tabel Penjualan.
Berikan Manager izin SELECT dan UPDATE pada tabel Penjualan.
CREATE LOGIN User_A WITH PASSWORD 'Password123!';
CREATE LOGIN User_B WITH PASSWORD 'Password1234!';
CREATE LOGIN Manager WITH PASSWORD 'Password12345!';

CREATE USER User_A FOR LOGIN User_A;
GRANT SELECT ON Penjualan to User_A
EXEC sp_addrolemember 'SalesTeam', 'User_B';
GRANT SELECT ON Penjualan to User_B

GRANT SELECT,UPDATE ON Penjualan to Manager


2. Menerapkan DENY (Tolak) Izin
Tugas:

Tolak izin DELETE pada tabel Penjualan untuk User_A.



3. Mencabut Izin dengan REVOKE
Tugas:

Cabut izin SELECT dari User_A pada tabel Penjualan.



4. Menggunakan Peran Tetap di Database
Tugas:

Berikan User_B peran db_datareader untuk database ini.




5. Membuat dan Mengelola Peran Khusus
Tugas:

Buat peran khusus AksesBacaSaja dan berikan izin SELECT pada semua tabel dalam database.
GRANT SELECT ON SCHEMA::dbo to AksesBacaSaja
EXEC sp_addrolemember 'AksesBacaSaja', 'User_A'


6. Audit Izin Pengguna
Tugas:

Tampilkan laporan semua pengguna dan perannya di database ini.
SELECT 
	a.name as NamaPengguna
	,b.name as NamaPeran
FROM
	sys.database_principals a
JOIN
	sys.database_role_members c ON a.principal_id = c.principal_id
JOIN 	
	sys.database_principals b ON b.principal_id = c.role_principal_id



7. Konfigurasi Akses Minimum (Least Privilege)
Skenario:
Administrator database ingin memastikan bahwa User_B hanya dapat membaca dan memperbarui data pada tabel Penjualan jika Total penjualannya kurang dari 500.

Solusi:

Buat peran baru dan beri izin SELECT dan UPDATE dengan filter tingkat baris.
