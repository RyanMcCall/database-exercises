-- Using the example from the lesson, re-create the employees_with_departments table.
CREATE TEMPORARY TABLE employees_with_departments AS
SELECT emp_no, first_name, last_name, dept_no, dept_name
FROM employees
JOIN dept_empt USING(emp_no)
JOIN departments USING(dept_no)
LIMIT 100;

-- Add a column named full_name to this table. It should be a VARCHAR whose length is the
-- sum of the lengths of the first name and last name columns
ALTER TABLE employees_with_departments ADD full_name VARCHAR(30);

-- Update the table so that full name column contains the correct data
UPDATE employees_with_departments
SET fullname = CONCAT(first_name, " ", last_name);

-- Remove the first_name and last_name columns from the table.
ALTER TABLE employees_with_departments DROP COLUMN first_name;
ALTER TABLE employees_with_departments DROP COLUMN last_name;

-- Create a temporary table based on the payment table from the sakila database.
CREATE TEMPORARY TABLE sak_payment AS
SELECT *
FROM sakila.payment;

-- Write the SQL necessary to transform the amount column such that it is stored as an integer representing the number of cents of the payment. For example, 1.99 should become 199.
ALTER TABLE sak_payment MODIFY amount FLOAT;

UPDATE sak_payment
SET amount = amount * 100;

ALTER TABLE sak_payment MODIFY amount INT;

-- Find out how the average pay in each department compares to the overall average pay.
-- In order to make the comparison easier, you should use the Z-score for salaries.
-- In terms of salary, what is the best department to work for? The worst?
CREATE TABLE avg_dept_salaries
SELECT employees.d.dept_name AS "dept_name", 
	AVG(employees.s.salary) AS "average_salary"
FROM employees.employees AS e
JOIN employees.dept_emp AS de ON employees.e.emp_no = employees.de.emp_no
JOIN employees.departments AS d ON employees.d.dept_no = employees.de.dept_no
JOIN employees.salaries AS s ON employees.s.emp_no = employees.e.emp_no
WHERE employees.de.to_date > CURDATE()
AND employees.s.to_date > CURDATE()
GROUP BY employees.d.dept_name;

CREATE TABLE overall_average AS
SELECT AVG(employees.s.salary) AS overall_average
FROM employees.salaries AS s
WHERE employees.s.to_date > NOW();

CREATE TABLE overall_std AS
SELECT STD(employees.s.salary) AS overall_std
FROM employees.salaries AS s
WHERE employees.s.to_date > NOW();

SELECT dept_name, average_salary,
	((average_salary - (SELECT * FROM overall_average)) / (SELECT * FROM overall_std))
FROM avg_dept_salaries;