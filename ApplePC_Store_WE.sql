-- s92064060

create database ApplePC_Store;
use ApplePC_Store;

-- create table employee and insert data

CREATE TABLE employee (
 empNo varchar(30) NOT NULL,
 lname varchar(30) NOT NULL,
 fname varchar(30) NOT NULL,
 email varchar(30) NOT NULL
);

INSERT INTO employee (empNo, lname, fname, email) VALUES
('S92064060', 'safran', 'mohammed', 's92064060@ousl.com'),
('S92056783', 'Jeeva', 'Kumara', 'sS92056783@gmail.com'),
('S34563213', 'Anura', 'Rathna', 's34563213@gmail.com'),
('S89346704', 'Affan', 'Haris', 's89346704@gmail.com');

-- create table product and insert data

CREATE TABLE product (
pCode varchar(30) NOT NULL, 
pName varchar(30) NOT NULL,
pDescription varchar(100) NOT NULL,
quantityInStock INT NOT NULL,
buyingPrice DECIMAL (10,2)
);

INSERT INTO product (pCode, pName, pDescription, quantityInStock, buyingPrice) VALUES
('P001', 'Laptop', 'High-performance laptop', '10', '200000.00'),
('P002', 'Monitor', 'Full HD Monitor', '15', '250000.00'),
('P003', 'Keyboard', 'Mechanical Gaming Keyboard', '20', '5000.00');

-- create table customer and insert data

CREATE TABLE customer(
 cusNo varchar(30) NOT NULL, 
 cName varchar(30) NOT NULL,
 contactNo varchar(10),
 city varchar(30) NOT NULL, 
 address varchar(100) NOT NULL,
 pCode varchar(30) NOT NULL
 ); 
 
 INSERT INTO customer (cusNo, cName, contactNo, city, address, pCode) VALUES
 ('C721424060', 'M.N.M.Safran', '0750571021', 'Pottuvil', '123 Main St', 'P001'),
 ('C456432465', 'J.Smith', '9876543210', 'Los Angeles', '456 Elm St', 'P002'),
 ('C234567864', 'M.Johnson', '5555555555', 'Chicago', '789 Oak St', 'P003');
 
 -- create table orderProduct and insert data
 
CREATE TABLE orderProduct( 
 orderId varchar(30) NOT NULL primary key,
 orderDate DATE, 
 orderStatus varchar(30), 
 cusNo varchar(30) NOT NULL, 
 empNo varchar(30) NOT NULL
 );
 
  INSERT INTO orderProduct (orderId, orderDate, orderStatus, cusNo, empNo) VALUES
 ('O001', '2023-06-01', 'Shipped', 'C721424060', 'S92064060'),
 ('O002', '2023-06-02', 'Pending', 'C721427371', 'S92056783'),
 ('O003', '2023-06-03', 'Delivered', 'C721427371', 'S34563213');
 
-- define primary key and foreign key

ALTER TABLE employee
ADD PRIMARY KEY(empNo);

ALTER TABLE product
ADD PRIMARY KEY(pCode);

ALTER TABLE CUSTOMER
ADD PRIMARY KEY(cusNo),
ADD CONSTRAINT FK_productCustomer
FOREIGN KEY(pCode) REFERENCES product(pCode);

ALTER TABLE orderProduct
ADD CONSTRAINT FK_CustomerOrder
FOREIGN KEY (cusNo) REFERENCES customer(cusNo);

ALTER TABLE orderProduct
ADD CONSTRAINT FK_EmployeeOrder
FOREIGN KEY (empNo) REFERENCES employee(empNo);

select *from employee;
select *from product;
select *from customer;
select *from orderproduct;

-- Q03

ALTER TABLE customer
ADD postalCode varchar(25);

select *from customer;

-- Q04

ALTER TABLE customer
DROP column city;

-- Q05

truncate TABLE orderproduct;

select *from orderproduct;

-- Q06

UPDATE orderproduct
SET orderStatus = 'Complete'
WHERE orderDate = '2023-06-03';

-- Q07

DELETE FROM product
WHERE quantityInStock < 2 ;

select *from product;
-- Q08 1

select *from employee;

-- 2
select product.pName, product.pDescription, customer.cName
from product
left join customer on product.pCode = customer.pCode;

-- 3
SELECT lname, email
FROM employee
WHERE empNo IN (
    SELECT empNo
    FROM orderproduct
    GROUP BY empNo
    HAVING COUNT(*) >= 2
);

-- 4
SELECT pName, buyingPrice, quantityInStock AS "Available Quantity"
FROM product WHERE quantityInStock = (SELECT MAX(quantityInStock) FROM product);

-- 5
SELECT c.cName, c.contactNo FROM customer c JOIN orderproduct o 
ON o.cusNo = c.cusNo WHERE o.orderStatus = "Pending" GROUP BY c.cusNo;

-- 6
SELECT * FROM orderproduct ORDER BY orderDate DESC LIMIT 3;

-- 7
SELECT c.cName, SUM(p.buyingPrice) AS "Total Buying Price" FROM customer c
JOIN orderproduct o ON o.cusNo = c.cusNo
JOIN product p ON o.pCode = p.pCode
WHERE c.cName = "Gorge Lucas" GROUP BY c.cName;