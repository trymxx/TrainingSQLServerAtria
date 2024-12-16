--1. Cari nama belakang "Doe":
SELECT 
	EmployeeID, 
	FullName, 
	JobTitle, 
	Email, 
	HireDate
FROM 
	training.dbo.Employees
WHERE 
	FullName LIKE '%Doe';
--2. Cari JobTitle yang mengandung "Developer":
SELECT 
	EmployeeID, 
	FullName, 
	JobTitle, 
	Email, 
	HireDate
FROM 
	training.dbo.Employees
WHERE 
	JobTitle LIKE '%Developer%';
--3. Cari email yang diakhiri "example.com":
SELECT 
	EmployeeID, 
	FullName, 
	JobTitle, 
	Email, 
	HireDate
FROM 
	training.dbo.Employees
WHERE 
	Email LIKE '%example.com';
--4. Temukan semua produk yang memiliki kata pertama "Laptop" di ProductName.
SELECT 
	ProductID, 
	ProductName, 
	Category, 
	Price
FROM 
	training.dbo.Products
WHERE 	
	ProductName LIKE 'Laptop%';
--5. Cari produk dengan nama yang dimulai dengan huruf "S".
SELECT 
	ProductID, 
	ProductName, 
	Category, 
	Price
FROM 
	training.dbo.Products
WHERE 	
	ProductName LIKE 'S%';
--6. Temukan produk dengan harga di atas 1000 dan nama mengandung "Pro".
SELECT 
	ProductID, 
	ProductName, 
	Category, 
	Price
FROM 
	training.dbo.Products
WHERE 	
	Price>1000 AND ProductName LIKE '%Pro%';
--7. Cari pelanggan yang nama depannya dimulai dengan huruf "A" menggunakan LEFT.
SELECT 
	CustomerID, 
	FullName, 
	Email, 
	PhoneNumber, 
	RegistrationDate
FROM 
	training.dbo.Customers
WHERE LEFT(FullName,1)  = 'A';
--8. Cari pelanggan yang memiliki titik (.) dalam alamat email menggunakan CHARINDEX.
SELECT 
	CustomerID, 
	FullName, 
	Email, 
	PhoneNumber, 
	RegistrationDate
FROM 
	training.dbo.Customers
WHERE CHARINDEX('.',Email)>0;
--9. Cari pelanggan yang nomor teleponnya berisi "1234" menggunakan PATINDEX.
SELECT 
	CustomerID, 
	FullName, 
	Email, 
	PhoneNumber, 
	RegistrationDate
FROM 
	training.dbo.Customers
WHERE PATINDEX('%1234%',PhoneNumber)>0;

