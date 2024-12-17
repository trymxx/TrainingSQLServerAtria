--Tugas 1
 ----------------no2
CREATE TABLE Employees (
	EmployeeID int NOT NULL,
	FirstName varchar(50),
	LastName varchar(50),

	DepartmentID int NULL,
	Salary money NULL,
    HireDate date,
	CONSTRAINT PK__Employee__7AD04FF1F8CF97E6 PRIMARY KEY (EmployeeID)
);

CREATE TABLE Departemens (
	DepartementID int NOT NULL,
	DepartementName varchar(50),
	ManagerID INT
);
CREATE TABLE Salaries (
	SalaryID int NOT NULL,
	EmployeeID INT,
	Amount money,

	SalaryDate date,
);

CREATE TABLE Sales (
	SaleID int NOT NULL,
	EmployeeID INT,
	SaleAmount money,

	SalaryDate date,
);


INSERT INTO PerusahaanDBAtria.dbo.Departemens
(DepartementID, DepartementName, ManagerID)
VALUES(1, 'Production', 1),(2, 'PE', 2),(3, 'QA', 3);

INSERT INTO PerusahaanDBAtria.dbo.Employees
(EmployeeID, FirstName, LastName, DepartmentID, Salary, HireDate)
VALUES(1, 'Atria', 'Ernandia', 1, 20000000, '2018-07-09'),(2, 'Putri', 'Yuliastutik', 2, 19000000, '2019-07-09'),(3, 'Faisya', 'Syafadilla', 3, 18000000, '2020-07-09');

INSERT INTO PerusahaanDBAtria.dbo.Salaries
(SalaryID, EmployeeID, Amount, SalaryDate)
VALUES(1, 1, 20000000, '2021-11-20'),(2, 2, 19000000, '2021-11-20'),(3, 3, 18000000, '2021-11-20');

INSERT INTO PerusahaanDBAtria.dbo.Sales
(SaleID, EmployeeID, SaleAmount, SalaryDate)
VALUES(1, 1, 20000000, '2021-11-20'),(2, 2, 19000000, '2021-11-20'),(3, 3, 18000000, '2021-11-20');

SELECT  
    CONCAT(FirstName, ' ', LastName) Name
    ,DATEDIFF(day, HireDate, GETDATE())
FROM
    PerusahaanDBAtria.dbo.Employees


--TUGAS 2
SELECT EmployeeID, FirstName, LastName, DepartmentID, Salary, HireDate
FROM PerusahaanDBAtria.dbo.Employees
WHERE FirstName LIKE 'A%'

SELECT  
    CONCAT(FirstName, ' ', LastName) Name
    ,Salary
    ,CASE WHEN Salary > 19000000 THEN 'HIGH'
    WHEN Salary BETWEEN 18000001 AND 19000000 THEN 'MEDIUM'
    ELSE 'LOW'
    END
FROM
    PerusahaanDBAtria.dbo.Employees
    
SELECT
    EmployeeID
    ,Salary
FROM
    PerusahaanDBAtria.dbo.Employees
WHERE 
    DepartmentID = 1 AND Salary >(SELECT AVG(Salary) FROM PerusahaanDBAtria.dbo.Employees WHERE DepartmentID = 1 )

--TUGAS 3
CREATE TABLE #TempEmployee(
    EmployeeID int NOT NULL,
	FirstName varchar(50),
	LastName varchar(50),
	DepartmentID int NULL,
	Salary money NULL,
    HireDate date,
);
INSERT INTO #TempEmployee
(EmployeeID, FirstName, LastName, DepartmentID, Salary, HireDate)
VALUES(1, 'Atria', 'Ernandia', 1, 20000000, '2018-07-09'),(2, 'Putri', 'Yuliastutik', 2, 19000000, '2019-07-09'),(3, 'Faisya', 'Syafadilla', 3, 18000000, '2020-07-09');

SELECT*FROM #TempEmployee;

DROP TABLE #TempEmployee;

WITH TotGaji AS(SELECT 
	DepartmentID, 
	SUM(Salary)TotSalary
FROM 
	PerusahaanDBAtria.dbo.Employees
GROUP BY
	DepartmentID)
SELECT
	*
FROM
	TotGaji;

--TUGAS 4
BEGIN TRANSACTION
UPDATE  
    PerusahaanDBAtria.dbo.Employees
SET
    Salary = Salary+(Salary*0.05)
WHERE
    DepartmentID = 1
IF @@ERROR = 0
COMMIT;
ELSE
ROLLBACK;

SET TRANSACTION ISOLATION LEVEL Serializable;
BEGIN TRANSACTION
DECLARE @salary money;
SELECT @salary = Salary FROM     PerusahaanDBAtria.dbo.Employees
WHERE EmployeeID =1;

SET @salary = @salary-1000000
    UPDATE  
        PerusahaanDBAtria.dbo.Employees
    SET
        Salary = @salary
    WHERE
        EmployeeID = 1
COMMIT;

--TUGAS 5


--TUGAS 6
CREATE PROCEDURE TotalPenjualanAtria @EmployeeID INT
AS 
BEGIN
SELECT 
	EmployeeID,
    FirstName,
    LastName, 
	Salary
FROM 
	PerusahaanDBAtria.dbo.Employees
WHERE 
	EmployeeID = @EmployeeID
END;
EXEC TotalPenjualanAtria @EmployeeID = 3;


CREATE TRIGGER trg_logSalaryAuditeAtria
ON Salaries
AFTER UPDATE 
AS
BEGIN
	INSERT INTO SalaryAudit(SalaryID, ChangeDate, OldSalary, NewSalary)
	SELECT i.SalaryID, GETDATE(), d.Amount, i.Amount
	FROM inserted i 
	JOIN deleted d ON i.SalaryID = d.SalaryID;
END

--TUGAS 8
REATE LOGIN SalesUser WITH PASSWORD 'Password123!';