#USE the employees DATABASE
USE `employees`;

#LIST ALL the TABLES IN the DATABASE
SHOW TABLES;

# Explore the employees table.
SELECT * FROM employees;

# What different data types are present on this table?
# 5. INT, DATE, CHAR, ENUM, DATE

#6.Which TABLE(s) DO you think contain a NUMERIC TYPE COLUMN?
# 6. All

# Which table(s) do you think contain a string type column?
# 7. All

# Which table(s) do you think contain a date type column?
# 8. dept_emp_latest_date, employees, titles, salaries, dept_manager

# What is the relationship between the employees and the departments tables?
# 9. dept_emp shows the relationship between employees and departments

#Show the SQL that created the dept_manager table.
SHOW CREATE TABLE dept_manager;