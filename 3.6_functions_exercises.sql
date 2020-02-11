USE employees;

-- Find all employees with first names 'Irena', 'Vidya', or 'Maya' — 709 rows (Hint: Use IN).Find all employees with first names 'Irena', 'Vidya', or 'Maya' — 709 rows (Hint: Use IN).
-- version 2: Update your query for 'Irena', 'Vidya', or 'Maya' to use OR instead of IN — 709 rows.
-- version 3: Add a condition to the previous query to find everybody with those names who is also male — 441 rows.
-- version 4: Modify your first query to order by first name. The first result should be Irena Reutenauer and the last result should be Vidya Simmen.
-- version 5: Update the query to order by first name and then last name. The first result should now be Irena Acton and the last should be Vidya Zweizig.
-- version 6: Change the order by clause so that you order by last name before first name. Your first result should still be Irena Acton but now the last result should be Maya Zyda.
-- version7: Now reverse the sort order for both queries.
SELECT * FROM employees
WHERE (first_name LIKE 'Irena'
OR first_name LIKE 'Vidya'
OR first_name LIKE 'Maya')
AND gender LIKE 'M'
ORDER BY last_name DESC, first_name DESC;

-- Find ALL employees whose LAST NAME STARTS WITH 'E' — 7,330 rows.
-- version 2: Update your queries for employees with 'E' in their last name to sort the results by their employee number. Your results should not change!
-- version 3: Now reverse the sort order for both queries.
SELECT * FROM employees
WHERE last_name LIKE 'e%'
ORDER BY emp_no DESC;

-- Find all employees hired in the 90s — 135,214 rows.
SELECT * FROM employees
WHERE hire_date LIKE '199%';

-- Find all employees born on Christmas — 842 rows.
SELECT * FROM employees 
WHERE birth_date LIKE '%-12-25';

-- Find all employees with a 'q' in their last name — 1,873 rows.
SELECT * FROM employees
WHERE last_name LIKE '%q%';

-- Find all employees whose last name starts or ends with 'E' — 30,723 rows.
SELECT * FROM employees
WHERE last_name LIKE '%e'
	OR last_name LIKE 'e%';

-- Duplicate the previous query and update it to find all employees whose last name starts and ends with 'E' — 899 rows.
SELECT * FROM employees
WHERE last_name LIKE '%e'
	AND last_name LIKE 'e%';

-- Update your queries for employees whose names start and end with 'E'. Use concat() to combine their first and last name together as a single column named full_name.
-- version 2: Convert the names produced in your last query to all uppercase.
SELECT UPPER(CONCAT(first_name, " ", last_name)) FROM employees
WHERE last_name LIKE '%e'
	AND last_name LIKE 'e%';
	
-- Find all employees hired in the 90s and born on Christmas — 362 rows.
-- version 2: Change the query for employees hired in the 90s and born on Christmas such that the first result is the oldest employee who was hired last. It should be Khun Bernini.
-- For your query of employees born on Christmas and hired in the 90s, use datediff() to find how many days they have been working at the company (Hint: You will also need to use NOW() or CURDATE())
SELECT *, 
	DATEDIFF(NOW(), hire_date) AS days_employed
FROM employees 
WHERE hire_date LIKE '199%'
	AND birth_date LIKE '%-12-25'
ORDER BY birth_date, hire_date DESC;
	
-- Find all employees with a 'q' in their last name but not 'qu' — 547 rows.
SELECT * FROM employees
WHERE last_name LIKE '%q%'
	AND last_name NOT LIKE '%qu%';

-- Find the smallest and largest salary from the salaries table.
SELECT MIN(salary) min_salary, 
	MAX(salary) max_salary
FROM salaries

-- Use your knowledge of built in SQL functions to generate a username for all of the
-- employees. A username should be all lowercase, and consist of the first character of
-- the employees first name, the first 4 characters of the employees last name, an underscore,
-- the month the employee was born, and the last two digits of the year that they were born.
SELECT LOWER(CONCAT(SUBSTR(first_name, 1, 1), SUBSTR(last_name, 1, 4), '_', SUBSTR(birth_date, 6, 2), SUBSTR(birth_date, 3, 2))) AS username,
	first_name,
	last_name,
	birth_date
FROM employees