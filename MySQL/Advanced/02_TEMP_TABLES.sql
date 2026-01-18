-- TEMP TABLES
-- uzywamy do manipulowania danymi przed zapisywaniem do prawdziwej tabeli
-- dziala nawet w innym SQL pliku (dopoki nie zamkniemy calkowicie calej aplikacji) 


-- tworzenie tabeli
CREATE TEMPORARY TABLE temp_table
(
first_name varchar (50),
last_name varchar (50),
favourite_movie varchar (100)
);


SELECT *
FROM temp_table;

-- dodawanie danych do tabeli
INSERT INTO temp_table
VALUES('Jan','Zdaniewicz','Prestige');

-- Tworzenie tabeli z innej tabeli
CREATE TEMPORARY TABLE salary_over_50k
SELECT *
FROM employee_salary
WHERE salary >= 50000;

SELECT *
FROM salary_over_50k;
