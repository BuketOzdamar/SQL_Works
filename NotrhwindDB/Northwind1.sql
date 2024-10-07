--select * from Products
--select * from Products where CategoryID=1

--select * from Products where CategoryID=(select CategoryID from Categories 
--where CategoryName='SeaFood') and UnitsInStock>20 or SupplierID=(select SupplierID from Suppliers where City='Osaka')

--create Procedure TEST2
--as
--select * from Orders where EmployeeID in(select EmployeeID from Employees where City='London')
--and
--ShipVia=3 and ShipCountry='France'

--exec TEST2

--CREATE VIEW VIEW1
--AS
--SELECT OrderID, OrderDate, CompanyName, FirstName+' ' + LastName AS 'Empoyee', ShipName, ShipCity, ShipCountry FROM Orders
--INNER JOIN Customers
--ON
--Orders.CustomerID=Customers.CustomerID
--INNER JOIN Employees
--ON
--Orders.EmployeeID=Employees.EmployeeID

--SELECT * FROM VIEW1

--SELECT * FROM Invoices
--SELECT * FROM View_2

--EXEC CustOrderHist ANATR