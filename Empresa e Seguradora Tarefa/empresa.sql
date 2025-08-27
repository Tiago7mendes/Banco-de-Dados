CREATE DATABASE EMPRESA;
USE EMPRESA;

CREATE TABLE DEPARTAMENTO (
    Dnome VARCHAR(50),
    Dnumero INT PRIMARY KEY,
    Cpf_gerente VARCHAR(11),
    Data_inicio_gerente DATE
);

CREATE TABLE FUNCIONARIO (
    Pnome VARCHAR(50),
    Minicial CHAR(1),
    Unome VARCHAR(50),
    Cpf VARCHAR(11) PRIMARY KEY,
    Datanasc DATE,
    Endereco VARCHAR(100),
    Sexo CHAR(1),
    Salario DECIMAL(10,2),
    Cpf_supervisor VARCHAR(11),
    Dnr INT,
    FOREIGN KEY (Cpf_supervisor) REFERENCES FUNCIONARIO(Cpf),
    FOREIGN KEY (Dnr) REFERENCES DEPARTAMENTO(Dnumero)
);

CREATE TABLE LOCALIZACAO_DEP (
    Dnumero INT,
    Dlocal VARCHAR(50),
    FOREIGN KEY (Dnumero) REFERENCES DEPARTAMENTO(Dnumero)
);

-- INSERINDO DADOS CONFORME A FIGURA

INSERT INTO DEPARTAMENTO VALUES
('Pesquisa', 6, '33344555667', '2008-06-22'),
('Administração', 4, '08766123488', '2015-03-22'),
('Matriz', 1, '88866555578', '1981-09-16');

INSERT INTO FUNCIONARIO VALUES
('João', 'B', 'Silva', '12345678908', '1965-01-09', 'Rua das Flores, 751, São Paulo, SP', 'M', 30000.00, '33344555667', 5),
('Fernando', 'T', 'Wong', '33344555667', '1955-12-08', 'Rua da Lapa, 34, São Paulo, SP', 'M', 40000.00, '88866555578', 5),
('Alice', 'J', 'Zelaya', '09088777767', '1988-06-17', 'Rua Souza Lima, 65, Curitiba, PR', 'F', 25000.00, '33344555667', 5),
('Jennifer', 'S', 'Souza', '08766123488', '1992-09-14', 'Av. Arthur de Lima, 84, Santo André, SP', 'F', 43000.00, '33344555667', 5),
('Ronaldo', 'K', 'Lima', '66888444472', '1986-06-15', 'Rua Rebouças, 68, Piracicaba, SP', 'M', 25000.00, '33344555667', 5),
('Joice', 'A', 'Leite', '45344348756', '1972-07-12', 'Av. Lucas Obes, 74, São Paulo, SP', 'F', 25000.00, '33344555667', 5),
('André', 'A', 'Pereira', '97866733458', '1990-09-13', 'Rua Timbaúba, 35, São Paulo, SP', 'M', 25000.00, '33344555667', 5),
('Jorge', 'E', 'Brito', '88866555578', '1937-11-10', 'Rua do Hortelã, 30, São Paulo, SP', 'M', 65000.00, NULL, 1);

INSERT INTO LOCALIZACAO_DEP VALUES
(1, 'São Paulo'),
(4, 'Mauá'),
(6, 'Santo André'),
(6, 'Itu'),
(1, 'São Paulo');

INSERT INTO LOCALIZACAO_DEP VALUES (1, 'Houston');

INSERT INTO FUNCIONARIO VALUES
('James', 'E', 'Borg', '8886655555', '1937-11-10', '450 Stone, Houston, TX', 'M', 55000.00, NULL, 1);

INSERT INTO DEPARTAMENTO (Dnome, Dnumero) VALUES ('Pesquisa', 5);
INSERT INTO FUNCIONARIO VALUES
('Franklin', 'T', 'Wong', '8886655550', '1955-12-08', '638 Voss, Houston, TX', 'M', 40000.00, '8886655555', 5);

UPDATE FUNCIONARIO
SET Unome = 'Antunes'
WHERE Cpf = '33344555667';

UPDATE DEPARTAMENTO
SET Cpf_gerente = '97866733458', Data_inicio_gerente = CURDATE()
WHERE Dnome = 'Matriz';

DELETE FROM LOCALIZACAO_DEP
WHERE Dlocal = 'Itu';

UPDATE FUNCIONARIO
SET Salario = 60000.00
WHERE Pnome = 'Franklin' AND Unome = 'Wong';

DELETE FROM FUNCIONARIO
WHERE Pnome = 'Franklin' AND Unome = 'Wong';

UPDATE FUNCIONARIO
SET Salario = Salario * 1.10
WHERE Sexo = 'F';
