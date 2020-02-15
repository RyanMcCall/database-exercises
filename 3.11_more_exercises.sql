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