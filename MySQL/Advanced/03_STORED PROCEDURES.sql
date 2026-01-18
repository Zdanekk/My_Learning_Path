-- STORED procedures

CREATE PROCEDURE large_salaries ()
SELECT *
FROM employee_salary
WHERE salary >= 50000;

CALL large_salaries();


USE parks_and_recreation;

-- mozna tez je tworzyc klikajac po lewej stronie "Create stored procedures" sprzy tworzeniu i wywolywaniu 
-- dziala to jak funkcja w innych jezykach mozna w nawiasie wpisac zmienna
DELIMITER $$
USE parks_and_recreation $$
CREATE PROCEDURE large_salaries2 ()
BEGIN
SELECT *
FROM employee_salary
WHERE salary >= 50000;
SELECT *
FROM employee_salarynew_procedurenew_procedure
WHERE salary >= 10000;
END $$




