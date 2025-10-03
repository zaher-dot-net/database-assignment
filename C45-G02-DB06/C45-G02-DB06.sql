-- C45-G02-DB05

----------------------------------------------- Part 01 -----------------------------------------------

--- Use ITI DB
use ITI;

-- 1. Display instructors who have salaries less than the average salary of all instructors. 
select *
from Instructor where Salary < (select AVG(Salary) from Instructor);

-- 2. Display the Department name that contains the instructor who receives the minimum salary.
select Dept_Name
from Department
right join Instructor on Department.Dept_Id = Instructor.Dept_Id
where Instructor.Salary < (select AVG(Salary) from Instructor)
group by Dept_Name;

-- 3. Select max two salaries in instructor table..
select top 2 Salary
from Instructor
order by Salary desc;


--- Use MyCompany  DB
use MyCompany;

-- 4. Display the data of the department which has the smallest employee ID over all employees' ID.	
SELECT D.*
FROM Departments D
JOIN Employee E ON D.Dnum= E.Dno
WHERE E.Bdate >= (SELECT MAX(Bdate) FROM Employee);

-- 5. List the last name of all managers who have no dependents
SELECT E.Lname
FROM Employee E
JOIN Departments D ON E.SSN = D.MGRSSN
WHERE E.SSN NOT IN (SELECT Essn FROM Dependent);

-- 6. For each department-- if its average salary is less than the average salary of all employees displays its number, name and number of its employees.
SELECT D.Dnum, D.Dname, COUNT(E.SSN) AS NumOfEmployees
FROM Departments D
JOIN Employee E ON D.Dnum = E.Dno
GROUP BY D.Dnum, D.Dname
HAVING AVG(E.Salary) < (SELECT AVG(Salary) FROM Employee);

-- 7. Try to get the max 2 salaries using subquery.
SELECT Salary
FROM Employee
WHERE Salary IN ( SELECT top 2 Salary  FROM Employee order by Salary desc );


-- 8-Display the employee number and name if he/she has at least one dependent (use exists keyword) self-study.
SELECT E.SSN, E.Fname, E.Lname
FROM Employee E
WHERE EXISTS (
    SELECT 1
    FROM Dependent D
    WHERE D.Essn = E.SSN
);

-- 9. Write a query to select the highest two salaries in Each Department for instructors who have salaries. “Using one of Ranking Functions”
SELECT Dname, Salary
FROM (
    SELECT 
        E.Dno,
        D.Dname,
        E.Salary,
        ROW_NUMBER() OVER (
            PARTITION BY E.Dno 
            ORDER BY E.Salary DESC
        ) AS RowNum
    FROM Employee E
    right Join Departments D on E.Dno = D.Dnum
    WHERE E.Salary IS NOT NULL
      AND E.Dno IS NOT NULL 
) AS Ranked
WHERE RowNum <= 2;

-- 10 Write a query to select a random student from each department. “Using one of Ranking Functions”
--        I don't have student table fr DB MyCompany


----------------------------------------------- Part 02 -----------------------------------------------

-- Restore adventureworks2012 Database Then:

use Adventureworks2012;

-- 1. Display the SalesOrderID, ShipDate of the SalesOrderHearder table (Sales schema) to designate SalesOrders that occurred within the period ‘7/28/2002’ and ‘7/29/2014’
SELECT SalesOrderID, ShipDate
FROM Sales.SalesOrderHeader
WHERE ShipDate BETWEEN '2002-07-28' AND '2014-07-29';

-- 2. Display only Products(Production schema) with a StandardCost below $110.00 (show ProductID, Name only)
SELECT ProductID, Name
FROM Production.Product
WHERE StandardCost < 110.00;


-- 3. Display ProductID, Name if its weight is unknown
SELECT ProductID, Name
FROM Production.Product
WHERE Weight IS NULL;


-- 4. Display all Products with a Silver, Black, or Red Color
SELECT ProductID, Name, Color
FROM Production.Product
WHERE Color IN ('Silver', 'Black', 'Red');


-- 5. Display any Product with a Name starting with the letter B
SELECT ProductID, Name
FROM Production.Product
WHERE Name LIKE 'B%';


/*
6. Run the following Query
UPDATE Production.ProductDescription
SET Description = 'Chromoly steel_High of defects'
WHERE ProductDescriptionID = 3

Then write a query that displays any Product description with
underscore value in its description.

*/

UPDATE Production.ProductDescription
SET Description = 'Chromoly steel_High of defects'
WHERE ProductDescriptionID = 3

SELECT ProductDescriptionID, Description
FROM Production.ProductDescription
WHERE Description LIKE '%[_]%';


-- 8. Display the Employees HireDate (note no repeated values are allowed)

SELECT DISTINCT HireDate
FROM HumanResources.Employee;

/*
9.Display the Product Name and its ListPrice within the values of
100 and 120 the list should have the following format "The
[product name] is only! [List price]" (the list will be sorted
according to its ListPrice value)
*/

SELECT 
   CONCAT('The ' , Name,' is only! ' , ListPrice ) AS ProductInfo
FROM Production.Product
WHERE ListPrice BETWEEN 100 AND 120
ORDER BY ListPrice;
