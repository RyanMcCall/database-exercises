USE employees;
-- How much do the current managers of each department get paid, relative to the average 
-- salary for the department? Is there any department where the department manager gets
-- paid less than the average salary?
SELECT d.dept_name,
	s.salary AS mgmt_sal,
	da.avg_dept_sal,
	(s.salary - da.avg_dept_sal) AS rel_mgmt_sal
FROM dept_manager dm
JOIN salaries s ON s.emp_no = dm.emp_no
JOIN departments d ON d.dept_no = dm.dept_no
JOIN (
	SELECT de.dept_no AS dept_no, AVG(s.salary) avg_dept_sal
	FROM dept_emp de
	JOIN salaries s ON s.emp_no = de.emp_no
	WHERE de.to_date > NOW()
	AND s.to_date > NOW()
	GROUP BY dept_no
	) AS da ON da.dept_no = dm.dept_no
WHERE dm.to_date > NOW()
AND s.to_date > NOW();
-- Both the Production and Customer Service make less then the average department salary
-- with Production make -$11,189.30 less and Customer Service making -$8540.23 less.

-- Use the world database for the questions below.
USE world;

-- What languages are spoken in Santa Monica?
SELECT Language, Percentage
FROM city ci
JOIN country co ON co.code = ci.countrycode
JOIN countrylanguage cl ON co.code = cl.countrycode
WHERE ci.name = "santa monica"
ORDER BY percentage;

-- How many different countries are in each region?
SELECT Region, COUNT(*) num_countries
FROM country
GROUP BY region
ORDER BY num_countries;

-- What is the population for each region?
SELECT Region, SUM(population) AS Population
FROM country
GROUP BY region
ORDER BY population DESC;

-- What is the population for each continent?
SELECT Continent, SUM(Population) AS Population
FROM country
GROUP BY Continent
ORDER BY Population DESC;

-- What is the average life expectancy globally?
SELECT AVG(LifeExpectancy) AS avg_life_expec
FROM country;

-- What is the average life expectancy for each region, each continent? 
-- Sort the results from shortest to longest
SELECT region, AVG(LifeExpectancy) AS avg_life_expec
FROM country
GROUP BY region
ORDER BY avg_life_expec;

SELECT continent, AVG(LifeExpectancy) AS avg_life_expec
FROM country
GROUP BY continent
ORDER BY avg_life_expec;

-- Find all the countries whose local name is different from the official name
SELECT Name AS OfficialCountryName, LocalCountryName
FROM country
WHERE Name NOT LIKE LocalName;

-- How many countries have a life expectancy less than the average life expectancy?
SELECT NAME country, LifeExpectancy AS life_expec
FROM country
WHERE LifeExpectancy < (
	SELECT AVG(LifeExpectancy) AS avg_life_expec
	FROM country)
ORDER BY LifeExpectancy;
    -- 82 countries

-- What state is city x located in?
SELECT Name city, District
FROM city;

-- What region of the world is city x located in?
SELECT ci.Name city, co.Region region
FROM city ci
JOIN country co ON co.Code = ci.CountryCode;

-- What country (use the human readable name) city x located in?
SELECT ci.Name city, co.Name country
FROM city ci
JOIN country co ON co.Code = ci.CountryCode;

-- What is the life expectancy in city x?
SELECT ci.Name CityName, co.LifeExpectancy
FROM city ci
JOIN country co ON co.Code = ci.CountryCode;

-- Sakila Database
USE sakila;

-- Display the first and last names in all lowercase of all the actors.
SELECT LOWER(first_name), LOWER(last_name)
FROM actor;

-- You need to find the ID number, first name, and last name of an actor, of whom you know
--  only the first name, "Joe." What is one query you could use to obtain this 
-- information?
SELECT actor_id, first_name, last_name
FROM actor
WHERE first_name = "Joe";

-- Find all actors whose last name contain the letters "gen":
SELECT *
FROM actor
WHERE last_name LIKE "%gen%";

-- Find all actors whose last names contain the letters "li". This time, order the rows
-- by last name and first name, in that order.
SELECT *
FROM actor
WHERE last_name LIKE "%li%"
ORDER BY last_name, first_name;

-- Using IN, display the country_id and country columns for the following countries:
--  Afghanistan, Bangladesh, and China.