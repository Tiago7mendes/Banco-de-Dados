CREATE DATABASE SEGURADORA;
USE SEGURADORA;

CREATE TABLE CLIENTE (
  codCliente INT PRIMARY KEY,
  nome       VARCHAR(30) NOT NULL,
  telefone   VARCHAR(30)
);

CREATE TABLE CARRO (
  chassiCarro INT PRIMARY KEY,
  marca       VARCHAR(10) NOT NULL,
  modelo      VARCHAR(10),
  ano         INT
);

CREATE TABLE CARRO_CLIENTE (
  codCliente   INT      NOT NULL,
  chassiCarro  INT      NOT NULL,
  dataCompra   DATE     NOT NULL,
  valorCompra  FLOAT    NOT NULL,
  PRIMARY KEY (codCliente, chassiCarro),
  FOREIGN KEY (codCliente)
    REFERENCES CLIENTE (codCliente)
    ON UPDATE CASCADE
    ON DELETE CASCADE,
  FOREIGN KEY (chassiCarro)
    REFERENCES CARRO (chassiCarro)
    ON UPDATE CASCADE
    ON DELETE CASCADE
);

CREATE TABLE ACIDENTE (
  codCliente  INT     NOT NULL,
  chassiCarro INT     NOT NULL,
  data        DATE,
  local       VARCHAR(50),
  PRIMARY KEY (codCliente, chassiCarro),
  FOREIGN KEY (codCliente, chassiCarro)
    REFERENCES CARRO_CLIENTE (codCliente, chassiCarro)
    ON UPDATE CASCADE
    ON DELETE CASCADE
);

INSERT INTO CLIENTE (codCliente, nome, telefone) VALUES
  (1, 'Ana Maria Leme',         '8888-9090'),
  (2, 'Fernando César Gomes',   '7777-4040');

INSERT INTO CARRO (chassiCarro, marca, modelo, ano) VALUES
  (123, 'Chevrolet', 'Corsa',  2008),
  (456, 'Fiat',       'Punto',  2011),
  (789, 'Fiat',       'Palio',  2010),
  (333, 'Chevrolet', 'Ônix',   2010);

INSERT INTO CARRO_CLIENTE (codCliente, chassiCarro, dataCompra, valorCompra) VALUES
  (1, 123, '2008-10-10', 30000.00),
  (2, 456, '2011-04-25', 45000.00),
  (1, 789, '2011-10-10', 23000.00),
  (2, 333, '2011-10-10', 23000.00);

INSERT INTO ACIDENTE (codCliente, chassiCarro, data, local) VALUES
  (2, 456, '2011-08-29', 'Av. Nove de Julho, 1004.'),
  (1, 123, '2012-08-29', 'Av. Nove de Julho, 1004.'),
  (2, 333, '2000-10-10', 'Av. Espanha, 205.');

ALTER TABLE CLIENTE
  ADD COLUMN endereco VARCHAR(30) BEFORE telefone;

ALTER TABLE CARRO
  DROP COLUMN ano;

ALTER TABLE CARRO
  MODIFY COLUMN modelo VARCHAR(80) DEFAULT 'Fiat';
