USE employees;

-- Find all employees with first names 'Irena', 'Vidya', or 'Maya' — 709 rows (Hint: Use IN).Find all employees with first names 'Irena', 'Vidya', or 'Maya' — 709 rows (Hint: Use IN).
-- version 2: Update your query for 'Irena', 'Vidya', or 'Maya' to use OR instead of IN — 709 rows.
-- version 3: Add a condition to the previous query to find everybody with those names who is also male — 441 rows.
SELECT * FROM employees
WHERE (first_name LIKE 'Irena'
OR first_name LIKE 'Vidya'
OR first_name LIKE 'Maya')
AND gender LIKE 'M';

-- Find ALL employees whose LAST NAME STARTS WITH 'E' — 7,330 rows.
SELECT * FROM employees
WHERE last_name LIKE 'e%';

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
	
-- Find all employees hired in the 90s and born on Christmas — 362 rows.
SELECT * FROM employees 
WHERE hire_date LIKE '199%'
	AND birth_date LIKE '%-12-25';
	
-- Find all employees with a 'q' in their last name but not 'qu' — 547 rows.
SELECT * FROM employees
WHERE last_name LIKE '%q%'
	AND last_name NOT LIKE '%qu%';