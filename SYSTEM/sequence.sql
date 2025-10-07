-- Exercicios

--1. Usando a sintaxe da subconsulta CREATE TABLE AS, crie uma tabela seq_d_songs com todas 
--as colunas da tabela d_songs da DJs on Demand. Use a instrução SELECT * na subconsulta 
--para verificar se todas as colunas foram copiadas.

CREATE TABLE seq_d_songs AS
SELECT * FROM d_songs;

--2. Como você está usando cópias das tabelas originais, as únicas constraints que foram herdadas foram as constraints NOT NULL. Crie uma sequência para ser usada com a coluna de chave 
--primária da tabela seq_d_songs. Para evitar a designação de números de chave primária já existentes a essas tabelas,
--a sequência deverá iniciar em 100 e ter o valor máximo de 1000. 
--Incremente a sua sequência em 2 e use NOCACHE e NOCYCLE. Nomeie a sequência como seq_d_songs_seq. 

CREATE SEQUENCE seq_d_songs_seq
START WITH 100
INCREMENT BY 2
MAXVALUE 1000
NOCACHE
NOCYCLE;

--3. Consulte o dicionário de dados USER_SEQUENCES para verificar as configurações da sequência seq_d_songs_seq. 

SELECT sequence_name, min_value, max_value, increment_by, last_number, cache_size, cycle_flag
FROM user_sequences
WHERE sequence_name = 'SEQ_D_SONGS_SEQ';

--4. Insira duas linhas na tabela seq_d_songs. Certifique-se de usar a sequência criada para a coluna de ID. Adicione as duas músicas mostradas no quadro. 
--ID TITLE : Island Fever | Castle of Dreams DURATION : 5 min | 4 min ARTIST : Hawaiian Islanders | The Wanderers  TYPE_CODE : 12 | 77 

INSERT INTO seq_d_songs (id, title, duration, artist, type_code)
VALUES (seq_d_songs_seq.NEXTVAL, 'Island Fever', '5 min', 'Hawaiian Islanders', 12);

INSERT INTO seq_d_songs (id, title, duration, artist, type_code)
VALUES (seq_d_songs_seq.NEXTVAL, 'Castle of Dreams', '4 min', 'The Wanderers', 77);

--5. Escreva a sintaxe de seq_d_songs_seq para exibir o valor atual da sequência. Use a tabela DUAL. (O Oracle Application Express não executará essa consulta.) 

SELECT seq_d_songs_seq.CURRVAL FROM dual;

--6. Quais são as três vantagens de usar sequências? 
--Geração automática e única de números de identificação.
--Evita conflitos de chave primária em inserções simultâneas.
--Melhora a performance ao gerar valores sem depender de bloqueios de tabelas.

--7. Quais são as vantagens de armazenar valores de sequência em cache? 
--Reduz acessos ao disco, pois o Oracle pré-aloca valores na memória.
--Melhora o desempenho em inserções em massa.
--Diminui o tempo de espera entre requisições de novos valores.

--8. Indique três razões para que ocorram intervalos em uma sequência?
--Transações que falham ou são revertidas (ROLLBACK).
--O banco é desligado antes que os valores do cache sejam usados.
--O uso de múltiplas sessões que geram números de sequência simultaneamente.

--1. Crie uma tabela chamada “students”. Você pode decidir quais colunas pertencem a essa tabela e 
--quais tipos de dados elas requerem. (Os alunos podem criar uma tabela com colunas diversas; 
--entretanto, é importante que exista a coluna student_id com o tipo de dados numérico. O 
--tamanho dessa coluna deve ser adequado ao da sequência, por exemplo, uma coluna de 
--tamanho 4 com uma sequência que inicie em 1 e vá até 10000000 não funcionará depois que o 
--aluno número 9999 for inserido.) 

CREATE TABLE students (
    student_id NUMBER(4) PRIMARY KEY,
    first_name VARCHAR2(30),
    last_name VARCHAR2(30),
    course VARCHAR2(50)
);

--2. Crie uma sequência chamada student_id_seq a fim de que você possa designar números 
--exclusivos de student_id para todos os alunos adicionados à sua tabela.  

CREATE SEQUENCE student_id_seq
START WITH 1
INCREMENT BY 1
MAXVALUE 9999
NOCACHE
NOCYCLE;

--3. Agora escreva o código para adicionar alunos à tabela STUDENTS, usando a sua sequência “database object”. 

INSERT INTO students (student_id, first_name, last_name, course)
VALUES (student_id_seq.NEXTVAL, 'Tiago', 'Mendes', 'Database Systems');

INSERT INTO students (student_id, first_name, last_name, course)
VALUES (student_id_seq.NEXTVAL, 'Laura', 'Silva', 'Data Science');