-- Таблица Category
CREATE TABLE Category (
    Id INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(75) NOT NULL
);

-- Таблица Producer
CREATE TABLE Producer (
    Id INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(75) NOT NULL
);

-- Таблица Product
CREATE TABLE Product (
    Id INT PRIMARY KEY IDENTITY(1,1),
    ArticleNumber NVARCHAR(10) NOT NULL,
    Name NVARCHAR(30) NOT NULL,
    UnitId INT NOT NULL,
    Price MONEY NOT NULL,
    ProviderId INT NOT NULL,
    ProducerId INT NOT NULL,
    CategoryId INT NOT NULL,
    Discount DECIMAL(4,2) NULL,
    AmountInStock DECIMAL(8,2) NULL,
    Description NVARCHAR(MAX) NULL,
    Photo NVARCHAR(MAX) NULL
);

-- Таблица Provider
CREATE TABLE Provider (
    Id INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(25) NOT NULL
);

-- Таблица Unit
CREATE TABLE Unit (
    Id INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(5) NOT NULL
);

-- Таблица Role
CREATE TABLE Role (
    Id INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(25) NOT NULL
);

-- Таблица User
CREATE TABLE [User] (
    Id INT PRIMARY KEY IDENTITY(1,1),
    Surname NVARCHAR(30) NOT NULL,
    Name NVARCHAR(30) NOT NULL,
    Patronic NVARCHAR(30) NULL,
    Login NVARCHAR(30) NOT NULL,
    Password NVARCHAR(30) NOT NULL,
    RoleId INT NOT NULL
);

-- Таблица Order
CREATE TABLE [Order] (
    Id INT PRIMARY KEY IDENTITY(1,1),
    CreationDate DATE NOT NULL,
    DeliveryDate DATE NOT NULL,
    PickUpPointId INT NOT NULL,
    UserId INT NULL,
    ReceiptCode NVARCHAR(6) NOT NULL,
    StatusId INT NOT NULL
);

-- Таблица ProductInOrder
CREATE TABLE ProductInOrder (
    Id INT PRIMARY KEY IDENTITY(1,1),
    OrderId INT NOT NULL,
    ProductId INT NOT NULL,
    Amount INT NOT NULL
);

-- Таблица OrderStatus
CREATE TABLE OrderStatus (
    Id INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(20) NOT NULL
);

-- Таблица PickUpPoint
CREATE TABLE PickUpPoint (
    Id INT PRIMARY KEY IDENTITY(1,1),
    PostCode NVARCHAR(6) NOT NULL,
    City NVARCHAR(30) NOT NULL,
    Street NVARCHAR(30) NOT NULL,
    Building NVARCHAR(6) NULL
);

-- Добавление внешних ключей
ALTER TABLE Product ADD CONSTRAINT FK_Product_Unit 
    FOREIGN KEY (UnitId) REFERENCES Unit(Id);

ALTER TABLE Product ADD CONSTRAINT FK_Product_Provider 
    FOREIGN KEY (ProviderId) REFERENCES Provider(Id);

ALTER TABLE Product ADD CONSTRAINT FK_Product_Producer 
    FOREIGN KEY (ProducerId) REFERENCES Producer(Id);

ALTER TABLE Product ADD CONSTRAINT FK_Product_Category 
    FOREIGN KEY (CategoryId) REFERENCES Category(Id);

ALTER TABLE [User] ADD CONSTRAINT FK_User_Role 
    FOREIGN KEY (RoleId) REFERENCES Role(Id);

ALTER TABLE [Order] ADD CONSTRAINT FK_Order_PickUpPoint 
    FOREIGN KEY (PickUpPointId) REFERENCES PickUpPoint(Id);

ALTER TABLE [Order] ADD CONSTRAINT FK_Order_User 
    FOREIGN KEY (UserId) REFERENCES [User](Id);

ALTER TABLE [Order] ADD CONSTRAINT FK_Order_OrderStatus 
    FOREIGN KEY (StatusId) REFERENCES OrderStatus(Id);

ALTER TABLE ProductInOrder ADD CONSTRAINT FK_ProductInOrder_Order 
    FOREIGN KEY (OrderId) REFERENCES [Order](Id);

ALTER TABLE ProductInOrder ADD CONSTRAINT FK_ProductInOrder_Product 
    FOREIGN KEY (ProductId) REFERENCES Product(Id);