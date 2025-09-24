create table Funcionario_func(
    cod_func int,
    nome varchar(20),
    salario number(10,2));
    
-- Atribuir ao usuario2 os privilégios de:

--◦ inserir tuplas na tabela funcionario de usuario1
GRANT INSERT ON usuario1.funcionario TO usuario2;

--◦ atualizar salario da tabela funcionario de usuario1
GRANT UPDATE ( salario ) ON usuario1.funcionario TO usuario2;