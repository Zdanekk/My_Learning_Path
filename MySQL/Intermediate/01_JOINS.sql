-- JOINS
-- INNER JOIN/JOIN

SELECT dem.employee_id, age, occupation
FROM employee_demographics AS dem
INNER JOIN employee_salary AS sal
	ON dem.employee_id = sal.employee_id;
    
-- OUTER JOINs
SELECT *
FROM employee_demographics AS dem
RIGHT JOIN employee_salary AS sal
	ON dem.employee_id = sal.employee_id;
    
-- SELF JOINs

SELECT sal1.employee_id AS santa,
sal1.first_name AS santa_first_name,
sal1.last_name AS santa_last_name,
sal2.employee_id AS child,
sal2.first_name AS child_first_name,
sal2.last_name AS child_last_name
FROM employee_salary AS sal1
LEFT JOIN employee_salary AS sal2
	ON sal1.employee_id + 1 = sal2.employee_id
;


-- MULTIPLE JOINS TABLE
SELECT *
FROM employee_demographics AS dem
INNER JOIN employee_salary AS sal
	ON dem.employee_id = sal.employee_id
INNER JOIN parks_departments AS dp
	ON sal.dept_id = dp.department_id
;
    