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