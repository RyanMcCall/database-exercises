-- Find the number of years each employee has been with the company, not just the
-- number of days. *Bonus* do this without the DATEDIFF function (hint: YEAR)
SELECT first_name, last_name, hire_date
    (YEAR(NOW()) - YEAR(hire_date)) AS years_employed
FROM employees;

-- Find out how old each employee was when they were hired.
SELECT first_name, last_name, birth_date,
    (YEAR(hire_date) - YEAR(birth_date)) AS age_hired
FROM employees;

-- Find the most recent date in the dataset. What does this tell you? Does this
-- explain the distribution of employee ages?
SELECT * FROM employees
ORDER BY hire_date DESC;