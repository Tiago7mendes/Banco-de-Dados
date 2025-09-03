-- 1. Consultar o primeiro nome, sobrenome e data de contratação dos empregados que trabalham no mesmo
--departamento que o empregado com sobrenome Zlotkey (excluindo ele próprio).

SELECT first_name, last_name, hire_date
FROM employees
WHERE department_id = (
    SELECT department_id 
    FROM employees 
    WHERE last_name = 'Zlotkey'
)
AND last_name <> 'Zlotkey';

-- 2. Consultar o primeiro nome, sobrenome e data de contratação dos empregados que foram contratados depois do
--empregado com sobrenome Davies.

SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date > (
    SELECT hire_date
    FROM employees
    WHERE last_name = 'Davies'
);

-- 3. Consultar os sobrenomes dos empregados que são gerentes de departamento.

SELECT last_name
FROM employees
WHERE employee_id IN (
    SELECT manager_id
    FROM departments
    WHERE manager_id IS NOT NULL
);

-- 4. Consultar o sobrenome e o id do cargo dos empregados que não trabalham em departamentos que contêm a
--palavra ‘sales’ no nome do departamento.

SELECT last_name, job_id
FROM employees
WHERE department_id NOT IN (
    SELECT department_id
    FROM departments
    WHERE LOWER(department_name) LIKE '%sales%'
);

-- 5. Consultar o sobrenome e o salário dos empregados cujo salário é menor que o salário de algum empregado com id
--de cargo ‘ST_MAN’.

SELECT last_name, salary
FROM employees
WHERE salary < ANY (
    SELECT salary
    FROM employees
    WHERE job_id = 'ST_MAN'
);

-- 6. Consultar o sobrenome e o salário dos empregados cujo salário é maior que o salário de todos os empregados do
--departamento com id = 50.

SELECT last_name, salary
FROM employees
WHERE salary > ALL (
    SELECT salary
    FROM employees
    WHERE department_id = 50
);

-- 7. Consultar o primeiro nome, sobrenome e salário dos empregados que possuem o mesmo cargo que o empregado
--com sobrenome Zlotkey e ganham salário maior que ele.

SELECT first_name, last_name, salary
FROM employees
WHERE job_id = (
    SELECT job_id
    FROM employees
    WHERE last_name = 'Zlotkey'
)
AND salary > (
    SELECT salary
    FROM employees
    WHERE last_name = 'Zlotkey'
);

-- 8. Consultar id de países que possuem departamentos da empresa (usar EXISTS).

SELECT country_id
FROM countries c
WHERE EXISTS (
    SELECT 1
    FROM locations l
    JOIN departments d ON l.location_id = d.location_id
    WHERE l.country_id = c.country_id
);

-- 9. Quais são os nomes dos departamentos que estão na cidade Seattle? 

SELECT department_name
FROM departments d
JOIN locations l ON d.location_id = l.location_id
WHERE l.city = 'Seattle';

-- 10. Crie uma consulta para retornar todos os funcionários que têm um salário superior ao de Lorentz e que sejam do
--mesmo departamento que Abel.

SELECT first_name, last_name, salary
FROM employees
WHERE salary > (
    SELECT salary
    FROM employees
    WHERE last_name = 'Lorentz'
)
AND department_id = (
    SELECT department_id
    FROM employees
    WHERE last_name = 'Abel'
);

-- 11. Crie uma consulta para retornar todos os funcionários que têm o mesmo id de cargo que Rajs e que foram
--contratados depois de Davies. 

SELECT first_name, last_name, hire_date
FROM employees
WHERE job_id = (
    SELECT job_id
    FROM employees
    WHERE last_name = 'Rajs'
)
AND hire_date > (
    SELECT hire_date
    FROM employees
    WHERE last_name = 'Davies'
);

-- 12. Retorne o ID de departamento e o salário mínimo de todos os funcionários, agrupados por ID de departamento,
--que têm um salário mínimo superior aos daqueles cujo ID de departamento é diferente de 50.

SELECT e.department_id, min_salaries.min_salary
FROM (
    SELECT department_id, MIN(salary) AS min_salary
    FROM employees
    GROUP BY department_id
) min_salaries
JOIN employees e ON e.department_id = min_salaries.department_id
WHERE min_salaries.min_salary > (
    SELECT MIN(salary)
    FROM employees
    WHERE department_id <> 50
)
GROUP BY e.department_id, min_salaries.min_salary;

-- 13. Encontre os sobrenomes de todos os funcionários cujos salários são iguais ao salário mínimo de qualquer
--departamento.

SELECT last_name, salary
FROM employees
WHERE salary IN (
    SELECT MIN(salary)
    FROM employees
    GROUP BY department_id
);

-- 14. Quais funcionários têm salários inferiores aos dos programadores do departamento de TI?

SELECT last_name, salary -- esse eu nao consegui testar pois, o oracle online estava em manutencao (03/09)
FROM employees
WHERE salary < ANY (
    SELECT salary
    FROM employees
    WHERE job_id LIKE '%PROG%'
);

-- 15. Liste last_name, first_name, department_id e manager_id de todos os funcionários que têm o mesmo
--department_id e manager_id que o funcionário 141. Exclua o funcionário 141 do conjunto de resultados.

SELECT last_name, first_name, department_id, manager_id
FROM employees
WHERE department_id = (
    SELECT department_id
    FROM employees
    WHERE employee_id = 141
)
AND manager_id = (
    SELECT manager_id
    FROM employees
    WHERE employee_id = 141
)
AND employee_id <> 141;