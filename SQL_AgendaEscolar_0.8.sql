-- Criação do banco de dados
create database DA123_Exerc_G06;
go

use [DA123_Exerc_G06];
go

-- Criação das tabelas

-- Criação da tabela aluno
CREATE TABLE ALUNO (
	CODALUNO	INTEGER IDENTITY(1,1) NOT NULL,
	NOMEALUNO	VARCHAR(40) NOT NULL,
	TELEFONE	CHAR(11),
	EMAIL		VARCHAR(40) NOT NULL,
	CPF			CHAR(11) NOT NULL,
	DATANASC	DATE NOT NULL,
	ATIVO		CHAR(1) NOT NULL
);
go

-- Criação da tabela curso
CREATE TABLE CURSO (
	CODCURSO	INTEGER IDENTITY(1,1) NOT NULL,
	NOMECURSO	VARCHAR(40) NOT NULL,
	--TURNO		CHAR(1) NOT NULL, [TURNO ALTERADO PARA VARCHAR]
	TURNO		VARCHAR(5) NOT NULL,
	ATIVO		CHAR(1) NOT NULL
);
go

-- Criação da tabela matéria
CREATE TABLE MATERIA (
	CODMATERIA		INTEGER IDENTITY(1,1) NOT NULL,
	CODCURSO		INTEGER NOT NULL,
	NOMEMATERIA		VARCHAR(40) NOT NULL,
	PROFESSOR		VARCHAR(40),
	ATIVO			CHAR(1) NOT NULL
);
go

-- Criação da tabela matrícula
CREATE TABLE MATRICULA (
	CODMATRICULA		INTEGER IDENTITY(1,1) NOT NULL,
	CODALUNO			INTEGER NOT NULL,
	CODMATERIA			INTEGER NOT NULL,
	SEMESTRE			SMALLINT NOT NULL,
	DATAMATRICULA		DATE NOT NULL,
	ATIVO				CHAR(1) NOT NULL
);
go

-- Criação da tabela atividade
CREATE TABLE ATIVIDADE (
	CODATIVIDADE		INTEGER IDENTITY(1,1) NOT NULL,
	CODMATRICULA		INTEGER NOT NULL,
	TITULOATIVIDADE		VARCHAR(40) NOT NULL,
	DESCRICAO			VARCHAR(40),
	QTDEPONTOS			SMALLINT,
	DATAHOJE			DATE NOT NULL,
	DATAENTREGUE		DATE,
	DATALIMITE			DATE NOT NULL,
	ATIVO				CHAR(1) NOT NULL
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
ALTER TABLE matricula ADD CONSTRAINT matricula_semestre_ck CHECK (semestre >= 1);
go
--ALTER TABLE curso ADD CONSTRAINT curso_turno_ck CHECK (turno = 'M' OR turno = 'T' OR turno = 'N');
--go [CHECK DESNECESSÁRIO, JCOMBOBOX POSSUI APENAS VALORES VÁLIDOS]
ALTER TABLE matricula ADD CONSTRAINT matricula_ativo_CK CHECK (ATIVO IN ('S', 'N'))
go
ALTER TABLE atividade ADD CONSTRAINT atividade_ativo_CK CHECK (ATIVO IN ('S', 'N'))
go
ALTER TABLE aluno ADD CONSTRAINT aluno_ativo_CK CHECK (ATIVO IN ('S', 'N'))
go
ALTER TABLE curso ADD CONSTRAINT curso_ativo_CK CHECK (ATIVO IN ('S', 'N'))
go
ALTER TABLE materia ADD CONSTRAINT materia_ativo_CK CHECK (ATIVO IN ('S', 'N'))
go

-- DEFAULTs
ALTER TABLE atividade ADD CONSTRAINT atividade_datahoje_df DEFAULT (getdate()) FOR datahoje;
go

-- INSERTs
INSERT INTO aluno (NOMEALUNO, TELEFONE, EMAIL, CPF, DATANASC, ATIVO) VALUES ('João Pedro Andrade Paes Pimentel Barbosa', '31970707070', 'joaopedroandrade@email.com', '12345678900', '2012-12-12', 'S');
go
INSERT INTO aluno (NOMEALUNO, TELEFONE, EMAIL, CPF, DATANASC, ATIVO) VALUES ('Pedro Gabriel Sousa Lopes', '33970707070', 'pedrogabriel@email.com', '98765432100', '2010-10-10', 'S');
go
INSERT INTO aluno (NOMEALUNO, TELEFONE, EMAIL, CPF, DATANASC, ATIVO) VALUES ('Tobias Reis Cassiano', '33970707070', 'tobiasreiscassiano@email.com', '78945612300', '2008-08-08', 'S');
go

-- SELECTs
SELECT * FROM aluno;
go

/*
-- Adicionando os ativos para controle de tarefas
ALTER TABLE matricula ADD 
go
ALTER TABLE atividade ADD ATIVO char(1) NOT NULL
go
ALTER TABLE aluno ADD ATIVO char(1) NOT NULL
go
ALTER TABLE curso ADD ATIVO char(1) NOT NULL
go
ALTER TABLE materia ADD ATIVO char(1) NOT NULL
go
[ADICIONADO DIRETAMENTE NAS TABELAS]

-- CHECKs para os ativos (foi usado V - verdadeiro F - falso)
ALTER TABLE matricula ADD CONSTRAINT matricula_ativo_CK CHECK (ATIVO IN ('V', 'F'))
go
ALTER TABLE atividade ADD CONSTRAINT atividade_ativo_CK CHECK (ATIVO IN ('V', 'F'))
go
ALTER TABLE aluno ADD CONSTRAINT aluno_ativo_CK CHECK (ATIVO IN ('V', 'F'))
go
ALTER TABLE curso ADD CONSTRAINT curso_ativo_CK CHECK (ATIVO IN ('V', 'F'))
go
ALTER TABLE materia ADD CONSTRAINT materia_ativo_CK CHECK (ATIVO IN ('V', 'F'))
go
[MOVIDO PARA CIMA]
*/

SELECT mat.* 
FROM matricula MAT INNER JOIN materia M ON mat.CODMATERIA = m.CODMATERIA INNER JOIN curso C ON c.CODCURSO = m.CODCURSO
WHERE mat.ATIVO = 'S' AND m.ATIVO = 'S' AND c.ATIVO = 'S'

SELECT m.*
FROM materia M INNER JOIN curso C ON c.CODCURSO = m.CODCURSO
WHERE m.ATIVO = 'S' AND c.ATIVO = 'S'

SELECT *
FROM atividade

UPDATE ATIVIDADE SET ativo = 'N', DATAENTREGUE = getdate() WHERE codatividade = 1;

UPDATE ATIVIDADE SET ativo = 'S', dataentregue = NULL WHERE codatividade = 1;

