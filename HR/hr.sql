-- 1

SELECT first_name, last_name, department_id, salary
FROM employees
WHERE salary > 5000;

-- 2

SELECT first_name, last_name, department_id, salary
FROM employees
WHERE salary > 8000 AND salary < 10000;

-- 3

SELECT last_name, phone_number, email
FROM employees e
JOIN jobs j ON e.job_id = j.job_id
where j.job_title = 'Programmer';

-- 4

SELECT last_name, phone_number
FROM employees e
JOIN departments d ON e.department_id = d.department_id
where d.department_name = 'Marketing';

-- 5

SELECT *
FROM locations l
JOIN countries c ON l.country_id = c.country_id
where c.country_name = 'Canada';

-- 6

SELECT country_name
FROM COUNTRIES C
JOIN REGIONS R ON R.REGION_ID = C.REGION_ID
WHERE R.REGION_NAME = 'Europe';

-- 7

SELECT e.last_name, d.departament_name
from employees e
join departments d on d.manager_id = e.employee_id;

