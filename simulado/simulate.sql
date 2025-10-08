-- // 🧾 LISTA DE EXERCÍCIOS – Revisão para Prova de Database \\ --

-- 🔹 0. Criacao do Usuario Simulado

ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE;

CREATE USER simulado IDENTIFIED BY simulado;

ALTER USER simulado QUOTA UNLIMITED ON users;

GRANT CREATE SESSION TO simulado;
GRANT CREATE TABLE TO simulado;
GRANT CREATE VIEW TO simulado;
GRANT CREATE SEQUENCE TO simulado;
GRANT CREATE SYNONYM TO simulado;

ALTER USER simulado
DEFAULT TABLESPACE users
TEMPORARY TABLESPACE temp;

-- 🔹 1. Índices e Sinônimos

-- Crie uma tabela chamada PRODUTOS com as colunas ID, NOME, PRECO e ESTOQUE.

CREATE TABLE PRODUTOS (
    ID NUMBER PRIMARY KEY,
    NOME VARCHAR2(30),
    PRECO NUMBER(10,2),
    ESTOQUE NUMBER
);

-- Insira 5 registros de exemplo.

INSERT INTO PRODUTOS VALUES (1, 'Arroz', 28.99, 100);
INSERT INTO PRODUTOS VALUES (2, 'Feijao', 15.99, 80);
INSERT INTO PRODUTOS VALUES (3, 'Carne', 89.99, 50);
INSERT INTO PRODUTOS VALUES (4, 'Ovo', 19.99, 60);
INSERT INTO PRODUTOS VALUES (5, 'Frango', 29.99, 70);

-- Crie um índice não exclusivo sobre a coluna NOME.

-- Crie um índice exclusivo sobre a coluna ID.

-- Verifique os índices existentes com o comando apropriado (USER_INDEXES).

-- Crie um sinônimo chamado ITENS que aponte para PRODUTOS.

CREATE SYNONYM ITEMS FOR PRODUTOS;

-- Execute um SELECT usando o sinônimo em vez do nome original da tabela.

SELECT * FROM ITENS;

-- Explique a diferença entre um sinônimo público e um sinônimo privado.
-- Sinonimo publico tem a visibilidade para todos os usuarios que tenham a permissao, ja o privado e exclusivamente do usario ou esquema.

-- 🔹 2. Junção (JOIN)

-- Crie as tabelas CLIENTES(id, nome, cidade_id) e CIDADES(id, nome).

CREATE TABLE CLIENTES (
    ID INTEGER PRIMARY KEY,
    NOME VARCHAR2(30),
    CIDADE_ID INTEGER,
    FOREIGN KEY (CIDADE_ID) REFERENCES CIDADES(ID)
);

CREATE TABLE CIDADES (
    ID INTEGER PRIMARY KEY,
    NOME VARCHAR(30)
);

-- Insira dados em ambas.

INSERT INTO CIDADES (ID, NOME) VALUES (1, 'São Paulo');
INSERT INTO CIDADES (ID, NOME) VALUES (2, 'Rio de Janeiro');
INSERT INTO CIDADES (ID, NOME) VALUES (3, 'Belo Horizonte');

INSERT INTO CLIENTES (ID, NOME, CIDADE_ID) VALUES (1, 'Victor', 1);
INSERT INTO CLIENTES (ID, NOME, CIDADE_ID) VALUES (2, 'Luiz', 2);
INSERT INTO CLIENTES (ID, NOME, CIDADE_ID) VALUES (3, 'Tiago', 3);

-- Faça um INNER JOIN para listar o nome do cliente e o nome da cidade.

SELECT cl.cidade_id as cidades, cd.id as clientes
FROM cidades cd
INNER JOIN clientes cl ON cl.cidade_id = cd.id;

-- Faça um LEFT JOIN para listar todos os clientes, mesmo sem cidade cadastrada.

-- Faça um RIGHT JOIN para listar todas as cidades, mesmo sem clientes.

-- Faça um SELF JOIN (ex.: funcionários e seus gerentes).

-- Faça um CROSS JOIN entre CLIENTES e CIDADES.

-- Explique o que aconteceria se o critério de junção fosse omitido.

-- 🔹 3. Processamento de Transações

-- Crie uma tabela CONTA(id, titular, saldo).

CREATE TABLE conta (
    id NUMBER PRIMARY KEY,
    titular VARCHAR2(50),
    saldo NUMBER(10,2)
);

-- Insira 2 contas com saldos diferentes.

INSERT INTO conta VALUES (1, 'Tiago', 1000);
INSERT INTO conta VALUES (2, 'Victor', 500);

-- Transfira R$100 da conta 1 para a conta 2 usando UPDATE.

UPDATE conta SET saldo = saldo - 100 WHERE id = 1;
UPDATE conta SET saldo = saldo + 100 WHERE id = 2;

-- Use ROLLBACK e verifique se as alterações foram desfeitas.
ROLLBACK; -- os saldos voltam a ser 1000 e 500

-- Repita a operação e finalize com COMMIT.
UPDATE conta SET saldo = saldo - 100 WHERE id = 1;
UPDATE conta SET saldo = saldo + 100 WHERE id = 2;
COMMIT;

-- Explique a diferença entre COMMIT e ROLLBACK.
-- Rollback : Cancela as mudanças não confirmadas; retorna ao estado anterior.
-- Commit : Confirma as mudanças feitas; torna-as permanentes no banco.

-- O que é o conceito de ACID e por que é importante?
-- Atomicidade, Consistência, Isolamento e Durabilidade.
-- Garante integridade e confiabilidade dos dados, Evita perda de dados ou inconsistência em operações críticas e é essencial para sistemas financeiros, e-commerce, ERPs, e qualquer aplicação que manipule informações importantes.

-- 🔹 4. Revisão de SELECT

-- Faça um SELECT com alias de colunas e de tabela.

SELECT c.id AS codigo, c.titular AS nome, c.saldo AS saldo_atual
FROM conta c;

-- Liste os 3 primeiros registros usando FETCH FIRST.

SELECT * FROM conta
FETCH FIRST 3 ROWS ONLY;

-- Ordene por nome em ordem decrescente.

SELECT * FROM conta
ORDER BY titular DESC;

-- Selecione apenas produtos com preço maior que 100.

SELECT * FROM produtos
WHERE preco > 100;

-- Utilize DISTINCT para eliminar valores repetidos.

SELECT DISTINCT categoria
FROM produtos;

-- Use BETWEEN, IN, LIKE e IS NULL em consultas separadas.

-- BETWEEN
SELECT * FROM produtos WHERE preco BETWEEN 100 AND 500;

-- IN
SELECT * FROM produtos WHERE categoria IN ('Eletrônicos', 'Roupas');

-- LIKE
SELECT * FROM produtos WHERE nome LIKE 'S%';  -- começa com S

-- IS NULL
SELECT * FROM produtos WHERE desconto IS NULL;

-- Faça um SELECT aninhado (subconsulta no WHERE).

SELECT nome, preco
FROM produtos
WHERE preco > (SELECT AVG(preco) FROM produtos);

-- Utilize uma função de agregação (COUNT, AVG, MAX, SUM).

SELECT COUNT(*) AS total_produtos,
       AVG(preco) AS media_preco,
       MAX(preco) AS maior_preco,
       SUM(preco) AS soma_precos
FROM produtos;

-- 🔹 5. Sequências (SEQUENCE)

-- Crie uma sequência chamada SEQ_CLIENTE começando em 1 e incrementando de 1.

CREATE SEQUENCE seq_cliente
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

-- Use a sequência para inserir novos registros em uma tabela CLIENTE.

INSERT INTO clientes (id, nome, cidade_id)
VALUES (seq_cliente.NEXTVAL, 'Tiago Setti', 1);

INSERT INTO clientes (id, nome, cidade_id)
VALUES (seq_cliente.NEXTVAL, 'Victor Rodrigues', 2);

-- Exiba o valor atual e o próximo da sequência (CURRVAL, NEXTVAL).

SELECT seq_cliente.CURRVAL AS valor_atual FROM dual;
SELECT seq_cliente.NEXTVAL AS proximo_valor FROM dual;

-- Explique o que acontece se uma sequência for usada em transações com ROLLBACK.
-- Ela não volta atrás, o cliente não vai ser salvo e o número da sequencia foi consumido
-- O valor da sequência continua avançado, mesmo se a transação for desfeita.

-- 🔹 6. Subconsultas

-- Liste todos os produtos cujo preço é maior que a média dos preços.

SELECT nome, preco
FROM produtos
WHERE preco > (SELECT AVG(preco) FROM produtos);

-- Liste clientes que não fizeram pedidos (NOT IN).

SELECT nome
FROM clientes
WHERE id NOT IN (
    SELECT cliente_id
    FROM pedidos
);

-- Liste os produtos que aparecem em pelo menos um pedido (EXISTS).

SELECT nome
FROM produtos p
WHERE EXISTS (
    SELECT 1
    FROM pedidos_itens i
    WHERE i.produto_id = p.id
);

-- Compare o resultado de uma subconsulta correlacionada e não correlacionada.
-- Não Correlacionada
SELECT * 
FROM produtos 
WHERE preco > (SELECT AVG(preco) FROM produtos);
-- A subconsulta roda uma única vez, independente da linha da consulta principal.

-- Correlacionada
SELECT nome 
FROM produtos p 
WHERE preco > (
    SELECT AVG(preco) 
    FROM produtos 
    WHERE categoria_id = p.categoria_id
);
-- A subconsulta roda para cada linha, usando valores da consulta principal (p.categoria_id).

-- 🔹 7. Usuários e Privilégios

-- Crie um novo usuário chamado teste_user com senha 1234.

-- Conceda a ele o privilégio de criar sessões e selecionar na tabela PRODUTOS.

-- Revogue o privilégio de seleção.

-- Explique a diferença entre GRANT e REVOKE.
-- GRANT dá permissão e REVOKE tira permissão

-- O que são privilégios de sistema e privilégios de objeto?
-- Privilégios de objeto permitem acessar e manipular objetos (tabelas, views, etc -> select, insert, update, delete).
-- Privilégios de sistema executam ações mais gerais do banco (create table, create user, alter session...)

-- Qual a diferença entre papel (ROLE) e usuário (USER)?
-- Role é o conjunto de privilégios (gerente), já o user é a conta individual, quem acessa o banco.

-- 🔹 8. Visões (VIEWS)

-- Crie uma view chamada VW_CLIENTES_ATIVOS que exibe apenas clientes com status = 'Ativo'.

ALTER TABLE clientes ADD status VARCHAR2(10); -- para adicionar status
UPDATE clientes SET status = 'Ativo' WHERE id = 1;
UPDATE clientes SET status = 'Inativo' WHERE id = 2;
COMMIT;

CREATE VIEW vw_clientes_ativos AS
SELECT id, nome, cidade_id
FROM clientes
WHERE status = 'Ativo';

-- Faça um SELECT na view.

SELECT * FROM vw_clientes_ativos;

-- Tente fazer um UPDATE na view e explique o resultado.

UPDATE vw_clientes_ativos
SET nome = 'Cliente Atualizado'
WHERE id = 1;

-- Crie uma view com junção entre CLIENTES e PEDIDOS.

CREATE VIEW vw_clientes_pedidos AS
SELECT c.id AS cliente_id,
       c.nome AS cliente_nome,
       p.id AS pedido_id,
       p.data_pedido,
       p.valor_total
FROM clientes c
JOIN pedidos p ON c.id = p.cliente_id;

-- Crie uma view com alias de colunas.

CREATE VIEW vw_clientes_alias (codigo, nome_cliente, cidade)
AS
SELECT id, nome, cidade_id
FROM clientes;

-- Explique a diferença entre view simples e view complexa.
-- simples é sem join e group by, e com isso da para fazer update, a complexa é ao contrário e não consegue fazer update.

-- Explique o que acontece se a tabela base de uma view for removida.
-- fica inválida