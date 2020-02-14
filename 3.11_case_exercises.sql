USE employees;

-- Write a query that returns all employees (emp_no), their department number, their start
-- date, their end date, and a new column 'is_current_employee' that is a 1 if the
-- employee is still with the company and 0 if not.
SELECT *,
	IF(to_date < NOW(), TRUE, FALSE) AS is_current_employee
FROM dept_emp;

-- Write a query that returns all employee names, and a new column 'alpha_group' that
-- returns 'A-H', 'I-Q', or 'R-Z' depending on the first letter of their last name.
SELECT CONCAT(first_name, " ", last_name) as employee_full_name,
    CASE
        WHEN last_name REGEXP '^[a-h]' THEN "A-F"
        WHEN last_name REGEXP '^[i-q]' THEN "I-Q"
        WHEN last_name REGEXP '^[r-z]' THEN "R-Z"
        ELSE "other"
    END AS alpha_group
FROM employees;

-- How many employees were born in each decade?
SELECT CASE 
	WHEN birth_date LIKE "195%" THEN "1950s"
	WHEN birth_date LIKE "196%" THEN "1960s"
	ELSE "other"
	END AS birth_decade,
COUNT(*)
FROM employees
GROUP BY birth_decade;

-- What is the average salary for each of the following department groups: R&D, Sales & Marketing, Prod & QM, Finance & HR, Customer Service?
SELECT AVG(s.salary),
        CASE 
            WHEN dept_name IN ('research', 'development') THEN 'R&D'
            WHEN dept_name IN ('sales', 'marketing') THEN 'Sales & Marketing' 
            WHEN dept_name IN ('Production', 'Quality Management') THEN 'Prod & QM'
            ELSE dept_name
            END AS dept_group
FROM dept_emp AS de 
JOIN departments AS d ON de.dept_no = d.dept_no
JOIN salaries AS s ON s.emp_no = de.emp_no
GROUP BY dept_group;