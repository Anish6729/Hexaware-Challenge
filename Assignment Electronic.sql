--task 1--
1
CREATE DATABASE TechShop;
GO
USE TechShop;

2,3 CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY IDENTITY(1,1),
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    Address VARCHAR(255)
);
CREATE TABLE Products (
    ProductID INT PRIMARY KEY IDENTITY(1,1),
    ProductName VARCHAR(100),
    Description VARCHAR(255),
    Price DECIMAL(10, 2)
);
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY IDENTITY(1,1),
    CustomerID INT,
    OrderDate DATE,
    TotalAmount DECIMAL(10, 2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);
CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY IDENTITY(1,1),
    OrderID INT,
    ProductID INT,
    Quantity INT,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);
CREATE TABLE Inventory (
    InventoryID INT PRIMARY KEY IDENTITY(1,1),
    ProductID INT,
    QuantityInStock INT,
    LastStockUpdate DATE,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

5 INSERT INTO Customers (FirstName, LastName, Email, Phone, Address)
VALUES
('John', 'Doe', 'john.doe@example.com', '1234567890', '123 Elm Street'),
('Jane', 'Smith', 'jane.smith@example.com', '0987654321', '456 Oak Avenue'),
('Michael', 'Johnson', 'm.johnson@example.com', '2345678901', '789 Pine Road'),
('Emily', 'Williams', 'e.williams@example.com', '3456789012', '321 Maple Blvd'),
('Daniel', 'Brown', 'd.brown@example.com', '4567890123', '654 Cedar Court'),
('Emma', 'Davis', 'emma.davis@example.com', '5678901234', '987 Birch Lane'),
('William', 'Miller', 'w.miller@example.com', '6789012345', '159 Spruce Street'),
('Sophia', 'Wilson', 'sophia.wilson@example.com', '7890123456', '753 Sycamore Drive'),
('James', 'Moore', 'j.moore@example.com', '8901234567', '951 Redwood Circle'),
('Olivia', 'Taylor', 'o.taylor@example.com', '9012345678', '357 Hickory Place');

INSERT INTO Products (ProductName, Description, Price)
VALUES
('Laptop', 'High-performance laptop', 999.99),
('Smartphone', 'Latest smartphone model', 799.99),
('Tablet', '10-inch display tablet', 499.99),
('Smartwatch', 'Wearable smart device', 199.99),
('Headphones', 'Noise-cancelling headphones', 149.99),
('Keyboard', 'Mechanical keyboard', 99.99),
('Mouse', 'Wireless mouse', 49.99),
('Monitor', '27-inch 4K monitor', 299.99),
('Speaker', 'Bluetooth speaker', 59.99),
('Charger', 'Fast charging adapter', 29.99);

INSERT INTO Orders (CustomerID, OrderDate, TotalAmount)
VALUES
(1, '2024-09-01', 1299.98),
(2, '2024-09-02', 1049.98),
(3, '2024-09-03', 1499.98),
(4, '2024-09-04', 549.98),
(5, '2024-09-05', 249.98),
(6, '2024-09-06', 849.98),
(7, '2024-09-07', 399.98),
(8, '2024-09-08', 229.98),
(9, '2024-09-09', 399.98),
(10, '2024-09-10', 699.98);

INSERT INTO OrderDetails (OrderID, ProductID, Quantity)
VALUES
(1, 1, 1), (1, 2, 1),
(2, 3, 2),
(3, 4, 3),
(4, 5, 1),
(5, 6, 2),
(6, 7, 1),
(7, 8, 1),
(8, 9, 2),
(9, 10, 3);

INSERT INTO Inventory (ProductID, QuantityInStock, LastStockUpdate)
VALUES
(1, 50, '2024-09-01'),
(2, 100, '2024-09-02'),
(3, 75, '2024-09-03'),
(4, 60, '2024-09-04'),
(5, 30, '2024-09-05'),
(6, 40, '2024-09-06'),
(7, 85, '2024-09-07'),
(8, 25, '2024-09-08'),
(9, 70, '2024-09-09'),
(10, 90, '2024-09-10');

--task--2

1 SELECT FirstName, LastName, Email
FROM Customers;

2 SELECT Orders.OrderID, Orders.OrderDate, Customers.FirstName, Customers.LastName
FROM Orders
JOIN Customers ON Orders.CustomerID = Customers.CustomerID;

3 INSERT INTO Customers (FirstName, LastName, Email, Phone, Address)
VALUES ('Alex', 'Johnson', 'alex.johnson@example.com', '1234567890', '456 Oak Street');
Select * from  Customers;

4 UPDATE Products
SET Price = Price * 1.10  
select * from Products;


5 DECLARE @OrderID INT = 1; 

BEGIN TRANSACTION;


DELETE FROM OrderDetails
WHERE OrderID = @OrderID;

DELETE FROM Orders
WHERE OrderID = @OrderID;

COMMIT;

6 INSERT INTO Orders (CustomerID, OrderDate, TotalAmount)
VALUES (11, '2024-09-19', 289.99);

7 UPDATE Customers
SET Email = 'new.email',
    Address = '777 tokyo'
WHERE CustomerID = 7;

8 UPDATE Orders
SET TotalAmount = (
    SELECT 
        SUM(OD.Quantity * P.Price)
    FROM 
        OrderDetails OD
    JOIN 
        Products P ON OD.ProductID = P.ProductID
    WHERE 
        OD.OrderID = Orders.OrderID
);


9  BEGIN TRANSACTION;

DECLARE @CustomerID INT = 6; 


DELETE FROM OrderDetails
WHERE OrderID IN (
    SELECT OrderID
    FROM Orders
    WHERE CustomerID = 6
);

DELETE FROM Orders
WHERE CustomerID = 6;

COMMIT;

10 INSERT INTO Products (ProductName, Description, Price)
VALUES ('Smartphone X10', 'Latest model with high-resolution camera and fast processor', 599.99);

11 ALTER TABLE Orders
ADD Status VARCHAR(50);

DECLARE @OrderID INT = 1;           
DECLARE @NewStatus VARCHAR(20) = 'Shipped'; 
UPDATE Orders
SET Status = @NewStatus
WHERE OrderID = @OrderID;

12 ALTER TABLE Customers
ADD OrderCount INT DEFAULT 0;

UPDATE Customers
SET OrderCount = (
    SELECT COUNT(*)
    FROM Orders
    WHERE Orders.CustomerID = Customers.CustomerID
);
--task -3
1 select O.OrderID,
    O.OrderDate,
    O.TotalAmount,
    C.CustomerID, 
	CONCAT(C.FirstName, ' ', C.LastName) AS CustomerName from Orders as O
Inner Join
	Customers as C
on O.CustomerID=C.CustomerID;

2.
SELECT 
    P.ProductName,
    SUM(OD.Quantity * P.Price) AS TotalRevenue
FROM 
    OrderDetails OD
JOIN 
    Products P ON OD.ProductID = P.ProductID
GROUP BY 
    P.ProductName;

3.	SELECT 
    C.CustomerID,
    C.FirstName,
    C.LastName,
    C.Email,
    C.Phone,
    C.Address
FROM 
    Customers C
WHERE 
    EXISTS (
        SELECT 1 
        FROM Orders O 
        WHERE O.CustomerID = C.CustomerID
    );


4.	SELECT TOP 1
    P.ProductName,
    SUM(OD.Quantity) AS TotalQuantityOrdered
FROM 
    OrderDetails OD
JOIN 
    Products P ON OD.ProductID = P.ProductID
GROUP BY 
    P.ProductName
ORDER BY 
    TotalQuantityOrdered DESC;


select * from Customers;


5.
ALTER TABLE Products ADD Category VARCHAR(50);

UPDATE Products
SET Category = 'Electronics'
WHERE ProductName IN ('Laptop', 'Smartphone', 'Tablet', 'Smartwatch', 'Headphones', 'Monitor', 'Speaker', 'Smartphone X10');

UPDATE Products
SET Category = 'Accessories'
WHERE ProductName IN ('Keyboard', 'Mouse', 'Charger');

SELECT 
    P.ProductName,
    P.Category
FROM 
    Products P
WHERE 
    P.Category = 'Electronics';
	
6.	SELECT 
    C.FirstName,
    C.LastName,
    AVG(O.TotalAmount) AS AverageOrderValue
FROM 
    Customers C
JOIN 
    Orders O ON C.CustomerID = O.CustomerID
GROUP BY 
    C.FirstName, C.LastName;



7	WITH OrderRevenue AS (
    SELECT 
        O.OrderID,
        O.CustomerID,
        SUM(OD.Quantity * P.Price) AS TotalRevenue
    FROM 
        Orders O
    JOIN 
        OrderDetails OD ON O.OrderID = OD.OrderID
    JOIN 
        Products P ON OD.ProductID = P.ProductID
    GROUP BY 
        O.OrderID, O.CustomerID
)
SELECT TOP 1
    ORV.OrderID,
    C.FirstName,
    C.LastName,
    C.Email,
    ORV.TotalRevenue
FROM 
    OrderRevenue ORV
JOIN 
    Customers C ON ORV.CustomerID = C.CustomerID
ORDER BY 
    ORV.TotalRevenue DESC;


8. SELECT 
    P.ProductName,
    COUNT(OD.ProductID) AS NumberOfOrders
FROM 
    Products P
LEFT JOIN 
    OrderDetails OD ON P.ProductID = OD.ProductID
GROUP BY 
    P.ProductName
ORDER BY 
    NumberOfOrders DESC;

9.
DECLARE @ProductName VARCHAR(100) = 'Charger'; 

SELECT DISTINCT
    C.CustomerID,
    C.FirstName,
    C.LastName,
    C.Email,
    C.Phone,
    C.Address
FROM 
    OrderDetails OD
JOIN 
    Orders O ON OD.OrderID = O.OrderID
JOIN 
    Products P ON OD.ProductID = P.ProductID
JOIN 
    Customers C ON O.CustomerID = C.CustomerID
WHERE 
    P.ProductName = @ProductName;


10. 
DECLARE @StartDate DATE = '2024-09-01'; 
DECLARE @EndDate DATE = '2024-09-11';   

SELECT 
    SUM(OD.Quantity * P.Price) AS TotalRevenue
FROM 
    Orders O
JOIN 
    OrderDetails OD ON O.OrderID = OD.OrderID
JOIN 
    Products P ON OD.ProductID = P.ProductID
WHERE 
    O.OrderDate BETWEEN @StartDate AND @EndDate;


---task 4---

1 SELECT 
    C.CustomerID,
    C.FirstName,
    C.LastName,
    C.Email,
    C.Phone,
    C.Address
FROM 
    Customers C
WHERE 
    C.CustomerID NOT IN (
        SELECT O.CustomerID
        FROM Orders O
    );


2. 	SELECT 
    SUM(QuantityInStock) AS TotalProductsAvailable
FROM 
    Inventory;

3. SELECT 
    SUM(OD.Quantity * P.Price) AS TotalRevenue
FROM 
    OrderDetails OD
JOIN 
    Products P ON OD.ProductID = P.ProductID;

4. 
DECLARE @CategoryName VARCHAR(50);  

SET @CategoryName = 'Electronics';

SELECT 
    AVG(OD.Quantity) AS AverageQuantityOrdered
FROM 
    OrderDetails OD
WHERE 
    OD.ProductID IN (
        SELECT P.ProductID
        FROM Products P
        WHERE P.Category = @CategoryName
    );


5. DECLARE @CustomerID INT;  


SET @CustomerID = 4;  

SELECT 
    SUM(OD.Quantity * P.Price) AS TotalRevenue
FROM 
    Orders O
JOIN 
    OrderDetails OD ON O.OrderID = OD.OrderID
JOIN 
    Products P ON OD.ProductID = P.ProductID
WHERE 
    O.CustomerID = @CustomerID;

6. SELECT 
    C.FirstName,
    C.LastName,
    COUNT(O.OrderID) AS NumberOfOrders
FROM 
    Customers C
JOIN 
    Orders O ON C.CustomerID = O.CustomerID
GROUP BY 
    C.CustomerID, C.FirstName, C.LastName
ORDER BY 
    NumberOfOrders DESC;

7. WITH CategoryQuantities AS (
    SELECT 
        P.Category, 
        SUM(OD.Quantity) AS TotalQuantityOrdered
    FROM 
        OrderDetails OD
    JOIN 
        Products P ON OD.ProductID = P.ProductID
    GROUP BY 
        P.Category
)

SELECT 
    Category, 
    TotalQuantityOrdered
FROM 
    CategoryQuantities
WHERE 
    TotalQuantityOrdered = (SELECT MAX(TotalQuantityOrdered) FROM CategoryQuantities);

8.SELECT 
    C.FirstName,
    C.LastName,
    SUM(OD.Quantity * P.Price) AS TotalSpending
FROM 
    Customers C
JOIN 
    Orders O ON C.CustomerID = O.CustomerID
JOIN 
    OrderDetails OD ON O.OrderID = OD.OrderID
JOIN 
    Products P ON OD.ProductID = P.ProductID
GROUP BY 
    C.CustomerID, C.FirstName, C.LastName
ORDER BY 
    TotalSpending DESC
OFFSET 0 ROWS FETCH NEXT 1 ROW ONLY;

9.SELECT 
    SUM(OD.Quantity * P.Price) / NULLIF(COUNT(DISTINCT O.OrderID), 0) AS AverageOrderValue
FROM 
    Orders O
JOIN 
    OrderDetails OD ON O.OrderID = OD.OrderID
JOIN 
    Products P ON OD.ProductID = P.ProductID;

10.SELECT 
    C.FirstName,
    C.LastName,
    COUNT(O.OrderID) AS TotalOrders
FROM 
    Customers C
LEFT JOIN 
    Orders O ON C.CustomerID = O.CustomerID
GROUP BY 
    C.CustomerID, C.FirstName, C.LastName
ORDER BY 
    TotalOrders DESC;


