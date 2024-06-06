-- Criação do banco de dados
create database DA123_Exerc_G06;
go

use [DA123_Exerc_G06];
go

-- Criação das tabelas

-- Criação da tabela aluno
CREATE TABLE ALUNO (
	CODALUNO	smallint IDENTITY(1,1) NOT NULL,
	NOMEALUNO	varchar(40) NOT NULL,
	TELEFONE	char(11),
	EMAIL		varchar(40) NOT NULL,
	CPF		char(11) NOT NULL,
	DATANASC	date NOT NULL
);
go

-- Criação da tabela curso
CREATE TABLE CURSO (
	CODCURSO	smallint IDENTITY(1,1) NOT NULL,
	NOMECURSO	varchar(40) NOT NULL,
	TURNO		char(1) NOT NULL
);
go

-- Criação da tabela matéria
CREATE TABLE MATERIA (
	CODMATERIA		smallint IDENTITY(1,1) NOT NULL,
	CODCURSO		smallint NOT NULL,
	NOMEMATERIA		varchar(40) NOT NULL,
	PROFESSOR		varchar(40)
);
go

-- Criação da tabela matrícula
CREATE TABLE MATRICULA (
	CODMATRICULA		smallint IDENTITY(1,1) NOT NULL,
	CODALUNO		smallint NOT NULL,
	CODMATERIA		smallint NOT NULL,
	ANOSEMESTRE		smallint NOT NULL,
	DATAMATRICULA		date NOT NULL
);
go

-- Criação da tabela atividade
CREATE TABLE ATIVIDADE (
	CODATIVIDADE		smallint IDENTITY(1,1) NOT NULL,
	CODMATRICULA		smallint NOT NULL,
	TITULOATIVIDADE		varchar(40) NOT NULL,
	DESCRICAO		varchar(40),
	QNTDPONTOS		smallint,
	DATAHOJE		date NOT NULL,
	DATAENTREGUE		date,
	DATALIMITE		date NOT NULL
);
go

-- Criação das constraints

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

-- DEFAULTs
ALTER TABLE atividade ADD CONSTRAINT atividade_datahoje_df DEFAULT (getdate()) FOR datahoje;
go

-- INSERTs
INSERT INTO aluno (NOMEALUNO, TELEFONE, EMAIL, CPF, DATANASC) VALUES ('João Pedro Andrade Paes Pimentel Barbosa', '31970707070', 'joaopedroandrade@email.com', '12345678900', '2012-12-12');
go
INSERT INTO aluno (NOMEALUNO, TELEFONE, EMAIL, CPF, DATANASC) VALUES ('Pedro Gabriel Sousa Lopes', '33970707070', 'pedrogabriel@email.com', '98765432100', '2010-10-10');
go
INSERT INTO aluno (NOMEALUNO, TELEFONE, EMAIL, CPF, DATANASC) VALUES ('Tobias Reis Cassiano', '33970707070', 'tobiasreiscassiano@email.com', '78945612300', '2008-08-08');
go

-- SELECTs
SELECT * FROM aluno;
go

-- Adicionando os ativos para controle de tarefas
ALTER TABLE matricula ADD ATIVO char(1) NOT NULL
go
ALTER TABLE atividade ADD ATIVO char(1) NOT NULL
go

-- CHECKs para os ativos (foi usado V - verdadeiro F - falso)
ALTER TABLE matricula ADD CONSTRAINT matricula_ativo_CK CHECK (ATIVO IN ('V', 'F'))
go
ALTER TABLE atividade ADD CONSTRAINT atividade_ativo_CK CHECK (ATIVO IN ('V', 'F'))
go