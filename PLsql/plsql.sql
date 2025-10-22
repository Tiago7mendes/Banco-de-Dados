SET SERVEROUTPUT ON;
DECLARE
    msg VARCHAR2(100) := 'Hello World';
BEGIN
    DBMS_OUTPUT.PUT_LINE(msg);
END;
/ -- indica executa

DECLARE
MSG VARCHAR2(100);
BEGIN
MSG := '&INPUT';
DBMS_OUTPUT.PUT_LINE('HELLO '||
MSG);
END;
/
--Escreva um bloco de programa PL/SQL para atualizar o salário dos empregados dodepartamento com id = 50 para o mesmo
-- valor do salário médio dos empregados do departamento com id = 60.

DECLARE
avg_sal HR.employees.salary%TYPE;
BEGIN
SELECT AVG(salary)
INTO avg_sal
FROM HR.employees
WHERE department_id = 60;
UPDATE HR.employees
SET SALARY = avg_sal
WHERE department_id = 50;
END;
/