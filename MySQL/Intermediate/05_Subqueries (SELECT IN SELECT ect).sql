-- Subqueries 
-- SELECT IN WHERE

SELECT *
FROM employee_demographics
WHERE employee_id IN 
				(SELECT employee_id
					FROM employee_salary
                    WHERE dept_id = 1)
;


-- SELECT IN SELECT
SELECT first_name, salary, 
(SELECT AVG(salary) 
FROM employee_salary) AS avg_salary;


-- SELECT IN FROM creating temp table
SELECT AVG(max_age)
FROM
(SELECT gender, 
AVG(age) AS avg_age, 
MAX(age) AS max_age, 
MIN(AGE) AS min_age, 
COUNT(age)
FROM employee_demographics
GROUP BY gender) AS Agg_table
;
