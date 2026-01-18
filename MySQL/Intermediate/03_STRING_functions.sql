-- String functions 

SELECT length('skyfall');


SELECT first_name, LENGTH (first_name)
FROM employee_demographics
ORDER BY 2;

-- zamienia litery na duze/male
SELECT UPPER('sky');
SELECT LOWER('Sky');

-- usuwa spacje
SELECT TRIM('     sky     ');
SELECT RTRIM('     sky     ');
SELECT LTRIM('     sky     ');

-- wypisuje litery od lewej/prawej, 
-- substring wypisuje od podanej liczby wraz z nią + ilość
-- dziala tez na daty np wypisuje miesiace
SELECT first_name, 
LEFT(first_name, 4),
RIGHT(first_name, 4),
SUBSTRING(first_name,3,2),
birth_date,
SUBSTRING(birth_date,6,2) AS birth_month
FROM employee_demographics;



SELECT first_name, REPLACE(first_name, 'a', 'z')
FROM employee_demographics;

-- LOcate podaje pozycje w szeregu szukanej frazy
SELECT LOCATE('x', 'Alexander');

SELECT first_name, LOCATE('AN',first_name)
FROM employee_demographics;

-- CONCAT
SELECT first_name, last_name,
CONCAT(first_name,' ',last_name) AS full_name
FROM employee_demographics;

