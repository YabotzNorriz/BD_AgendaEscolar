-- Tabelas

use [AgendaEscolar]
go

CREATE TABLE ALUNO (
	CODALUNO	smallint NOT NULL,
	NOMEALUNO	varchar(40) NOT NULL,
	TELEFONE	int,
	CPF		char(11) NOT NULL,
	EMAIL		varchar(40) NOT NULL,
	DTNASC		date NOT NULL
);
go

CREATE TABLE MATRICULA (
	CODMATRICULA	smallint NOT NULL,
	CODALUNO	smallint NOT NULL,
	CODCURSO	smallint NOT NULL,
	ANOSEMESTRE	smallint NOT NULL,
	DTMATRICULA 	date NOT NULL
);
go

CREATE TABLE CURSO (
	CODCURSO	smallint NOT NULL,
	NOMECURSO	varchar(40) NOT NULL,
	TURNO		char(2)
);
go

CREATE TABLE MATERIA (
	CODALUNO	smallint NOT NULL,
	CODCURSO	smallint NOT NULL,
	CODMATERIA	smallint NOT NULL,
	NOMEMATERIA	varchar(40) NOT NULL,
	PROFESSOR	varchar(40)
);
go

CREATE TABLE ATIVIDADE (
	CODALUNO		smallint NOT NULL,
	CODCURSO		smallint NOT NULL,
	CODATIVIDADE		smallint NOT NULL,
	TITULOATIVIDADE		varchar(40) NOT NULL,
	DESCRICAO		varchar(40),
	QNTDPONTOS		smallint
);
go

CREATE TABLE CRONOGRAMA (
	CODATIVIDADE		smallint NOT NULL,
	CODMATERIA		smallint NOT NULL,
	DATAHOJE		date,
	DATAENTREGA		date NOT NULL
);
go

-- Constraints

-- Cria as PKs
ALTER TABLE aluno ADD CONSTRAINT aluno_codaluno_PK PRIMARY KEY (codaluno);
go
ALTER TABLE curso ADD CONSTRAINT curso_codcurso_PK PRIMARY KEY (codcurso);
go
ALTER TABLE matricula ADD CONSTRAINT matricula_codaluno_codcurso_anosemestre_PK PRIMARY KEY (codaluno, codcurso, anosemestre);
go
ALTER TABLE materia ADD CONSTRAINT materia_codaluno_codcurso_codmateria_PK PRIMARY KEY (codaluno, codaluno, codmateria);
go
ALTER TABLE atividade ADD CONSTRAINT atividade_codmateria_codatividade_PK PRIMARY KEY (codmateria, codatividade);
go
ALTER TABLE cronograma ADD CONSTRAINT cronograma_codmateria_codatividade_PK PRIMARY KEY (codmateria, codatividade);
go

-- Cria as FKs
ALTER TABLE matricula ADD CONSTRAINT matricula_codaluno_FK FOREIGN KEY (codaluno) REFERENCES aluno(codaluno);
go
ALTER TABLE matricula ADD CONSTRAINT matricula_codcurso_FK FOREIGN KEY (codcurso) REFERENCES curso(codcurso);
go
ALTER TABLE materia ADD CONSTRAINT materia_codaluno_FK FOREIGN KEY (codaluno) REFERENCES aluno(codaluno);
go
ALTER TABLE materia ADD CONSTRAINT materia_codcurso_FK FOREIGN KEY (codcurso) REFERENCES curso(codcurso);
go
ALTER TABLE atividade ADD CONSTRAINT atvidade_codmateria_FK FOREIGN KEY (codmateria) REFERENCES materia(codmateria);
go
ALTER TABLE cronograma ADD CONSTRAINT cronograma_codatividade_FK FOREIGN KEY (codatividade) REFERENCES atividade(codatividade);
go
ALTER TABLE cronograma ADD CONSTRAINT cronograma_codmateria_FK FOREIGN KEY (codmateria) REFERENCES materia(codmateria);
go

-- Criar as UNIQUEs
ALTER TABLE aluno ADD CONSTRAINT aluno_cpf_uq UNIQUE (cpf);
go
ALTER TABLE matricula ADD CONSTRAINT matricula_codmatricula_uq UNIQUE (codmatricula);
go

-- Cria o CHECK
ALTER TABLE matricula ADD CONSTRAINT matricula_anosemestre_ck CHECK (anosemestre >= 1);
go

--Cria o DEFAULT
ALTER TABLE cronograma ADD CONSTRAINT cronograma_datahoje_df DEFAULT (getdate()) FOR datahoje;
go
