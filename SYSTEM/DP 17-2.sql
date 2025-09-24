-- DP 17-2: Criando e Revogando Privilégios de Objeto

-- 1. O que é uma atribuição?

--É um agrupamento de privilégios que pode ser atribuído a usuários, facilitando a administração de permissões (uma role).

-- 2. Quais são as vantagens de uma atribuição para um DBA?

--Facilita a gestão de privilégios, permite atribuir vários privilégios de uma vez.
--Se precisar mudar, basta alterar a role e todos os usuários que a possuem já são atualizados.

-- 3. Permita que outro usuário examine sua tabela e que ele também possa conceder esse direito a outros.

GRANT SELECT ON tabela TO user1 WITH GRANT OPTION;

-- 4. Você é o DBA e precisa dar os mesmos privilégios a vários usuários. O que usar?

--Criar uma atribuição e conceder os privilégios a ela.

--5. Sintaxes:
--a) Criar uma atribuição de gerente com privilégios totais na tabela employees:

CREATE ROLE gerente;
GRANT SELECT, INSERT, UPDATE, DELETE ON employees TO gerente;

--b) Criar uma atribuição de funcionário com privilégios de SELECT e INSERT:

CREATE ROLE funcionario;
GRANT SELECT, INSERT ON employees TO funcionario;

--c) Conceder a atribuição de gerente ao usuário scott:

GRANT gerente TO scott;

--d) Revogar da atribuição de gerente a capacidade de excluir informações:

REVOKE DELETE ON employees FROM gerente;

-- 6. Qual é a finalidade de um link de banco de dados?

--Um database link permite que um usuário em um banco Oracle acesse objetos em outro banco Oracle remoto como se fossem locais.