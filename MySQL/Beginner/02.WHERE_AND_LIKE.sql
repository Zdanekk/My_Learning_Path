-- WHERE Clause

SELECT *
FROM parks_and_recreation.employee_salary
WHERE first_name = 'Leslie';



SELECT *
FROM parks_and_recreation.employee_salary
WHERE salary >= 5000;


SELECT *
FROM employee_demographics
WHERE gender != 'Female';


SELECT *
FROM employee_demographics
WHERE birth_date > '1985-01-01';

-- AND OR NOT -- Logical Operators
SELECT *
FROM employee_demographics
WHERE birth_date > '1985-01-01'
AND gender != 'Female';

SELECT *
FROM employee_demographics
WHERE birth_date > '1985-01-01'
OR NOT gender = 'Female';


SELECT *
FROM employee_demographics
WHERE (first_name = 'Leslie' AND age = 44) OR age > 55;

-- LIKE Statement 
-- % and _

SELECT *
FROM employee_demographics
WHERE first_name LIKE 'a%';


SELECT *
FROM employee_demographics
WHERE first_name LIKE 'a___';

SELECT *
FROM employee_demographics
WHERE birth_date LIKE '1989%';

