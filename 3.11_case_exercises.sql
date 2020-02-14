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

