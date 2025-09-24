select * from dba_users;
select * from dba_ts_quotas;

alter session set "_ORACLE_SCRIPT" = TRUE;

create user usuario1
identified by usuario1
DEFAULT TABLESPACE USERS
TEMPORARY TABLESPACE TEMP;

create user usuario2
identified by usuario2
DEFAULT TABLESPACE USERS
TEMPORARY TABLESPACE TEMP;

ALTER USER usuario1 QUOTA 5M ON USERS;
ALTER USER usuario2 QUOTA 5M ON USERS;

-- Atribua ao usuário usuario1 os privilégios para
--criar sessões e tabelas

grant create session, create table to usuario1;

-- Criar um role chamado admin1 que contenha
--privilégios para criar sessões, tabelas, views,
--sequences e procedures

--Atribuir o role admin1 para o usuário usuario2
--Faça o teste de conexão
--Crie a tabela Emp (emp_id, nome, salario)

create role admin1;

grant create table, create view,create sequence, create procedure ,create session to admin1;

GRANT admin1 TO usuario2;