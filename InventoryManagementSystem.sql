--
-- Create InventoryManagementSystem Database
--
CREATE DATABASE InventoryManagementSystem
GO

--
-- Create Suppliers Table
--
CREATE TABLE Suppliers (
    SupplierID INT PRIMARY KEY IDENTITY(1,1),
    SupplierName NVARCHAR(255),
    ContactName NVARCHAR(255),
    ContactEmail NVARCHAR(255)
);
GO

--
-- Create InventoryItems Table
--
CREATE TABLE InventoryItems (
    ItemID INT PRIMARY KEY IDENTITY(1,1),
    ItemName NVARCHAR(255),
    Description NVARCHAR(1000),
    Price DECIMAL(10, 2),
    StockQuantity INT,
    SupplierID INT,
    FOREIGN KEY (SupplierID) REFERENCES Suppliers(SupplierID)
);
GO

--
-- Create PurchaseOrders Table
--
CREATE TABLE PurchaseOrders (
    OrderID INT PRIMARY KEY IDENTITY(1,1),
    OrderDate DATE,
    SupplierID INT,
    FOREIGN KEY (SupplierID) REFERENCES Suppliers(SupplierID)
);
GO

--
-- Create PurchaseOrderDetails Table
--
CREATE TABLE PurchaseOrderDetails (
    OrderDetailID INT PRIMARY KEY IDENTITY(1,1),
    OrderID INT,
    ItemID INT,
    Quantity INT,
    FOREIGN KEY (OrderID) REFERENCES PurchaseOrders(OrderID),
    FOREIGN KEY (ItemID) REFERENCES InventoryItems(ItemID)
);
GO

--
-- Insert sample data into Suppliers table
--
INSERT INTO Suppliers 
(
	SupplierName, 
	ContactName, 
	ContactEmail
)
VALUES 
('Supplier A', 'John Doe', 'john.doe@suppliera.com'),
('Supplier B','Adam Baker', 'adam.baker@supplierb.com');
GO

--
-- Insert sample data into InventoryItems table
--
INSERT INTO InventoryItems 
(
	ItemName, 
	Description, 
	Price, 
	StockQuantity, 
	SupplierID
)
VALUES 
('Laptop', 'High-performance laptop', 1000.00, 50, 1),
('Smartphone','Low-performance smartphone',300.00,40,1);
GO

--
-- Insert sample data into PurchaseOrders table
--
INSERT INTO PurchaseOrders 
(
	OrderDate, 
	SupplierID
)
VALUES 
	('2023-09-06', 1),
	('2023-08-05', 1);
GO

--
-- Insert sample data into PurchaseOrderDetails table
--
INSERT INTO PurchaseOrderDetails 
(
	OrderID, 
	ItemID, 
	Quantity
)
VALUES 
(1, 1, 10),
(2, 2, 9);
GO