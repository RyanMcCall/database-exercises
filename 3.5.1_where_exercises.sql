USE employees;

-- Find all employees with first names 'Irena', 'Vidya', or 'Maya' — 709 rows (Hint: Use IN).Find all employees with first names 'Irena', 'Vidya', or 'Maya' — 709 rows (Hint: Use IN).
SELECT * FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya');

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