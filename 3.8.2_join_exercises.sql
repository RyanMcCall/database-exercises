USE join_example_db;

-- Use join, left join, and right join to combine results from the users and roles tables
-- as we did in the lesson. Before you run each query, guess the expected number of results.
SELECT *
FROM users
JOIN roles ON users.role_id = roles.id;

SELECT *
FROM users
LEFT JOIN roles ON users.role_id = roles.id;

SELECT *
FROM users
RIGHT JOIN roles ON users.role_id = roles.id;

-- Use count and the appropriate join type to get a list of roles along with the number of
-- users that has the role. Hint: You will also need to use group by in the query.
SELECT r.name, COUNT(u.id)
FROM roles AS r
LEFT JOIN users u ON u.role_id = r.id
GROUP BY r.name;

USE employees;

-- Using the example in the Associative Table Joins section as a guide, write a query
-- that shows each department along with the name of the current manager for that
-- department.
SELECT dept_name AS "Department Name",
	CONCAT(employees.first_name, " ", employees.last_name) AS "Department Manager"
FROM employees 
JOIN dept_manager ON dept_manager.emp_no = employees.emp_no
JOIN departments ON departments.dept_no = dept_manager.dept_no
-- Zac added now for better checking of current status
WHERE dept_manager.to_date > NOW()
ORDER BY dept_name;

-- Find the name of all departments currently managed by women.
SELECT dept_name AS "Department Name",
	CONCAT(employees.first_name, " ", employees.last_name) AS "Department Manager"
FROM employees 
JOIN dept_manager ON dept_manager.emp_no = employees.emp_no
JOIN departments ON departments.dept_no = dept_manager.dept_no
-- Ryan added CURDATE() as an example of another use besides NOW()
WHERE dept_manager.to_date > CURDATE()
    AND employees.gender = "F"
ORDER BY dept_name;

-- Find the current titles of employees currently working in the Customer Service department.
SELECT t.title AS "Title",
	COUNT(*) AS "Count"
FROM dept_emp AS de
JOIN departments AS d ON d.dept_no = de.dept_no
JOIN titles AS t ON t.emp_no = de.emp_no
WHERE d.dept_name = "Customer Service"
    AND t.to_date > CURDATE()
    -- Added to make sure they are also current employee
    AND de.to_date > CURDATE()
GROUP BY t.title;

-- Find the current salary of all current managers.
SELECT dept_name AS "Department Name",
	CONCAT(e.first_name, " ", e.last_name) AS "Department Manager",
	s.salary AS "Salary"
FROM employees AS e
JOIN dept_manager AS dm ON dm.emp_no = e.emp_no
JOIN departments AS d ON d.dept_no = dm.dept_no
JOIN salaries AS s ON s.emp_no = e.emp_no
WHERE dm.to_date > CURDATE()
    AND s.to_date > CURDATE()
ORDER BY dept_name;

-- Find the number of employees in each department.
SELECT d.dept_no AS "dept_no", 
    d.dept_name AS "dept_name", 
    COUNT(*) AS "num_employess"
FROM dept_emp AS de
JOIN departments AS d ON d.dept_no = de.dept_no
WHERE de.to_date > CURDATE()
GROUP BY d.dept_no;

-- Which department has the highest average salary?
SELECT d.dept_name AS "dept_name", 
	AVG(s.salary) AS "average_salary"
FROM employees AS e
JOIN dept_emp AS de ON e.emp_no = de.emp_no
JOIN departments AS d ON d.dept_no = de.dept_no
JOIN salaries AS s ON s.emp_no = e.emp_no
WHERE s.to_date > CURDATE()
    AND de.to_date > CURDATE()
GROUP BY d.dept_name
ORDER BY AVG(s.salary) DESC
LIMIT 1;

-- Who is the highest paid employee in the Marketing department?
SELECT e.first_name AS "first_name",
	e.last_name AS "last_name"
FROM employees AS e
JOIN dept_emp AS de ON e.emp_no = de.emp_no
JOIN departments AS d ON d.dept_no = de.dept_no
JOIN salaries AS s ON s.emp_no = e.emp_no
WHERE s.to_date = CURDATE()
    AND de.to_date = CURDATE()
    AND d.dept_name = "Marketing"
ORDER BY s.salary DESC
LIMIT 1;

-- Which current department manager has the highest salary?
SELECT e.first_name AS "first_name",
    e.last_name AS "last_name",
    s.salary AS "salary",
    d.dept_name AS "dept_name"
FROM employees AS e
JOIN dept_manager AS dm ON dm.emp_no = e.emp_no
JOIN departments AS d ON d.dept_no = dm.dept_no
JOIN salaries AS s ON s.emp_no = e.emp_no
WHERE dm.to_date = "9999-01-01"
    AND s.to_date = "9999-01-01"
ORDER BY s.salary DESC
LIMIT 1;

-- Bonus Find the names of all current employees, their department name, and their current manager's name.
SELECT CONCAT(e.first_name, " ", e.last_name) AS "Employee Name",
	d.dept_name AS "Department Name",
	CONCAT(me.first_name, " ", me.last_name) AS "Manager Name"
FROM employees AS e
JOIN dept_emp AS de ON de.emp_no = e.emp_no
JOIN dept_manager AS dm ON dm.dept_no = de.dept_no
JOIN employees AS me ON dm.emp_no = me.emp_no
JOIN departments AS d ON d.dept_no = de.dept_no
WHERE dm.to_date > CURDATE()
AND de.to_date > CURDATE();

-- Bonus Find the highest paid employee in each department.
SELECT d.dept_name,
    CONCAT(e.first_name, " ", e.last_name) AS "Employee Name",
    s.salary
FROM employees AS e
JOIN dept_emp AS de ON de.emp_no = e.emp_no
JOIN departments AS d ON d.dept_no = de.dept_no
JOIN salaries AS s ON s.emp_no = e.emp_no
JOIN (
	SELECT d.dept_name
        MAX(s.salary) as "max_salary"
	FROM employees AS e
	JOIN dept_emp AS de ON de.emp_no = e.emp_no
	JOIN departments AS d ON d.dept_no = de.dept_no
	JOIN salaries AS s ON s.emp_no = e.emp_no
	WHERE s.to_date > CURDATE()
	GROUP BY d.dept_name
    ) AS ms ON ms.dept_name = d.dept_name AND ms.max_salary = s.salary
WHERE de.to_date > CURDATE()
AND s.to_date > CURDATE()
ORDER BY dept_name;