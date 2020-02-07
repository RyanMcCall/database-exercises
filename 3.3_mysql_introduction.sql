#USE the employees DATABASE
USE `employees`;

#LIST ALL the TABLES IN the DATABASE
SHOW TABLES;

# Explore the employees table.
SELECT * FROM employees;

# What different data types are present on this table?
# 5. INT, DATE, CHAR, ENUM, DATE

#6.Which TABLE(s) DO you think contain a NUMERIC TYPE COLUMN?
# 6. All, but departments

# Which table(s) do you think contain a string type column?
# 7. All, salaries

# Which table(s) do you think contain a date type column?
# 8. dept_emp_latest_date, employees, titles, salaries, dept_manager

# What is the relationship between the employees and the departments tables?
# 9. No direct relationship, but dept_emp and dept_manager shows the relationship between employees and departments.

#Show the SQL that created the dept_manager table.
SHOW CREATE TABLE dept_manager;

/* CREATE TABLE `dept_manager` (
  `emp_no` int(11) NOT NULL,
  `dept_no` char(4) NOT NULL,
  `from_date` date NOT NULL,
  `to_date` date NOT NULL,
  PRIMARY KEY (`emp_no`,`dept_no`),
  KEY `dept_no` (`dept_no`),
  CONSTRAINT `dept_manager_ibfk_1` FOREIGN KEY (`emp_no`) REFERENCES `employees` (`emp_no`) ON DELETE CASCADE,
  CONSTRAINT `dept_manager_ibfk_2` FOREIGN KEY (`dept_no`) REFERENCES `departments` (`dept_no`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 */