-- using exl as the current database
use exl;

-- 1) List all customers from Customer table.
SELECT * FROM Customer;

-- 22) List the first name, last name, and city of all customers from customer table.
SELECT FirstName, LastName, City FROM Customer;

-- 3) List all customers who are from Sweden from the Customer table.
SELECT Id, FirstName, LastName, City, Country, Phone
FROM Customer
WHERE Country = 'Sweden'

-- 4) Create a copy of Supplier table. Update the city to Sydney for supplier starting with letter P.
CREATE TABLE IF NOT EXISTS supplier_copy LIKE supplier; 
INSERT INTO supplier_copy
SELECT * FROM supplier
UPDATE supplier_copy
SET City = 'Sydney'
WHERE CompanyName = 'P%';

-- 5) Create a copy of Products table and Delete all products with unit price higher than $50.
CREATE TABLE IF NOT EXISTS product_copy LIKE product;  
INSERT product_copy SELECT * FROM product;  
DELETE FROM product_copy
WHERE UnitPrice > 50

-- 6) List the number of customers in each country
SELECT COUNT(Id), Country
FROM Customer
GROUP BY Country

-- 7) List the number of customers in each country sorted high to low
SELECT COUNT(Id), Country
FROM Customer
GROUP BY Country
ORDER BY COUNT(Id) DESC;

-- 8) List the total amount for items ordered by each customer
SELECT SUM(O.TotalAmount), C.FirstName, C.LastName
FROM Orders O JOIN Customer C
ON O.CustomerId = C.Id
GROUP BY C.FirstName, C.LastName
ORDER BY SUM(O.TotalAmount) DESC

-- 9) List the number of customers in each country. Only include countries with more than 10 customers.
SELECT COUNT(Id), Country
FROM Customer
GROUP BY Country
HAVING COUNT(Id) > 10;

-- 10) List the number of customers in each country, except the USA, sorted high to low. Only include countries with 9 or more customers 
SELECT COUNT(Id), Country
FROM Customer
WHERE Country <> 'USA'
GROUP BY Country
HAVING COUNT(Id) >= 9
ORDER BY COUNT(Id) DESC;

-- 11) List all customers whose first name or last name contains "ill".
SELECT * FROM customer
WHERE FirstName OR LastName LIKE '%ill%';

-- 12) List all customers whose average of their total order amount is between $1000 and $1200.Limit your output to 5 results.
SELECT CustomerId , AVG(TotalAmount) AS AverageTotalAmount
FROM orders
WHERE TotalAmount BETWEEN 1000 AND 1200
GROUP BY  CustomerId 
LIMIT 5 ;

-- 13) List all suppliers in the 'USA', 'Japan', and 'Germany', ordered by country from A-Z, and then by company name in reverse order.
SELECT Id, CompanyName, City, Country
FROM Supplier
WHERE Country IN ('USA', 'Japan', 'Germany')
ORDER BY Country ASC, CompanyName DESC;

-- 14) Show all orders, sorted by total amount (the largest amount first), within each year.
SELECT * FROM orders
ORDER BY YEAR(OrderDate) ,TotalAmount DESC

/* 15) Products with UnitPrice greater than 50 are not selling despite promotions. You are asked to
discontinue products over $25. Write a query to reflect this. Do this in the copy of the Product
table. DO NOT perform the update operation in the Product table.*/
UPDATE product_copy
SET IsDiscontinued = 1
WHERE UnitPrice > 50

-- 16) List top 10 most expensive products
SELECT Id, ProductName, UnitPrice, Package
FROM Product
ORDER BY UnitPrice DESC
LIMIT 10

-- 17) Get all but the 10 most expensive products sorted by price
SELECT Id, ProductName, UnitPrice, Package
FROM Product
ORDER BY UnitPrice DESC
OFFSET 10 ROWS

-- 18) Get the 10th to 15th most expensive products sorted by price
SELECT Id, ProductName, UnitPrice, Package
FROM Product
ORDER BY UnitPrice DESC
OFFSET 10 ROWS
FETCH NEXT 5 ROWS ONLY

-- 19) Write a query to get the number of supplier countries. Do not count duplicate values.
SELECT COUNT(DISTINCT Country)
FROM Supplier

-- 20) Find the total sales cost in each month of the year 2013.
SELECT MAX(TotalAmount)
FROM Orders
WHERE YEAR(OrderDate) = 2013;

-- 21) List all products with names that start with 'Ca'.
SELECT Id, ProductName, UnitPrice, Package
FROM Product
WHERE ProductName LIKE 'Ca%'

-- 22) List all products that start with 'Cha' or 'Chan' and have one more character.
SELECT Id, ProductName, UnitPrice, Package
FROM Product
WHERE ProductName LIKE 'Cha_' OR ProductName LIKE 'Chan_'

/* 23) Your manager notices there are some suppliers without fax numbers. He seeks your help to
get a list of suppliers with remark as "No fax number" for suppliers who do not have fax
numbers (fax numbers might be null or blank).Also, Fax number should be displayed for
customer with fax numbers.*/
SELECT Id, CompanyName, Phone, Fax
FROM Supplier
WHERE Fax IS NOT NULL;

SELECT Id, CompanyName, Phone, Isnull(Fax,'No fax Number') as Fax
FROM Supplier

-- 24) List all orders, their orderDates with product names, quantities, and prices.
SELECT O.OrderNumber, CONVERT(date,O.OrderDate) AS Date, P.ProductName, I.Quantity, I.UnitPrice
FROM Orders O
INNER JOIN OrderItem I ON O.Id = I.OrderId
INNER JOIN Product P ON P.Id = I.ProductId
ORDER BY O.OrderNumber

-- 25) List all customers who have not placed any Orders.
SELECT OrderNumber, TotalAmount, FirstName, LastName, C.City, Country
FROM Customer C LEFT JOIN Orders O
ON O.CustomerId = C.Id
Where OrderNumber is Null
ORDER BY TotalAmount

