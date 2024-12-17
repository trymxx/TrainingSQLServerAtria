Soal 
1.Pencarian Kamar yang Tersedia Tampilkan semua kamar yang saat ini tersedia untuk dipesan.
SELECT RoomID, RoomNumber, RoomType, PricePerNight, Status
FROM training.dbo.Rooms WHERE Status = 'Available'

2.Laporan Pemesanan Per Pelanggan Tampilkan laporan daftar pemesanan untuk setiap pelanggan, termasuk nama pelanggan, jenis kamar, tanggal check-in, dan tanggal check-out.
SELECT 
	cs.FullName,
	rm.RoomType,
	bo.CheckInDate, 
	bo.CheckOutDate
FROM 
	training.dbo.Bookings bo
LEFT JOIN
	training.dbo.Customers cs ON bo.CustomerID = cs.CustomerID
LEFT JOIN 	
	training.dbo.Rooms rm ON bo.RoomID = rm.RoomID


3.Validasi Ketersediaan Kamar Sebelum Pemesanan Tulis query untuk memeriksa apakah kamar tertentu tersedia pada rentang tanggal tertentu. room check in check out...select case when if exist kalau ada booking kalau engga available

BEGIN TRANSACTION 
	DECLARE @RoomID INT = 2;
	DECLARE @CheckIN DATE = '2024-12-20';
	DECLARE @CheckOUT DATE= '2024-12-25';
	SELECT 
		RoomID,
		CASE WHEN EXISTS ( 
			SELECT 
				1 
			FROM 
				Bookings 
			WHERE 
				RoomID = @RoomID 
				AND BookingStatus ='Active'
				AND ( @CheckIN BETWEEN CheckInDate AND CheckOutDate 
				        OR @CheckOUT BETWEEN CheckInDate AND CheckOutDate  
				        OR (CheckInDate >= @CheckIN AND CheckOutDate <= @CheckOUT) 
                    ) 
        ) THEN 'Booking' ELSE 'Available' 
		END AS Availability
	FROM Rooms WHERE RoomID = @RoomID
COMMIT
	