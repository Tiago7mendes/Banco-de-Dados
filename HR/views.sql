-- 1. Criar uma view EMP_ST_CLERK que contenha dados dos empregados com função ‘ST_CLERK’
-- Colunas: employee_id, last_name, email, hire_date, job_id

CREATE VIEW EMP_ST_CLERK AS 
SELECT employee_id, last_name, email, hire_date, job_id
FROM employees
WHERE job_id = 'ST_CLERK';

-- 2. Criar (ou alterar) a view de modo que não seja possível alterar seu conteúdo com funções de empregado diferentes de ‘ST_CLERK’

CREATE OR REPLACE VIEW EMP_ST_CLERK AS 
SELECT employee_id, last_name, email, hire_date, job_id
FROM employees
WHERE job_id = 'ST_CLERK'
WITH CHECK OPTION;

-- 3. Adicione um novo empregado na view EMP_ST_CLERK, com a função ‘ST_CLERK’

insert into EMP_ST_CLERK values
(277, 'Cris', 'cris@email.com', sysdate, 'ST_CLERK', 50);

-- 4. Explique o que aconteceu na tabela Employees

-- Foi adicionado com sucesso na tabela Employees!

-- 5. Atualize EMP_ST_CLERK de modo que o empregado adicionado tenha a função ‘IT_PROG’

insert into EMP_ST_CLERK values
(278, 'Cris', 'cris@email.com', sysdate, 'IT_PROG', 50);

-- 6. Explique o que aconteceu

-- Deu erro pois, nao é possivel adicionar alguem com job_id 'IT_PROG'

-- 7. Remova da view o empregado adicionado anteriormente

delete from EMP_ST_CLERK
where employee_id = 278;

--8. Explique o que aconteceu na tabela Employees

-- Não excluiu na tabela, ele ainda continua

--9. Criar uma visão DEPT_MAN_VIEW que contenha dados dos gerentes de departamento
--Colunas: nome do gerente, título de sua função, salário anual, nome do departamento,
--cidade

create view DEPT_MAN_VIEW AS
    select  e.first_name || ' ' || e.last_name AS manager_name,
    j.job_title,
    e.salary * 12 AS annual_salary,
    d.department_name,
    loc.city
    FROM departments d
    JOIN employees e ON d.manager_id = e.employee_id
    JOIN jobs j ON e.job_id = j.job_id
    JOIN locations loc ON d.location_id = loc.location_id;

--10. É possível atualizar DEPT_MAN_VIEW? Justifique.

-- Não pois tem join, e nao é possivel alterar quando esses operadores complexos 

--11. Criar uma visão DEPT_JOB_VIEW que contenha uma relação da quantidade de empregados
--por função e por nome de departamento
--Colunas: nome do departamento, nome da função, quantidade de empregados que
--exercem a função no referido departamento

CREATE OR REPLACE VIEW dept_job_view AS
    SELECT d.department_name, j.job_title, COUNT(e.employee_id) AS num_employees
    FROM employees e
    JOIN departments d ON e.department_id = d.department_id
    JOIN jobs j ON e.job_id = j.job_id
    GROUP BY d.department_name, j.job_title;

--12. É possível atualizar DEPT_JOB_VIEW? Justifique

-- Não é possivel pois utiliza join e group by!