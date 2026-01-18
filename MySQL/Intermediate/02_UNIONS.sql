-- UNIONS  (they are always distinct by default)
SELECT First_name, last_name
FROM employee_demographics
UNION
SELECT First_name, last_name
FROM employee_salary
;

-- UNION ALL
SELECT First_name, last_name
FROM employee_demographics
UNION ALL
SELECT First_name, last_name
FROM employee_salary
;


SELECT First_name, last_name, 'Old Man' AS Label
FROM employee_demographics
WHERE age > 40 AND gender = 'Male'
UNION 
SELECT First_name, last_name, 'Old Lady' AS Label
FROM employee_demographics
WHERE age > 40 AND gender = 'Female'
UNION 
SELECT First_name, last_name, 'Highly paid Employee' AS Label
FROM employee_salary
WHERE salary > 70000
ORDER BY First_name, last_name
;

