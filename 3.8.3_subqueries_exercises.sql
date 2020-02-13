USE employees;

-- Find all the employees with the same hire date as employee 101010 using a sub-query.
SELECT *
FROM employees
WHERE hire_date IN (
	SELECT hire_date
	FROM employees
	WHERE emp_no = 101010
);

-- Find all the titles held by all employees with the first name Aamod.
SELECT title
FROM titles
WHERE emp_no IN (
	SELECT emp_no
	FROM employees
	WHERE first_name = "Aamod")
GROUP BY title;

-- How many people in the employees table are no longer working for the company?
SELECT COUNT(*) AS tot_no_longer_employed
FROM employees
WHERE emp_no IN (
	SELECT emp_no
	FROM dept_emp
	GROUP BY emp_no
	HAVING MAX(to_date) < NOW()
	);

-- Find all the current department managers that are female.
SELECT first_name, last_name
FROM employees
WHERE emp_no IN (
	SELECT emp_no
	FROM dept_manager
	WHERE to_date > NOW()
)
AND gender = "F";

-- Find all the employees that currently have a higher than average salary.
SELECT e.first_name, e.last_name, s.salary
FROM employees AS e
JOIN salaries AS s ON s.emp_no = e.emp_no
WHERE s.salary > (
	SELECT AVG(salary)
	FROM salaries)
AND s.to_date > NOW();

-- How many current salaries are within 1 standard deviation of the highest salary?
-- (Hint: you can use a built in function to calculate the standard deviation.)
SELECT COUNT(*) AS num_salaries_one_std_from_max
FROM salaries
WHERE salary >= (
	SELECT MAX(salary) - STD(salary)
	FROM salaries)
AND to_date > NOW();
-- What percentage of all salaries is this?
SELECT (SELECT COUNT(*) AS num_salaries_one_std_from_max
		FROM salaries
		WHERE salary >= (
			SELECT MAX(salary) - STD(salary)
			FROM salaries)
		AND to_date > NOW()
		)
	/ COUNT(*)
FROM salaries
WHERE to_date > NOW();