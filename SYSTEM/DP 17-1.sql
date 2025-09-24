-- 1. Para que servem os privilégios de sistema?

--São usados para permitir a um usuário executar operações administrativas no banco, como criar tabelas, criar usuários, criar views, criar sinônimos etc.

-- 2. Para que servem os privilégios de objeto?

--Permitem a um usuário executar operações em objetos específicos de outro usuário, como selecionar (SELECT), inserir (INSERT), atualizar (UPDATE) ou excluir (DELETE) dados em uma tabela.

-- 3. Qual é o outro nome dado à segurança de objetos?

--Segurança discreta (ou de objeto).

-- 4. Quais comandos são necessários para permitir o acesso de Scott ao banco de dados com a senha tiger?

CREATE USER scott  BY tiger;
GRANT CREATE SESSION TO scott;

-- 5. Quais são os comandos usados para permitir que Scott faça uma seleção na tabela d_clients e atualize essa tabela?

GRANT SELECT, UPDATE ON d_clients TO scott;

-- 6. Qual é o comando usado para permitir que todos exibam a tabela d_songs?

GRANT SELECT ON d_songs TO PUBLIC;

-- 7. Consulte o dicionário de dados para exibir os privilégios de objeto concedidos a você.

SELECT * FROM user_tab_privs;

-- 8. Qual privilégio deve ser concedido a um usuário para que ele crie tabelas?

GRANT CREATE TABLE TO nome_usuario;

-- 9. Se você criar uma tabela, como poderá transferir privilégios para que outros usuários apenas exibam a sua tabela?

GRANT SELECT ON minha_tabela TO outro_usuario;

-- 10. Qual sintaxe você usaria para conceder a outro usuário acesso à sua tabela copy_employees?

GRANT SELECT, INSERT, UPDATE, DELETE ON copy_employees TO outro_usuario;

-- 11. Como você pode saber quais privilégios foram concedidos para as colunas das tabelas pertencentes a outros usuários?

SELECT * FROM ALL_COL_PRIVS;