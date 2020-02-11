USE employees;

-- In your script, use DISTINCT to find the unique titles in the titles table.
SELECT DISTINCT title FROM titles;

-- Find your query for employees whose last names start and end with 'E'. 
-- Update the query find just the unique last names that start and end with 'E' using
-- GROUP BY.
SELECT last_name FROM employees
WHERE last_name LIKE 'e%e'
GROUP BY last_name;

-- Update your previous query to now find unique combinations of first and last name 
-- where the last name starts and ends with 'E'. You should get 846 rows.
SELECT first_name, last_name FROM employees
WHERE last_name LIKE 'e%e'
GROUP BY last_name,first_name;

-- Find the unique last names with a 'q' but not 'qu'.
-- version 2: Add a COUNT() to your results and use ORDER BY to make it easier to find
-- employees whose unusual name is shared with others.
SELECT last_name, COUNT(*) FROM employees
WHERE last_name LIKE '%q%'
	AND last_name NOT LIKE '%qu%'
GROUP BY last_name
ORDER BY COUNT(*) DESC;

-- Update your query for 'Irena', 'Vidya', or 'Maya'. Use COUNT(*) and GROUP BY to find
-- the number of employees for each gender with those names.
SELECT COUNT(*), gender FROM employees
WHERE first_name LIKE 'Irena'
OR first_name LIKE 'Vidya'
OR first_name LIKE 'Maya'
GROUP BY gender;

-- Recall the query the generated usernames for the employees from the last lesson.
-- Are there any duplicate usernames?
SELECT LOWER(
		CONCAT(
			SUBSTR(first_name, 1, 1), 
			SUBSTR(last_name, 1, 4),
			'_', 
			SUBSTR(birth_date, 6, 2), 
			SUBSTR(birth_date, 3, 2)
			)
		) AS username,
    COUNT(*)
FROM employees
GROUP BY username
ORDER BY COUNT(*) DESC;

-- Bonus: how many duplicate usernames are there?
SELECT LOWER(
		CONCAT(
			SUBSTR(first_name, 1, 1), 
			SUBSTR(last_name, 1, 4),
			'_', 
			SUBSTR(birth_date, 6, 2), 
			SUBSTR(birth_date, 3, 2)
			)
		) AS username,
    COUNT(*)
FROM employees
GROUP BY username
HAVING COUNT(*) > 1
ORDER BY COUNT(*) DESC;