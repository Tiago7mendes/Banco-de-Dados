--1. Consultar sobrenome e salário dos empregados cujo título do cargo é ‘Sales Representative’ ou
--‘Stock Clerk’;
SELECT last_name, salary
FROM employees e
JOIN jobs j ON e.job_id = j.job_id
WHERE j.job_title IN ('Sales Representative', 'Stock Clerk');

--2. Consultar os nomes dos países e os nomes das regiões onde estão localizados;
SELECT c.country_name, r.region_name
FROM countries c
JOIN regions r ON c.region_id = r.region_id;

--3. Consultar o nome do departamento e o sobrenome de seu gerente. Caso o departamento não
--tenha gerente, liste o nome do departamento e indique null para o gerente.
SELECT d.department_name, e.last_name AS gerente
FROM departments d
LEFT JOIN employees e ON d.manager_id = e.employee_id;

--4. Consultar primeiro nome e sobrenome dos empregados que trabalham em departamentos
--localizados em cidades cujo nome inicia-se com a letra S;
SELECT e.first_name, e.last_name
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN locations l ON d.location_id = l.location_id
WHERE l.city LIKE 'S%';

--5. Faça uma consulta para elaborar um relatório dos empregados e seus respectivos gerentes
--contendo sobrenome do empregado, id de seu cargo (job_id), sobrenome do seu gerente e id do
--cargo (job_id) do gerente. Caso o empregado não tenha gerente, exiba null como sobrenome do
--gerente.
SELECT e.last_name AS empregado, e.job_id AS emp_job, m.last_name AS gerente, m.job_id AS mgr_job
FROM employees e
LEFT JOIN employees m ON e.manager_id = m.employee_id;

--6. Liste o nome de todos os departamentos cadastrados e, caso tenha, exiba o nome e o sobrenome
--de seu gerente;
SELECT d.department_name, e.first_name AS gerente_nome, e.last_name AS gerente_sobrenome
FROM departments d
LEFT JOIN employees e ON d.manager_id = e.employee_id;

--7. Considerando o histórico de cargos (tabela JOB_HISTORY), consulte sobrenome do
--empregado, id de cargo (job_id), data de início e data de encerramento registrados no histórico,
--considerando todos empregados cadastrados, incluindo também aqueles que não possuem
--registro no histórico de cargos.
SELECT e.last_name, jh.job_id, jh.start_date, jh.end_date
FROM employees e
LEFT JOIN job_history jh ON e.employee_id = jh.employee_id;