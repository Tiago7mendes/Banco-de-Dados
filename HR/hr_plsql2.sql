SET SERVEROUTPUT ON;

DECLARE
    h_date employees.hire_date%TYPE;
    emp_id employees.employee_id%TYPE := '&input;
    emp_years NUMBER;
BEGIN
    SELECT hire_date INTO h_date FROM employees
    WHERE employee_id = emp_id;
    emp_years := MONTHS_BETWEEN(SYSDATE, h_date)/12;
    IF emp_years > 10 THEN
        DBMS_OUTPUT.PUT_LINE ('Empregado '|| emp_id || ' é sênior');
    ELSIF emp_years > 5 THEN
        DBMS_OUTPUT.PUT_LINE ('Empregado '|| emp_id || ' é pleno');
    ELSE
        DBMS_OUTPUT.PUT_LINE ('Empregado '|| emp_id || ' é júnior');
    END IF;
END;
/

DECLARE
    jobid    employees.job_id%TYPE;
    empid    employees.employee_id%TYPE := 115;
    reajuste NUMBER(3, 2);
BEGIN
    SELECT
        job_id
    INTO jobid
    FROM
        employees
    WHERE
        employee_id = empid;

    IF jobid = 'PU_CLERK' THEN
        reajuste :=.12;
    ELSIF jobid = 'SH_CLERK' THEN
        reajuste :=.11;
    ELSIF jobid = 'ST_CLERK' THEN
        reajuste :=.10;
    ELSE
        reajuste :=.05;
    END IF;

    UPDATE employees
    SET
        salary = salary + salary * reajuste
    WHERE
        employee_id = empid;

END;
/

DECLARE
    nota      CHAR(1) := upper('&nota');
    resultado VARCHAR2(20);
BEGIN
    resultado :=
        CASE
            WHEN nota = 'A' THEN
                'Excelente'
            WHEN nota = 'B' THEN
                'Muito bom'
            WHEN nota = 'C' THEN
                'Bom'
            WHEN nota IN ( 'D', 'E' ) THEN
                'Reprovado'
            ELSE 'Nota inválida'
        END;

    dbms_output.put_line('Nota: '
                         || nota
                         || '
Resultado: '
                         || resultado);
END;
/

DECLARE
    jobid    employees.job_id%TYPE;
    empid    employees.employee_id%TYPE := 115;
    reajuste NUMBER(3, 2);
BEGIN
    SELECT
        job_id
    INTO jobid
    FROM
        employees
    WHERE
        employee_id = empid;

    CASE
        WHEN jobid = 'PU_CLERK' THEN
            reajuste :=.12;
        WHEN jobid = 'SH_CLERK' THEN
            reajuste :=.11;
        WHEN jobid = 'ST_CLERK' THEN
            reajuste :=.10;
        ELSE
            reajuste :=.05;
    END CASE;

    UPDATE employees
    SET
        salary = salary + salary * reajuste
    WHERE
        employee_id = empid;

END;
/

DECLARE
ctry_id locations.country_id%TYPE := 'BR';
loc_id locations.location_id%TYPE;
counter NUMBER(2) := 1;
cty locations.city%TYPE := 'Araraquara';
BEGIN
SELECT MAX(location_id) INTO loc_id FROM locations
WHERE country_id = ctry_id;
LOOP
INSERT INTO locations(location_id, city, country_id)
VALUES((loc_id + counter), cty, ctry_id);
counter := counter + 1;
EXIT WHEN counter > 3;
END LOOP;
END;
/

DECLARE
ctry_id locations.country_id%TYPE := 'BR';
loc_id locations.location_id%TYPE;
counter NUMBER(2) := 1;
cty locations.city%TYPE := 'Araraquara';
BEGIN
SELECT MAX(location_id) INTO loc_id FROM locations
WHERE country_id = ctry_id;
WHILE counter <= 3 LOOP
INSERT INTO locations(location_id, city, country_id)
VALUES((loc_id + counter), cty, ctry_id);
counter := counter + 1;
END LOOP;
END;
/

DECLARE
ctry_id locations.country_id%TYPE := 'BR';
loc_id locations.location_id%TYPE;
BEGIN
SELECT MAX(location_id) INTO loc_id FROM locations
WHERE country_id = ctry_id;
FOR i IN 0..5 LOOP
DELETE FROM locations
WHERE location_id = (loc_id - i);
END LOOP;
END;
/

BEGIN
<<outer_loop>>
FOR i IN 1..3 LOOP -- assign the values 1,2,3 to i
<<inner_loop>>
FOR i IN 1..3 LOOP
IF outer_loop.i = 2 THEN
DBMS_OUTPUT.PUT_LINE( 'outer: ' ||
TO_CHAR(outer_loop.i) || ' inner: ' ||
TO_CHAR(inner_loop.i));
END IF;
END LOOP inner_loop;
END LOOP outer_loop;
END;
/