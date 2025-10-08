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

-- Insira 2 contas com saldos diferentes.

-- Inicie uma transação (BEGIN TRANSACTION).

-- Transfira R$100 da conta 1 para a conta 2 usando UPDATE.

-- Use ROLLBACK e verifique se as alterações foram desfeitas.
-- Repita a operação e finalize com COMMIT.

-- Explique a diferença entre COMMIT e ROLLBACK.
-- Rollback esta inserido para cancelar mudancas feitas e cancelando o passo de alteracao para o resultado final.
-- Commit e um comando para salvar as mudancas feitas em uma banco.

-- O que é o conceito de ACID e por que é importante?
-- Atomicidade, Consistência, Isolamento e Durabilidade.
-- Garante integridade e confiabilidade dos dados, Evita perda de dados ou inconsistência em operações críticas e é essencial para sistemas financeiros, e-commerce, ERPs, e qualquer aplicação que manipule informações importantes.

-- 🔹 4. Revisão de SELECT

-- Faça um SELECT com alias de colunas e de tabela.

-- Liste os 3 primeiros registros usando FETCH FIRST.

-- Ordene por nome em ordem decrescente.

-- Selecione apenas produtos com preço maior que 100.

-- Utilize DISTINCT para eliminar valores repetidos.

-- Use BETWEEN, IN, LIKE e IS NULL em consultas separadas.

-- Faça um SELECT aninhado (subconsulta no WHERE).

-- Utilize uma função de agregação (COUNT, AVG, MAX, SUM).

-- 🔹 5. Sequências (SEQUENCE)

-- Crie uma sequência chamada SEQ_CLIENTE começando em 1 e incrementando de 1.

-- Use a sequência para inserir novos registros em uma tabela CLIENTE.

-- Exiba o valor atual e o próximo da sequência (CURRVAL, NEXTVAL).

-- Explique o que acontece se uma sequência for usada em transações com ROLLBACK.

-- 🔹 6. Subconsultas

-- Liste todos os produtos cujo preço é maior que a média dos preços.

-- Liste clientes que não fizeram pedidos (NOT IN).

-- Liste os produtos que aparecem em pelo menos um pedido (EXISTS).

-- Compare o resultado de uma subconsulta correlacionada e não correlacionada.

-- 🔹 7. Usuários e Privilégios

-- Crie um novo usuário chamado teste_user com senha 1234.

-- Conceda a ele o privilégio de criar sessões e selecionar na tabela PRODUTOS.

-- Revogue o privilégio de seleção.

-- Explique a diferença entre GRANT e REVOKE.

-- O que são privilégios de sistema e privilégios de objeto?

-- Qual a diferença entre papel (ROLE) e usuário (USER)?

-- 🔹 8. Visões (VIEWS)

-- Crie uma view chamada VW_CLIENTES_ATIVOS que exibe apenas clientes com status = 'Ativo'.

-- Faça um SELECT na view.

-- Tente fazer um UPDATE na view e explique o resultado.

-- Crie uma view com junção entre CLIENTES e PEDIDOS.

-- Crie uma view com alias de colunas.

-- Explique a diferença entre view simples e view complexa.

-- Explique o que acontece se a tabela base de uma view for removida.