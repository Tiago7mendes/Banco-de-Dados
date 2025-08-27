-- 1. Consultar o primeiro nome, sobrenome e data de contratação dos empregados que trabalham no mesmo
--departamento que o empregado com sobrenome Zlotkey (excluindo ele próprio).

select e.first_name, e.last_name, e.hire_date
from employees e
where department_id = (select department_id
    from employees
    where last_name = 'Zlotkey')
and e.last_name <> 'Zlotkey';

-- 2. Consultar o primeiro nome, sobrenome e data de contratação dos empregados que foram contratados depois do
--empregado com sobrenome Davies.

select e.first_name, e.last_name, e.hire_date
from employees e
where hire_date > (select hire_date
    from employees
    where last_name = 'Davies')
;
