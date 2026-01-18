-- Case Statements to wiele ifów 

SELECT first_name,
last_name,
CASE
	WHEN age <= 30 THEN 'Young'
    WHEN age BETWEEN 31 and 50 THEN 'Old'
    WHEN age = 50 THEN "On Death's Door"
END AS Age_Bracket
FROM employee_demographics
;







SELECT first_name, last_name, salary,
CASE
    WHEN salary < 50000 THEN salary * 1.05
    WHEN salary > 50000 THEN salary * 1.07
END AS salary_after_bonus,
CASE
	WHEN dept_id = 6 THEN salary * .10
END AS bonus 
FROM employee_salary ;


SELECT *
FROM employee_salary; 









