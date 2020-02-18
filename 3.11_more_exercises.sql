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
SELECT country_id, country
FROM country
WHERE country IN ("Afghanistan", "Bangladesh", "China");

-- List the last names of all the actors, as well as how many actors have that last name.
SELECT last_name, COUNT(*) actors_with_last_name
FROM actor
GROUP BY last_name;

-- List last names of actors and the number of actors who have that last name, but only
-- for names that are shared by at least two actors
SELECT last_name, COUNT(*) actors_with_last_name
FROM actor
GROUP BY last_name
HAVING COUNT(*) > 2;

-- You cannot locate the schema of the address table. Which query would you use to
-- re-create it?
SHOW CREATE TABLE address;
-- CREATE TABLE `address` (
--   `address_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
--   `address` varchar(50) NOT NULL,
--   `address2` varchar(50) DEFAULT NULL,
--   `district` varchar(20) NOT NULL,
--   `city_id` smallint(5) unsigned NOT NULL,
--   `postal_code` varchar(10) DEFAULT NULL,
--   `phone` varchar(20) NOT NULL,
--   `location` geometry NOT NULL,
--   `last_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
--   PRIMARY KEY (`address_id`),
--   KEY `idx_fk_city_id` (`city_id`),
--   SPATIAL KEY `idx_location` (`location`),
--   CONSTRAINT `fk_address_city` FOREIGN KEY (`city_id`) REFERENCES `city` (`city_id`) ON UPDATE CASCADE
-- ) ENGINE=InnoDB AUTO_INCREMENT=606 DEFAULT CHARSET=utf8

-- Use JOIN to display the first and last names, as well as the address, of each staff
-- member.
SELECT first_name, last_name, address
FROM staff s
JOIN address a ON s.address_id = a.address_id;

-- Use JOIN to display the total amount rung up by each staff member in August of 2005.
SELECT s.staff_id, s.first_name, s.last_name, SUM(p.amount)
FROM payment p
JOIN staff s ON s.staff_id = p.staff_id
WHERE payment_date LIKE "2005-08%"
GROUP BY s.staff_id, s.first_name, s.last_name;

-- List each film and the number of actors who are listed for that film.
SELECT f.title, COUNT(*) num_actors
FROM film f
JOIN film_actor fa ON f.film_id = fa.film_id
GROUP BY f.title;

-- How many copies of the film Hunchback Impossible exist in the inventory system?
SELECT f.title, COUNT(*) num_copies
FROM inventory i
JOIN film f ON f.film_id = i.film_id
WHERE f.title = "Hunchback Impossible";

-- The music of Queen and Kris Kristofferson have seen an unlikely resurgence. As an 
-- unintended consequence, films starting with the letters K and Q have also soared in 
-- popularity. Use subqueries to display the titles of movies starting with the letters K 
-- and Q whose language is English.
SELECT f.title
FROM film f
JOIN language l ON f.language_id = l.language_id
WHERE l.name = "English"
AND f.film_id IN (SELECT film_id
				FROM film
				WHERE title LIKE "Q%"
				OR title LIKE "K%");

-- Use subqueries to display all actors who appear in the film Alone Trip.
SELECT *
FROM actor
WHERE actor_id IN (SELECT actor_id
					FROM film_actor
					WHERE film_id = (SELECT film_id
										FROM film
										WHERE title = "Alone Trip"));

-- You want to run an email marketing campaign in Canada, for which you will need the names
-- and email addresses of all Canadian customers.
SELECT first_name, last_name, email
FROM customer
WHERE address_id IN (SELECT address_id
					FROM address
					WHERE city_id IN (SELECT city_id
										FROM city
										WHERE country_id = (SELECT country_id
															FROM country
															WHERE country = "Canada")));
-- I added a version with just joins to see if it was faster
-- it is but only by like 10ms on average.
SELECT cu.first_name, cu.last_name, cu.email
FROM customer cu
JOIN address a ON a.address_id = cu.address_id
JOIN city ci ON ci.city_id = a.city_id
JOIN country co ON co.country_id = ci.country_id
WHERE country = "Canada";

-- Sales have been lagging among young families, and you wish to target all family movies
-- for a promotion. Identify all movies categorized as famiy films.
SELECT f.film_id, f.title
FROM film f
JOIN film_category fc ON fc.film_id = f.film_id
JOIN category c ON c.category_id = fc.category_id
WHERE c.name = "Family";

-- Write a query to display how much business, in dollars, each store brought in.
SELECT store.store_id, 
	SUM(amount)
FROM payment
JOIN staff ON staff.staff_id = payment.staff_id
JOIN store ON store.manager_staff_id = staff.staff_id
GROUP BY store.store_id;

-- Write a query to display for each store its store ID, city, and country.
SELECT s.store_id, ci.city, co.country
FROM store s
JOIN address a ON a.address_id = s.address_id
JOIN city ci ON ci.city_id = a.city_id
JOIN country co ON co.country_id = ci.country_id;

-- List the top five genres in gross revenue in descending order.
SELECT c.name, SUM(p.amount) gross_revenue
FROM payment p
JOIN rental r ON r.rental_id = p.rental_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film_category fc ON i.film_id = fc.film_id
JOIN category c ON c.category_id = fc.category_id
GROUP BY c.name
ORDER BY SUM(p.amount) DESC
LIMIT 5;

-- Select all columns from the actor table.
SELECT *
FROM actor;

-- Select only the last_name column from the actor table.
SELECT last_name
FROM actor;

-- Select all distinct (different) last names from the actor table.
SELECT DISTINCT last_name
FROM actor;

-- Select all distinct (different) postal codes from the address table.
SELECT DISTINCT postal_code
FROM address;

-- Select all distinct (different) ratings from the film table.
SELECT DISTINCT rating
FROM film;

-- Select the title, description, rating, movie length columns from the films table that
-- last 3 hours or longer.
SELECT title, description, rating, length
FROM film
WHERE length > 180;

-- Select the payment id, amount, and payment date columns from the payments table for
-- payments made on or after 05/27/2005.
SELECT payment_id, amount, payment_date
FROM payment
WHERE payment_date >= "2005-05-27";

-- Select the primary key, amount, and payment date columns from the payment table for
-- payments made on 05/27/2005.
SELECT payment_id, amount, payment_date
FROM payment
WHERE payment_date LIKE "2005-05-27%";

-- Select all columns from the customer table for rows that have a last names beginning
-- with S and a first names ending with N.
SELECT *
FROM customer
WHERE last_name LIKE "S%"
AND first_name LIKE "N%";

-- Select all columns from the customer table for rows where the customer is inactive or
-- has a last name beginning with "M".
SELECT *
FROM customer
WHERE active = 0
OR last_name LIKE "M%";

-- Select all columns from the category table for rows where the primary key is greater 
-- than 4 and the name field begins with either C, S or T.
SELECT *
FROM category
WHERE category_id > 4
AND name REGEXP "^[cst]";

-- Select all columns minus the password column from the staff table for rows that contain
-- a password.
SELECT staff_id, 
	first_name, 
	last_name, 
	address_id, 
	picture, 
	email, 
	store_id, 
	active, 
	username, 
	last_update
FROM staff
WHERE password IS NOT NULL;

-- Select all columns minus the password column from the staff table for rows that do not
-- contain a password.

SELECT staff_id, 
	first_name, 
	last_name, 
	address_id, 
	picture, 
	email, 
	store_id, 
	active, 
	username, 
	last_update
FROM staff
WHERE password IS NULL;

-- Select the phone and district columns from the address table for addresses in
-- California, England, Taipei, or West Java.
SELECT phone, district
FROM address
WHERE district IN ("California", "England", "Taipei", "West Java");

-- Select the payment id, amount, and payment date columns from the payment table for 
-- payments made on 05/25/2005, 05/27/2005, and 05/29/2005.
SELECT payment_id, amount, payment_date
FROM payment
WHERE DATE(payment_date) IN ("2005-05-25", "2005-05-27", "2005-05-29");

-- Select all columns from the film table for films rated G, PG-13 or NC-17.
SELECT *
FROM film
WHERE rating IN ("G", "PG-13", "NC-17");

-- Select all columns from the payment table for payments made between midnight 05/25/2005
-- and 1 second before midnight 05/26/2005.
SELECT *
FROM payment
WHERE payment_date BETWEEN "2005-05-25 00:00:00" AND "2005-05-26 23:59:59";

-- Select all columns from the film table for films where the length of the 
-- description is between 100 and 120.
SELECT *
FROM film
WHERE LENGTH(description) BETWEEN 100 AND 120;

-- Select all columns from the film table for rows where the description begins with
-- "A Thoughtful".
SELECT *
FROM film
WHERE description LIKE "A Thoughtful%";

-- Select all columns from the film table for rows where the description ends
-- with the word "Boat".
SELECT *
FROM film
WHERE description LIKE "%Boat";

-- Select the following columns from the film table where the description contains the word
-- "Database" and the length of the film is greater than 3 hours.
SELECT *
FROM film
WHERE description LIKE "%Database%"
AND length > 180;

-- Select all columns from the payment table and only include the first 20 rows.
SELECT *
FROM payment
LIMIT 20;

-- Select the payment date and amount columns from the payment table for rows where the
--  payment amount is greater than 5, and only select rows whose zero-based index in the
-- result set is between 1000-2000.
SELECT *
FROM payment
WHERE amount > 5
LIMIT 1000
OFFSET 1000;

-- Select all columns from the customer table, limiting results to those where the 
-- zero-based index is between 101-200.
SELECT *
FROM customer
LIMIT 100
OFFSET 100;

-- Select all columns from the film table and order rows by the length field in ascending
-- order.
SELECT *
FROM film
ORDER BY length;

-- Select all distinct ratings from the film table ordered by rating in descending order.
SELECT DISTINCT rating
FROM film
ORDER BY rating DESC;

-- Select the payment date and amount columns from the payment table for the first 20
-- payments ordered by payment amount in descending order.
SELECT payment_date, amount
FROM payment
ORDER BY amount DESC
LIMIT 20;

-- Select the title, description, special features, length, and rental duration columns
-- from the film table for the first 10 films with behind the scenes footage under 2 hours
-- in length and a rental duration between 5 and 7 days, ordered by length in descending
-- order.
SELECT title, description, special_features, length, rental_duration
FROM film
WHERE special_features LIKE "%Behind the Scenes%"
	AND length < 120
	AND rental_duration BETWEEN 5 AND 7
LIMIT 10;

-- Select customer first_name/last_name and actor first_name/last_name columns from
-- performing a left join between the customer and actor column on the last_name column
--  in each table. (i.e. customer.last_name = actor.last_name)
SELECT c.first_name customer_first_name,
	c.last_name customer_last_name,
	a.first_name actor_first_name,
	a.last_name actor_last_name
FROM customer c
LEFT JOIN actor a ON c.last_name = a.last_name;

-- Select the customer first_name/last_name and actor first_name/last_name columns from
-- performing a right join between the customer and actor column on the last_name column
-- in each table. 
SELECT c.first_name customer_first_name,
	c.last_name customer_last_name,
	a.first_name actor_first_name,
	a.last_name actor_last_name
FROM customer c
RIGHT JOIN actor a ON c.last_name = a.last_name;

-- Select the customer first_name/last_name and actor first_name/last_name columns from 
-- performing an inner join between the customer and actor column on the last_name column
-- in each table.
SELECT c.first_name customer_first_name,
	c.last_name customer_last_name,
	a.first_name actor_first_name,
	a.last_name actor_last_name
FROM customer c
JOIN actor a ON c.last_name = a.last_name;

-- Select the city name and country name columns from the city table, performing a left 
-- join with the country table to get the country name column.
SELECT city, country
FROM city
LEFT JOIN country ON city.country_id = country.country_id;

-- Select the title, description, release year, and language name columns from the film 
-- table, performing a left join with the language table to get the "language" column.
SELECT f.title, f.description, f.release_year, l.name language
FROM film f
LEFT JOIN language l ON l.language_id = f.language_id;

-- Select the first_name, last_name, address, address2, city name, district, and postal
-- code columns from the staff table, performing 2 left joins with the address table then 
-- the city table to get the address and city related columns.
SELECT s.first_name, 
	s.last_name, 
	a.address, 
	a.address2, 
	c.city city_name, 
	a.district, 
	a.postal_code
FROM staff s
LEFT JOIN address a ON s.address_id = a.address_id
LEFT JOIN city c ON c.city_id = a.city_id;

-- What is the average replacement cost of a film? Does this change depending on the rating
-- of the film?
SELECT AVG(replacement_cost)
FROM film;

SELECT rating, AVG(replacement_cost)
FROM film
GROUP BY rating;

-- How many different films of each genre are in the database?
SELECT name, COUNT(*)
FROM film_category fc
JOIN category c ON c.category_id = fc.category_id
GROUP BY name;

-- What are the 5 frequently rented films?
SELECT title, COUNT(*) total
FROM rental r
JOIN inventory i ON i.inventory_id = r.inventory_id
JOIN film f ON f.film_id = i.film_id
GROUP BY title
ORDER BY COUNT(*) DESC
LIMIT 5;




















-- What are the sales for each store for each month in 2005?
SELECT DATE_FORMAT(payment_date, '%Y-%m') "month", 
	store.store_id, 
	SUM(amount)
FROM payment
JOIN staff ON staff.staff_id = payment.staff_id
JOIN store ON store.manager_staff_id = staff.staff_id
GROUP BY month, store.store_id
HAVING month LIKE "2005%"
ORDER BY month;