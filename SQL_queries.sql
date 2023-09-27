-- Task 1 --
/*
Add the following new columns to the employees table:
- Salary (INT)
- ManagerID (INT) NOT NULL
- DepartmentID (INT) NOT NULL
*/
ALTER TABLE employees
ADD (Salary INT,
	ManagerID INT NOT NULL,
	DepartmentID INT NOT NULL);
    
-- Task 2 --
/*
Insert the values from the table for each column.
*/
UPDATE employees
SET Salary = CASE EmployeeID
        WHEN 1 THEN 6900
        WHEN 2 THEN 2200
        WHEN 3 THEN 7100
        WHEN 4 THEN 3500
        WHEN 5 THEN 6900
        WHEN 6 THEN 3100
        WHEN 7 THEN 4500
        WHEN 8 THEN 4200
        WHEN 9 THEN 6000
    END,
    ManagerID = CASE EmployeeID
        WHEN 1 THEN 14
        WHEN 2 THEN 13
        WHEN 3 THEN 11
        WHEN 4 THEN 15
        WHEN 5 THEN 12
        WHEN 6 THEN 14
        WHEN 7 THEN 11
        WHEN 8 THEN 15
        WHEN 9 THEN 12
    END,
    DepartmentID = CASE EmployeeID
        WHEN 1 THEN 40
        WHEN 2 THEN 30
        WHEN 3 THEN 10
        WHEN 4 THEN 20
        WHEN 5 THEN 50
        WHEN 6 THEN 40
        WHEN 7 THEN 10
        WHEN 8 THEN 20
        WHEN 9 THEN 50
    END
WHERE EmployeeID IN (1, 2, 3, 4, 5, 6, 7, 8, 9);

-- Task 3 --
/*
Create a new table and call it departments and add the following columns to the table:
- DepartmentID (INT) NOT NULL and Primary Key
- ManagerID (INT) NOT NULL
- DepartmentName CHAR(25)
*/
CREATE TABLE departments (
	DepartmentID INT NOT NULL,
	ManagerID INT NOT NULL,
	DepartmentName CHAR(25),
    PRIMARY KEY (DepartmentID));
    
-- Task 4 --
/*
Insert values in the table below to the new table.
*/
INSERT INTO departments (DepartmentName, DepartmentID, ManagerID)
VALUES 
	('Administration', 10, 11),
	('Shipping', 20, 12),
   	('Purchasing', 30, 13),
	('Sales', 40, 14), 
	('IT support', 50, 15);

-- Task 5 --
/*
Write a SQL query to find all those employees who work in the Shipping department. Return DepartmentID, FirstName, and DepartmentName.
*/
SELECT d.DepartmentID, e.FirstName, d.DepartmentName FROM employees e
JOIN departments d
ON d.DepartmentID = e.DepartmentID
WHERE d.DepartmentName = 'Shipping';

-- Task 6 --
/*
Write a SQL query to find those employees whose ID matches any of the number 2, 5 and 9. Return all fields in the table.
*/
SELECT * FROM employees e
WHERE e.EmployeeID IN (2, 5, 9);

-- Task 7 --
/*
Show those employees who earn more than the average salary and work in a department with any employee whose first name contains the letter 'R'. Return EmployeeID, FirstName and Salary.
*/
SELECT e.EmployeeID, e.FirstName, e.Salary
FROM employees e
WHERE e.Salary > (
    SELECT AVG(e.Salary)
    FROM employees e
)
AND e.DepartmentID IN (
    SELECT e.DepartmentID
    FROM employees e
    WHERE e.FirstName LIKE '%R%'
);

-- Task 8 --
/*
Write a query to find total salary for those departments where at least one employee works. Return DepartmentID and total_salary.
*/
SELECT e.DepartmentID, SUM(e.Salary) AS `Total salary`, COUNT(e.EmployeeID) AS `No. of employees` FROM employees e
GROUP BY e.DepartmentID
HAVING COUNT(e.EmployeeID) >= 1;

-- Task 9 --
/*
Display the EmployeeID, LastName, Salary and the Status column with a title HIGH and LOW for those employees whose salary is more than and less than the average salary of all employees.
*/
SELECT e.EmployeeID, e.LastName, e.Salary,
  CASE 
    WHEN e.Salary > (SELECT AVG(e.Salary) FROM employees e) THEN 'HIGH'
    ELSE 'LOW'
  END AS Status
FROM employees e;

-- Task 10 --
/*
Show all odd rows from the employees table.
*/
SELECT * FROM employees e
WHERE e.EmployeeID % 2 = 1;

-- Task 11 --
/*
Create a copy of the employees. Name the new table Employees_copy.
*/
CREATE TABLE employees_copy LIKE employees;
-- Add data
INSERT INTO employees_copy SELECT * FROM employees;

-- Task 12 --
/*
Find the 5th highest salary without using limit.
*/
SELECT * FROM ( 
	SELECT ROW_NUMBER() OVER (ORDER BY e.Salary DESC) AS rownumber, e.Salary 
	FROM employees e)
	AS ex
WHERE rownumber = 5;

-- Task 13 --
/*
Write a SQL query to find employees with the same salary.
*/
SELECT e1.EmployeeID, e1.FirstName, e1.LastName, e1.Salary FROM employees e1
JOIN employees e2 
ON e1.Salary = e2.Salary AND e1.EmployeeID <> e2.EmployeeID
ORDER BY e1.Salary;


