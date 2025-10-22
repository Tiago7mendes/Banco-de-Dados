SET SERVEROUTPUT ON
DECLARE
sobrenome VARCHAR2(20);
BEGIN
SELECT last_name INTO sobrenome
FROM EMPLOYEES
WHERE employee_id = 100;
DBMS_OUTPUT.PUT_LINE('O sobrenome do empregado
é ' || sobrenome);
END;

DECLARE
min_sal employees.salary%TYPE;
max_sal min_sal%TYPE;
deptno employees.department_id%TYPE := 60;
BEGIN
SELECT MIN(salary), MAX(salary)
INTO min_sal, max_sal
FROM employees
WHERE department_id = deptno;
DBMS_OUTPUT.PUT_LINE ('O menor salário do
departamento ' || deptno || ' é ' ||
min_sal || ' e o maior salário é ' || max_sal);
END;
