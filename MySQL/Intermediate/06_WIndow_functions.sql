-- Window Functions


SELECT dem.first_name, dem.last_name, gender, AVG(salary) AS avg_salary
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id
GROUP BY gender, first_name, last_name;




-- WINDOW functions are not affecting the different rows
SELECT dem.first_name, dem.last_name, gender, salary, 
SUM(salary) OVER(PARTITION BY gender) AS sum_salary
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id;

-- Dzieki temu widzisz kalkulacje jak dodawanie na kartece
SELECT dem.first_name, dem.last_name, gender, salary,
SUM(salary) OVER(PARTITION BY gender ORDER BY dem.employee_id) AS Rolling_Total
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id ;

-- RANK Jesli jest powtorka np 2 osoby maja 2gie miejsce to nastepne miejsce bedzie mialo wartosc 4, dense dziala tak ze bedzie miejsce 3 i dwa drugie
SELECT dem.employee_id,dem.first_name, dem.last_name, gender, salary,
ROW_NUMBER() OVER(PARTITION BY gender ORDER BY salary DESC) AS row_num,
RANK() OVER(PARTITION BY gender ORDER BY salary DESC) AS rank_num,
DENSE_RANK() OVER(PARTITION BY gender ORDER BY salary DESC) AS dense_num
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id ;
