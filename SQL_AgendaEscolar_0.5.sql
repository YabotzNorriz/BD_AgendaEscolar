-- Cria��o do banco de dados

create database DA123_Exerc_G06;
go

use [DA123_Exerc_G06];
go

-- Cria��o das tabelas

-- Cria��o da tabela aluno
CREATE TABLE ALUNO (
	CODALUNO	smallint NOT NULL,
	NOMEALUNO	varchar(40) NOT NULL,
	TELEFONE	char(11),
	EMAIL		varchar(40) NOT NULL,
	CPF			char(11) NOT NULL,
	DATANASC	date NOT NULL
);
go

-- Cria��o da tabela curso
CREATE TABLE CURSO (
	CODCURSO		smallint NOT NULL,
	NOMECURSO		varchar(40) NOT NULL,
	TURNO			char(1) NOT NULL
);
go

-- Cria��o da tabela mat�ria
CREATE TABLE MATERIA (
	CODMATERIA		smallint NOT NULL,
	CODCURSO		smallint NOT NULL,
	NOMEMATERIA		varchar(40) NOT NULL,
	PROFESSOR		varchar(40)
);
go

CREATE TABLE MATRICULA (
-- Cria��o da tabela matr�cula
	CODMATRICULA	smallint NOT NULL,
	CODALUNO		smallint NOT NULL,
	CODMATERIA		smallint NOT NULL,
	ANOSEMESTRE		smallint NOT NULL,
	DATAMATRICULA	date NOT NULL
);
go

-- Cria��o da tabela atividade
CREATE TABLE ATIVIDADE (
	CODATIVIDADE		smallint NOT NULL,
	CODMATRICULA		smallint NOT NULL,
	TITULOATIVIDADE		varchar(40) NOT NULL,
	DESCRICAO			varchar(40),
	QNTDPONTOS			smallint,
	DATAHOJE			date NOT NULL,
	DATAENTREGUE		date,
	DATALIMITE			date NOT NULL
);
go

-- Cria��o das constraints

-- PKs
ALTER TABLE aluno ADD CONSTRAINT aluno_codaluno_PK PRIMARY KEY (codaluno);
go
ALTER TABLE curso ADD CONSTRAINT curso_codcurso_PK PRIMARY KEY (codcurso);
go
ALTER TABLE materia ADD CONSTRAINT materia_codmateria_PK PRIMARY KEY (codmateria);
go
ALTER TABLE matricula ADD CONSTRAINT matricula_codmatricula_PK PRIMARY KEY (codmatricula);
go
ALTER TABLE atividade ADD CONSTRAINT atividade_codatividade_PK PRIMARY KEY (codatividade);
go

-- FKs
ALTER TABLE materia ADD CONSTRAINT materia_codcurso_FK FOREIGN KEY (codcurso) REFERENCES curso(codcurso);
go
ALTER TABLE matricula ADD CONSTRAINT matricula_codaluno_FK FOREIGN KEY (codaluno) REFERENCES aluno(codaluno);
go
ALTER TABLE matricula ADD CONSTRAINT matricula_codmateria_FK FOREIGN KEY (codmateria) REFERENCES materia(codmateria);
go
ALTER TABLE atividade ADD CONSTRAINT atividade_codmatricula_FK FOREIGN KEY (codmatricula) REFERENCES matricula(codmatricula);
go

-- UNIQUEs
ALTER TABLE aluno ADD CONSTRAINT aluno_cpf_uq UNIQUE (cpf);
go
ALTER TABLE matricula ADD CONSTRAINT matricula_codmatricula_uq UNIQUE (codmatricula);
go

-- CHECKs
ALTER TABLE matricula ADD CONSTRAINT matricula_anosemestre_ck CHECK (anosemestre >= 1);
go
ALTER TABLE curso ADD CONSTRAINT curso_turno_ck CHECK (turno = 'M' OR turno = 'T' OR turno = 'N');
go

-- DEFAULT
ALTER TABLE atividade ADD CONSTRAINT atividade_datahoje_df DEFAULT (getdate()) FOR datahoje;
go

-- INSERTs
INSERT INTO aluno (CODALUNO, NOMEALUNO, TELEFONE, EMAIL, CPF, DATANASC) VALUES (1, 'Jo�o Pedro Andrade Paes Pimentel Barbosa', '31970707070', 'joaopedroandrade@email.com', '12345678900', '2012-12-12');
go
INSERT INTO aluno (CODALUNO, NOMEALUNO, TELEFONE, EMAIL, CPF, DATANASC) VALUES (2, 'Pedro Gabriel Sousa Lopes', '33970707070', 'pedrogabriel@email.com', '98765432100', '2010-10-10');
go
INSERT INTO aluno (CODALUNO, NOMEALUNO, TELEFONE, EMAIL, CPF, DATANASC) VALUES (3, 'Tobias Reis Cassiano', '33970707070', 'tobiasreiscassiano@email.com', '78945612300', '2008-08-08');
go

-- SELECTs
SELECT * FROM aluno;
go