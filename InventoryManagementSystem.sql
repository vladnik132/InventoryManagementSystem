-- Create InventoryManagementSystem database
CREATE DATABASE InventoryManagementSystem
GO

USE InventoryManagementSystem

-- Create Suppliers table
CREATE TABLE Suppliers 
(
    SupplierID INT PRIMARY KEY IDENTITY(1,1),
    SupplierName NVARCHAR(255),
    ContactName NVARCHAR(255),
    ContactEmail NVARCHAR(255)
);
GO

-- Create InventoryItems table
CREATE TABLE InventoryItems 
(
    ItemID INT PRIMARY KEY IDENTITY(1,1),
    ItemName NVARCHAR(255),
    Description NVARCHAR(1000),
    Price DECIMAL(10, 2),
    StockQuantity INT,
    SupplierID INT,
    FOREIGN KEY (SupplierID) REFERENCES Suppliers(SupplierID)
);
GO


-- Create PurchaseOrders table
CREATE TABLE PurchaseOrders 
(
    OrderID INT PRIMARY KEY IDENTITY(1,1),
    OrderDate DATE,
    SupplierID INT,
    FOREIGN KEY (SupplierID) REFERENCES Suppliers(SupplierID)
);
GO

-- Create PurchaseOrderDetails table
CREATE TABLE PurchaseOrderDetails 
(
    OrderDetailID INT PRIMARY KEY IDENTITY(1,1),
    OrderID INT,
    ItemID INT,
    Quantity INT,
    FOREIGN KEY (OrderID) REFERENCES PurchaseOrders(OrderID),
    FOREIGN KEY (ItemID) REFERENCES InventoryItems(ItemID)
);
GO

-- Insert sample data into Suppliers table
INSERT INTO Suppliers 
(
	SupplierName, 
	ContactName, 
	ContactEmail
)
VALUES 
	('Econt', 'John Brown', 'john.doe@econt.com'),
	('Hermes', 'Martin Davis', 'martin.davis@hermes.com'),
	('Econt', 'Adam Baker', 'adam.baker@econt.com'),
	('Speedy', 'Stefani Doe', 'adam.baker@speedy.com'),
	('Hermes', 'Pamela Monro', 'adam.baker@hermes.com'),
	('Speedy', 'Melani Smith', 'adam.baker@speedy.com');
GO

-- Insert sample data into InventoryItems table
INSERT INTO InventoryItems 
(
	ItemName, 
	Description, 
	Price, 
	StockQuantity, 
	SupplierID
)
VALUES 
	('Laptop', 'High-performance laptop', 1099.99, 50, 1),
	('Smartphone', 'Low-performance smartphone', 322.99, 37, 2),
	('Camera', 'High-performance camera', 569.99, 45, 3),
	('Laptop', 'Low-performance laptop', 454.99, 35, 1),
	('Smartphone', 'High-performance smartphone', 749.99, 27, 2),
	('Camera', 'Low-performance camera', 299.99, 58, 3);
GO

-- Insert sample data into PurchaseOrders table
INSERT INTO PurchaseOrders 
(
	OrderDate, 
	SupplierID
)
VALUES 
	('2022-09-06', 3),
	('2022-08-07', 1),
	('2023-01-16', 2),
	('2023-02-24', 3),
	('2023-05-15', 1),
	('2022-09-25', 2);
GO

-- Insert sample data into PurchaseOrderDetails table
INSERT INTO PurchaseOrderDetails 
(
	OrderID, 
	ItemID, 
	Quantity
)
VALUES 
	(1, 1, 20),
	(1, 1, 90),
	(1, 1, 40),
	(1, 1, 50),
	(1, 1, 60),
	(1, 1, 10);
GO

-- This stored procedure shows a product above, equal or below chosen sales threshold 
CREATE PROCEDURE GetSalesByThreshold
	@ItemName NVARCHAR(255),
	@Threshold INT,
	@AboveOrBelow NVARCHAR(10)
AS
BEGIN
	IF @AboveOrBelow = 'Above'
	BEGIN
		SELECT i.ItemName, pod.Quantity 
		FROM InventoryItems AS i
		INNER JOIN  PurchaseOrderDetails AS pod ON i.ItemID = pod.ItemID
		WHERE i.ItemName = @ItemName
			AND pod.Quantity > @Threshold;
	END
	ELSE IF @AboveOrBelow = 'Below'
	BEGIN
		SELECT i.ItemName, pod.Quantity
		FROM InventoryItems AS i
		INNER JOIN PurchaseOrderDetails AS pod ON i.ItemID = pod.ItemID
		WHERE i.ItemName = @ItemName
			AND pod.Quantity < @Threshold;
	END
END;
GO
 
EXEC GetSalesByThreshold 
	@ItemName = 'Laptop',
	@Threshold = 20,
	@AboveOrBelow = 'Above';
GO