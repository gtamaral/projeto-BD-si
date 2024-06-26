--CRIAÇÃO DE TABELAS--

--CRIAR TABELA TURMA
CREATE TABLE TURMA (
    CODIGO NUMBER PRIMARY KEY,
    SERIE VARCHAR2(4),
    NOME VARCHAR2(100),
    ANO NUMBER
);

--CRIAR TABELA SALA
CREATE TABLE SALA (
    CODIGO NUMBER PRIMARY KEY,
    CAPACIDADE NUMBER,
    TIPO_SALA VARCHAR2(50)
);

--CRIAR TABELA MATERIA
CREATE TABLE MATERIA (
    CODIGO NUMBER PRIMARY KEY,
    CARGA_HORARIA NUMBER,
    NOME VARCHAR2(50),
    SERIE VARCHAR2(4)
);

--CRIAR POSSUI
CREATE TABLE POSSUI (
    CODIGO_MATERIA NUMBER,
    CODIGO_TURMA NUMBER,
    CODIGO_SALA NUMBER NOT NULL,
    CONSTRAINT FK_CODIGO_MATERIA FOREIGN KEY (CODIGO_MATERIA) REFERENCES MATERIA(CODIGO),
    CONSTRAINT FK_CODIGO_TURMA FOREIGN KEY (CODIGO_TURMA) REFERENCES TURMA(CODIGO),
    CONSTRAINT FK_CODIGO_SALA FOREIGN KEY (CODIGO_SALA) REFERENCES SALA(CODIGO),
    CONSTRAINT PK_POSSUI PRIMARY KEY (CODIGO_MATERIA, CODIGO_TURMA)
);

--CRIAR INSTITUICAO
CREATE TABLE INSTITUICAO (
    CNPJ VARCHAR2(14) PRIMARY KEY,
    NOME VARCHAR2(100),
    END_RUA VARCHAR2(100),
    END_NUMERO NUMBER,
    END_BAIRRO VARCHAR2(100)
);

--CRIAR TELEFONES
CREATE TABLE TELEFONES (
    CNPJ VARCHAR2(14),
    TELEFONE VARCHAR2(20),
    CONSTRAINT PK_TELEFONES PRIMARY KEY (CNPJ, TELEFONE),
    CONSTRAINT FK_TELEFONES_CNPJ FOREIGN KEY (CNPJ) REFERENCES INSTITUICAO(CNPJ)
);

--CRIAR PROFESSOR
CREATE TABLE PROFESSOR (
    MATRICULA NUMBER PRIMARY KEY,
    NASCIMENTO DATE,
    NOME VARCHAR2(100),
    CPF VARCHAR2(11) UNIQUE,
    COORDENADOR NUMBER,
    CNPJ VARCHAR2(14) NOT NULL,
    CONSTRAINT FK_COORDENADOR_MATRICULA FOREIGN KEY (COORDENADOR) REFERENCES PROFESSOR(MATRICULA),
    CONSTRAINT FK_CNPJ_INSTITUICAO FOREIGN KEY (CNPJ) REFERENCES INSTITUICAO(CNPJ)
);

--CRIAR ENSINA
CREATE TABLE ENSINA (
    CODIGO NUMBER,
    MATRICULA NUMBER,
    CONSTRAINT FK_ENSINA_CODIGO_MATERIA FOREIGN KEY (CODIGO) REFERENCES MATERIA(CODIGO),
    CONSTRAINT FK_ENSINA_MATRICULA_PROFESSOR FOREIGN KEY (MATRICULA) REFERENCES PROFESSOR(MATRICULA),
    CONSTRAINT PK_ENSINA PRIMARY KEY (CODIGO, MATRICULA)
);


--CRIAR SALARIO_PROFESSORES
CREATE TABLE SALARIO_PROFESSORES (
    CODIGO NUMBER PRIMARY KEY,
    VALOR NUMBER
);

--CRIAR BONUS
CREATE TABLE BONUS (
    CODIGO NUMBER PRIMARY KEY,
    NOME VARCHAR2(100),
    VALOR NUMBER
);

--CRIAR RECEBE
CREATE TABLE RECEBE (
    MATRICULA_PROFESSOR NUMBER,
    CODIGO_SALARIO NUMBER,
    DATA DATE,
    CODIGO_BONUS NUMBER,
    CONSTRAINT FK_MATRICULA_PROFESSOR FOREIGN KEY (MATRICULA_PROFESSOR) REFERENCES PROFESSOR(MATRICULA),
    CONSTRAINT FK_CODIGO_SALARIO FOREIGN KEY (CODIGO_SALARIO) REFERENCES SALARIO_PROFESSORES(CODIGO),
    CONSTRAINT FK_CODIGO_BONUS FOREIGN KEY (CODIGO_BONUS) REFERENCES BONUS(CODIGO),
    CONSTRAINT PK_RECEBE PRIMARY KEY (MATRICULA_PROFESSOR, CODIGO_SALARIO, DATA)
);

--CRIAR ALUNO
CREATE TABLE ALUNO (
    MATRICULA NUMBER PRIMARY KEY,
    NOME VARCHAR2(100),
    CPF VARCHAR2(11) UNIQUE,
    NASCIMENTO DATE,
    TURMA NUMBER,
    CURSO_MEDIO VARCHAR2(100),
    CNPJ_INSTITUICAO VARCHAR2(14) NOT NULL,
    CONSTRAINT FK_CNPJ_INSTITUICAO_ALUNO FOREIGN KEY (CNPJ_INSTITUICAO) REFERENCES INSTITUICAO(CNPJ),
    CONSTRAINT FK_TURMA FOREIGN KEY (TURMA) REFERENCES TURMA(CODIGO)
);


--CRIAR ARMARIO
CREATE TABLE ARMARIO (
    MATRICULA_ALUNO NUMBER PRIMARY KEY,
    LOCALIZACAO VARCHAR2(100),
    TAMANHO VARCHAR2(50),
    CONSTRAINT FK_MATRICULA_ALUNO FOREIGN KEY (MATRICULA_ALUNO) REFERENCES ALUNO(MATRICULA)
);


--POVOAMENTO DE TABELAS--

--POVOAR TURMA
INSERT INTO TURMA (CODIGO, SERIE, NOME, ANO) VALUES (1, '1EM', '1 ANO EM', 2023);
INSERT INTO TURMA (CODIGO, SERIE, NOME, ANO) VALUES (2, '7', '7 ANO', 2023);
INSERT INTO TURMA (CODIGO, SERIE, NOME, ANO) VALUES (3, '8', '8 ANO', 2023);
INSERT INTO TURMA (CODIGO, SERIE, NOME, ANO) VALUES (4, '1EM', '1 ANO EM', 2023);

--POVOAR SALA
INSERT INTO SALA (CODIGO, CAPACIDADE, TIPO_SALA) VALUES (1, 60, 'SALA COMUM');
INSERT INTO SALA (CODIGO, CAPACIDADE, TIPO_SALA) VALUES (2, 60, 'SALA COMUM');
INSERT INTO SALA (CODIGO, CAPACIDADE, TIPO_SALA) VALUES (3, 60, 'SALA COMUM');
INSERT INTO SALA (CODIGO, CAPACIDADE, TIPO_SALA) VALUES (4, 50, 'LABORATORIO');
INSERT INTO SALA (CODIGO, CAPACIDADE, TIPO_SALA) VALUES (5, 100, 'QUADRA');
INSERT INTO SALA (CODIGO, CAPACIDADE, TIPO_SALA) VALUES (6, 50, 'SALA COMUM');

--POVOAR MATERIA
INSERT INTO MATERIA (CODIGO, CARGA_HORARIA, NOME, SERIE) VALUES (1, 80, 'PORTUGUES', '1EM');
INSERT INTO MATERIA (CODIGO, CARGA_HORARIA, NOME, SERIE) VALUES (2, 80, 'MATEMATICA', '1EM');
INSERT INTO MATERIA (CODIGO, CARGA_HORARIA, NOME, SERIE) VALUES (3, 80, 'CIENCIAS', '1EM');
INSERT INTO MATERIA (CODIGO, CARGA_HORARIA, NOME, SERIE) VALUES (4, 80, 'HISTORIA', '1EM');
INSERT INTO MATERIA (CODIGO, CARGA_HORARIA, NOME, SERIE) VALUES (5, 80, 'GEOGRAFIA', '1EM');
INSERT INTO MATERIA (CODIGO, CARGA_HORARIA, NOME, SERIE) VALUES (6, 80, 'INGLES', '1EM');
INSERT INTO MATERIA (CODIGO, CARGA_HORARIA, NOME, SERIE) VALUES (7, 80, 'EDUCACAO_FISICA', '1EM');

INSERT INTO MATERIA (CODIGO, CARGA_HORARIA, NOME, SERIE) VALUES (8, 80, 'PORTUGUES', '7');
INSERT INTO MATERIA (CODIGO, CARGA_HORARIA, NOME, SERIE) VALUES (9, 80, 'MATEMATICA', '7');
INSERT INTO MATERIA (CODIGO, CARGA_HORARIA, NOME, SERIE) VALUES (10, 80, 'CIENCIAS', '7');
INSERT INTO MATERIA (CODIGO, CARGA_HORARIA, NOME, SERIE) VALUES (11, 80, 'HISTORIA', '7');
INSERT INTO MATERIA (CODIGO, CARGA_HORARIA, NOME, SERIE) VALUES (12, 80, 'GEOGRAFIA', '7');
INSERT INTO MATERIA (CODIGO, CARGA_HORARIA, NOME, SERIE) VALUES (13, 80, 'INGLES', '7');
INSERT INTO MATERIA (CODIGO, CARGA_HORARIA, NOME, SERIE) VALUES (14, 80, 'EDUCACAO_FISICA', '7');

INSERT INTO MATERIA (CODIGO, CARGA_HORARIA, NOME, SERIE) VALUES (15, 80, 'PORTUGUES', '8');
INSERT INTO MATERIA (CODIGO, CARGA_HORARIA, NOME, SERIE) VALUES (16, 80, 'MATEMATICA', '8');
INSERT INTO MATERIA (CODIGO, CARGA_HORARIA, NOME, SERIE) VALUES (17, 80, 'CIENCIAS', '8');
INSERT INTO MATERIA (CODIGO, CARGA_HORARIA, NOME, SERIE) VALUES (18, 80, 'HISTORIA', '8');
INSERT INTO MATERIA (CODIGO, CARGA_HORARIA, NOME, SERIE) VALUES (19, 80, 'GEOGRAFIA', '8');
INSERT INTO MATERIA (CODIGO, CARGA_HORARIA, NOME, SERIE) VALUES (20, 80, 'INGLES', '8');
INSERT INTO MATERIA (CODIGO, CARGA_HORARIA, NOME, SERIE) VALUES (21, 80, 'EDUCACAO_FISICA', '8');

--POVOAR POSSUI
INSERT INTO POSSUI (CODIGO_MATERIA, CODIGO_TURMA, CODIGO_SALA) VALUES (1, 1, 1);
INSERT INTO POSSUI (CODIGO_MATERIA, CODIGO_TURMA, CODIGO_SALA) VALUES (2, 1, 1);
INSERT INTO POSSUI (CODIGO_MATERIA, CODIGO_TURMA, CODIGO_SALA) VALUES (3, 1, 4);
INSERT INTO POSSUI (CODIGO_MATERIA, CODIGO_TURMA, CODIGO_SALA) VALUES (4, 1, 1);
INSERT INTO POSSUI (CODIGO_MATERIA, CODIGO_TURMA, CODIGO_SALA) VALUES (5, 1, 1);
INSERT INTO POSSUI (CODIGO_MATERIA, CODIGO_TURMA, CODIGO_SALA) VALUES (6, 1, 1);
INSERT INTO POSSUI (CODIGO_MATERIA, CODIGO_TURMA, CODIGO_SALA) VALUES (7, 1, 5);

INSERT INTO POSSUI (CODIGO_MATERIA, CODIGO_TURMA, CODIGO_SALA) VALUES (8, 2, 2);
INSERT INTO POSSUI (CODIGO_MATERIA, CODIGO_TURMA, CODIGO_SALA) VALUES (9, 2, 2);
INSERT INTO POSSUI (CODIGO_MATERIA, CODIGO_TURMA, CODIGO_SALA) VALUES (10, 2, 4); 
INSERT INTO POSSUI (CODIGO_MATERIA, CODIGO_TURMA, CODIGO_SALA) VALUES (11, 2, 2);
INSERT INTO POSSUI (CODIGO_MATERIA, CODIGO_TURMA, CODIGO_SALA) VALUES (12, 2, 2); 
INSERT INTO POSSUI (CODIGO_MATERIA, CODIGO_TURMA, CODIGO_SALA) VALUES (13, 2, 2);
INSERT INTO POSSUI (CODIGO_MATERIA, CODIGO_TURMA, CODIGO_SALA) VALUES (14, 2, 5);

INSERT INTO POSSUI (CODIGO_MATERIA, CODIGO_TURMA, CODIGO_SALA) VALUES (15, 3, 3);
INSERT INTO POSSUI (CODIGO_MATERIA, CODIGO_TURMA, CODIGO_SALA) VALUES (16, 3, 3);
INSERT INTO POSSUI (CODIGO_MATERIA, CODIGO_TURMA, CODIGO_SALA) VALUES (17, 3, 4);
INSERT INTO POSSUI (CODIGO_MATERIA, CODIGO_TURMA, CODIGO_SALA) VALUES (18, 3, 3);
INSERT INTO POSSUI (CODIGO_MATERIA, CODIGO_TURMA, CODIGO_SALA) VALUES (19, 3, 3); 
INSERT INTO POSSUI (CODIGO_MATERIA, CODIGO_TURMA, CODIGO_SALA) VALUES (20, 3, 3); 
INSERT INTO POSSUI (CODIGO_MATERIA, CODIGO_TURMA, CODIGO_SALA) VALUES (21, 3, 5);

--POVOAR INSTITUICAO
INSERT INTO INSTITUICAO (CNPJ, NOME, END_RUA, END_NUMERO, END_BAIRRO) VALUES ('1234', 'ESCOLA A', 'RUA A', 1, 'BAIRRO A');

--POVOAR TELEFONES 
INSERT INTO TELEFONES (CNPJ, TELEFONE) VALUES ('1234', '8112345678');
INSERT INTO TELEFONES (CNPJ, TELEFONE) VALUES ('1234', '9523456789');

--POVOAR PROFESSOR
INSERT INTO PROFESSOR (MATRICULA, NASCIMENTO, NOME, CPF, COORDENADOR, CNPJ) VALUES (1, TO_DATE('01/01/2000', 'DD/MM/YYYY'), 'Robson', '12345', 1, '1234');
INSERT INTO PROFESSOR (MATRICULA, NASCIMENTO, NOME, CPF, COORDENADOR, CNPJ) VALUES (2, TO_DATE('02/02/1985', 'DD/MM/YYYY'), 'Maria', '54321', 1, '1234');
INSERT INTO PROFESSOR (MATRICULA, NASCIMENTO, NOME, CPF, COORDENADOR, CNPJ) VALUES (3, TO_DATE('15/07/1979', 'DD/MM/YYYY'), 'João', '98765', 1, '1234');
INSERT INTO PROFESSOR (MATRICULA, NASCIMENTO, NOME, CPF, COORDENADOR, CNPJ) VALUES (4, TO_DATE('20/04/1990', 'DD/MM/YYYY'), 'Ana', '45678', 1, '1234');
INSERT INTO PROFESSOR (MATRICULA, NASCIMENTO, NOME, CPF, COORDENADOR, CNPJ) VALUES (5, TO_DATE('10/10/1982', 'DD/MM/YYYY'), 'Pedro', '87654', 1, '1234');
INSERT INTO PROFESSOR (MATRICULA, NASCIMENTO, NOME, CPF, COORDENADOR, CNPJ) VALUES (6, TO_DATE('05/03/1976', 'DD/MM/YYYY'), 'Juliana', '23456', 1, '1234');
INSERT INTO PROFESSOR (MATRICULA, NASCIMENTO, NOME, CPF, COORDENADOR, CNPJ) VALUES (7, TO_DATE('12/12/1988', 'DD/MM/YYYY'), 'Rafael', '65432', 1, '1234');
INSERT INTO PROFESSOR (MATRICULA, NASCIMENTO, NOME, CPF, COORDENADOR, CNPJ) VALUES (8, TO_DATE('26/12/1988', 'DD/MM/YYYY'), 'Andrade', '67732', 1, '1234');

--POVOAR ENSINA
INSERT INTO ENSINA (CODIGO, MATRICULA) VALUES (1, 1);
INSERT INTO ENSINA (CODIGO, MATRICULA) VALUES (8, 1);
INSERT INTO ENSINA (CODIGO, MATRICULA) VALUES (15, 1);

INSERT INTO ENSINA (CODIGO, MATRICULA) VALUES (2, 2);
INSERT INTO ENSINA (CODIGO, MATRICULA) VALUES (9, 2);
INSERT INTO ENSINA (CODIGO, MATRICULA) VALUES (16, 2);

INSERT INTO ENSINA (CODIGO, MATRICULA) VALUES (3, 3);
INSERT INTO ENSINA (CODIGO, MATRICULA) VALUES (10, 3);
INSERT INTO ENSINA (CODIGO, MATRICULA) VALUES (17, 3);

INSERT INTO ENSINA (CODIGO, MATRICULA) VALUES (4, 4);
INSERT INTO ENSINA (CODIGO, MATRICULA) VALUES (11, 4);
INSERT INTO ENSINA (CODIGO, MATRICULA) VALUES (18, 4);

INSERT INTO ENSINA (CODIGO, MATRICULA) VALUES (5, 5);
INSERT INTO ENSINA (CODIGO, MATRICULA) VALUES (12, 5);
INSERT INTO ENSINA (CODIGO, MATRICULA) VALUES (19, 5);

INSERT INTO ENSINA (CODIGO, MATRICULA) VALUES (6, 6);
INSERT INTO ENSINA (CODIGO, MATRICULA) VALUES (13, 6);
INSERT INTO ENSINA (CODIGO, MATRICULA) VALUES (20, 6);

INSERT INTO ENSINA (CODIGO, MATRICULA) VALUES (7, 7);
INSERT INTO ENSINA (CODIGO, MATRICULA) VALUES (14, 7);
INSERT INTO ENSINA (CODIGO, MATRICULA) VALUES (21, 7);

--POVOAR SALARIO_PROFESSORES
INSERT INTO SALARIO_PROFESSORES (CODIGO, VALOR) VALUES (1, 2500);
INSERT INTO SALARIO_PROFESSORES (CODIGO, VALOR) VALUES (2, 3600);
INSERT INTO SALARIO_PROFESSORES (CODIGO, VALOR) VALUES (3, 4800);

--POVOAR BONUS
INSERT INTO BONUS (CODIGO, NOME, VALOR) VALUES (1, 'BONUS DE ASSIDUIDADE', 300);
INSERT INTO BONUS (CODIGO, NOME, VALOR) VALUES (2, 'BONUS NATAL', 400);

--POVOAR RECEBE 
INSERT INTO RECEBE (MATRICULA_PROFESSOR, CODIGO_SALARIO, DATA) VALUES (1, 3, TO_DATE('05/01/2023', 'DD/MM/YYYY'));
INSERT INTO RECEBE (MATRICULA_PROFESSOR, CODIGO_SALARIO, DATA) VALUES (1, 3, TO_DATE('05/02/2023', 'DD/MM/YYYY'));
INSERT INTO RECEBE (MATRICULA_PROFESSOR, CODIGO_SALARIO, DATA) VALUES (1, 3, TO_DATE('05/03/2023', 'DD/MM/YYYY'));
INSERT INTO RECEBE (MATRICULA_PROFESSOR, CODIGO_SALARIO, DATA) VALUES (1, 3, TO_DATE('05/04/2023', 'DD/MM/YYYY'));
INSERT INTO RECEBE (MATRICULA_PROFESSOR, CODIGO_SALARIO, DATA) VALUES (1, 3, TO_DATE('05/05/2023', 'DD/MM/YYYY'));
INSERT INTO RECEBE (MATRICULA_PROFESSOR, CODIGO_SALARIO, DATA) VALUES (1, 3, TO_DATE('05/06/2023', 'DD/MM/YYYY'));
INSERT INTO RECEBE (MATRICULA_PROFESSOR, CODIGO_SALARIO, DATA) VALUES (1, 3, TO_DATE('05/07/2023', 'DD/MM/YYYY'));
INSERT INTO RECEBE (MATRICULA_PROFESSOR, CODIGO_SALARIO, DATA) VALUES (1, 3, TO_DATE('05/08/2023', 'DD/MM/YYYY'));
INSERT INTO RECEBE (MATRICULA_PROFESSOR, CODIGO_SALARIO, DATA) VALUES (1, 3, TO_DATE('05/09/2023', 'DD/MM/YYYY'));
INSERT INTO RECEBE (MATRICULA_PROFESSOR, CODIGO_SALARIO, DATA) VALUES (1, 3, TO_DATE('05/10/2023', 'DD/MM/YYYY'));
INSERT INTO RECEBE (MATRICULA_PROFESSOR, CODIGO_SALARIO, DATA) VALUES (1, 3, TO_DATE('05/11/2023', 'DD/MM/YYYY'));
INSERT INTO RECEBE (MATRICULA_PROFESSOR, CODIGO_SALARIO, DATA, CODIGO_BONUS) VALUES (1, 3, TO_DATE('05/12/2023', 'DD/MM/YYYY'), 2);

INSERT INTO RECEBE (MATRICULA_PROFESSOR, CODIGO_SALARIO, DATA) VALUES (2, 3, TO_DATE('05/01/2023', 'DD/MM/YYYY'));
INSERT INTO RECEBE (MATRICULA_PROFESSOR, CODIGO_SALARIO, DATA) VALUES (2, 3, TO_DATE('05/02/2023', 'DD/MM/YYYY'));
INSERT INTO RECEBE (MATRICULA_PROFESSOR, CODIGO_SALARIO, DATA) VALUES (2, 3, TO_DATE('05/03/2023', 'DD/MM/YYYY'));
INSERT INTO RECEBE (MATRICULA_PROFESSOR, CODIGO_SALARIO, DATA) VALUES (2, 3, TO_DATE('05/04/2023', 'DD/MM/YYYY'));
INSERT INTO RECEBE (MATRICULA_PROFESSOR, CODIGO_SALARIO, DATA) VALUES (2, 3, TO_DATE('05/05/2023', 'DD/MM/YYYY'));
INSERT INTO RECEBE (MATRICULA_PROFESSOR, CODIGO_SALARIO, DATA) VALUES (2, 3, TO_DATE('05/06/2023', 'DD/MM/YYYY'));
INSERT INTO RECEBE (MATRICULA_PROFESSOR, CODIGO_SALARIO, DATA) VALUES (2, 3, TO_DATE('05/07/2023', 'DD/MM/YYYY'));
INSERT INTO RECEBE (MATRICULA_PROFESSOR, CODIGO_SALARIO, DATA) VALUES (2, 3, TO_DATE('05/08/2023', 'DD/MM/YYYY'));
INSERT INTO RECEBE (MATRICULA_PROFESSOR, CODIGO_SALARIO, DATA) VALUES (2, 3, TO_DATE('05/09/2023', 'DD/MM/YYYY'));
INSERT INTO RECEBE (MATRICULA_PROFESSOR, CODIGO_SALARIO, DATA) VALUES (2, 3, TO_DATE('05/10/2023', 'DD/MM/YYYY'));
INSERT INTO RECEBE (MATRICULA_PROFESSOR, CODIGO_SALARIO, DATA) VALUES (2, 3, TO_DATE('05/11/2023', 'DD/MM/YYYY'));
INSERT INTO RECEBE (MATRICULA_PROFESSOR, CODIGO_SALARIO, DATA, CODIGO_BONUS) VALUES (2, 3, TO_DATE('05/12/2023', 'DD/MM/YYYY'), 2);

INSERT INTO RECEBE (MATRICULA_PROFESSOR, CODIGO_SALARIO, DATA) VALUES (3, 2, TO_DATE('05/01/2023', 'DD/MM/YYYY'));
INSERT INTO RECEBE (MATRICULA_PROFESSOR, CODIGO_SALARIO, DATA) VALUES (3, 2, TO_DATE('05/02/2023', 'DD/MM/YYYY'));
INSERT INTO RECEBE (MATRICULA_PROFESSOR, CODIGO_SALARIO, DATA) VALUES (3, 2, TO_DATE('05/03/2023', 'DD/MM/YYYY'));
INSERT INTO RECEBE (MATRICULA_PROFESSOR, CODIGO_SALARIO, DATA) VALUES (3, 2, TO_DATE('05/04/2023', 'DD/MM/YYYY'));
INSERT INTO RECEBE (MATRICULA_PROFESSOR, CODIGO_SALARIO, DATA) VALUES (3, 2, TO_DATE('05/05/2023', 'DD/MM/YYYY'));
INSERT INTO RECEBE (MATRICULA_PROFESSOR, CODIGO_SALARIO, DATA) VALUES (3, 2, TO_DATE('05/06/2023', 'DD/MM/YYYY'));
INSERT INTO RECEBE (MATRICULA_PROFESSOR, CODIGO_SALARIO, DATA) VALUES (3, 2, TO_DATE('05/07/2023', 'DD/MM/YYYY'));
INSERT INTO RECEBE (MATRICULA_PROFESSOR, CODIGO_SALARIO, DATA) VALUES (3, 2, TO_DATE('05/08/2023', 'DD/MM/YYYY'));
INSERT INTO RECEBE (MATRICULA_PROFESSOR, CODIGO_SALARIO, DATA) VALUES (3, 2, TO_DATE('05/09/2023', 'DD/MM/YYYY'));
INSERT INTO RECEBE (MATRICULA_PROFESSOR, CODIGO_SALARIO, DATA) VALUES (3, 2, TO_DATE('05/10/2023', 'DD/MM/YYYY'));
INSERT INTO RECEBE (MATRICULA_PROFESSOR, CODIGO_SALARIO, DATA) VALUES (3, 2, TO_DATE('05/11/2023', 'DD/MM/YYYY'));
INSERT INTO RECEBE (MATRICULA_PROFESSOR, CODIGO_SALARIO, DATA, CODIGO_BONUS) VALUES (3, 2, TO_DATE('05/12/2023', 'DD/MM/YYYY'), 2);

INSERT INTO RECEBE (MATRICULA_PROFESSOR, CODIGO_SALARIO, DATA) VALUES (4, 2, TO_DATE('05/01/2023', 'DD/MM/YYYY'));
INSERT INTO RECEBE (MATRICULA_PROFESSOR, CODIGO_SALARIO, DATA) VALUES (4, 2, TO_DATE('05/02/2023', 'DD/MM/YYYY'));
INSERT INTO RECEBE (MATRICULA_PROFESSOR, CODIGO_SALARIO, DATA) VALUES (4, 2, TO_DATE('05/03/2023', 'DD/MM/YYYY'));
INSERT INTO RECEBE (MATRICULA_PROFESSOR, CODIGO_SALARIO, DATA) VALUES (4, 2, TO_DATE('05/04/2023', 'DD/MM/YYYY'));
INSERT INTO RECEBE (MATRICULA_PROFESSOR, CODIGO_SALARIO, DATA) VALUES (4, 2, TO_DATE('05/05/2023', 'DD/MM/YYYY'));
INSERT INTO RECEBE (MATRICULA_PROFESSOR, CODIGO_SALARIO, DATA) VALUES (4, 2, TO_DATE('05/06/2023', 'DD/MM/YYYY'));
INSERT INTO RECEBE (MATRICULA_PROFESSOR, CODIGO_SALARIO, DATA) VALUES (4, 2, TO_DATE('05/07/2023', 'DD/MM/YYYY'));
INSERT INTO RECEBE (MATRICULA_PROFESSOR, CODIGO_SALARIO, DATA) VALUES (4, 2, TO_DATE('05/08/2023', 'DD/MM/YYYY'));
INSERT INTO RECEBE (MATRICULA_PROFESSOR, CODIGO_SALARIO, DATA) VALUES (4, 2, TO_DATE('05/09/2023', 'DD/MM/YYYY'));
INSERT INTO RECEBE (MATRICULA_PROFESSOR, CODIGO_SALARIO, DATA) VALUES (4, 2, TO_DATE('05/10/2023', 'DD/MM/YYYY'));
INSERT INTO RECEBE (MATRICULA_PROFESSOR, CODIGO_SALARIO, DATA) VALUES (4, 2, TO_DATE('05/11/2023', 'DD/MM/YYYY'));
INSERT INTO RECEBE (MATRICULA_PROFESSOR, CODIGO_SALARIO, DATA, CODIGO_BONUS) VALUES (4, 2, TO_DATE('05/12/2023', 'DD/MM/YYYY'), 2);

INSERT INTO RECEBE (MATRICULA_PROFESSOR, CODIGO_SALARIO, DATA) VALUES (5, 2, TO_DATE('05/01/2023', 'DD/MM/YYYY'));
INSERT INTO RECEBE (MATRICULA_PROFESSOR, CODIGO_SALARIO, DATA) VALUES (5, 2, TO_DATE('05/02/2023', 'DD/MM/YYYY'));
INSERT INTO RECEBE (MATRICULA_PROFESSOR, CODIGO_SALARIO, DATA) VALUES (5, 2, TO_DATE('05/03/2023', 'DD/MM/YYYY'));
INSERT INTO RECEBE (MATRICULA_PROFESSOR, CODIGO_SALARIO, DATA) VALUES (5, 2, TO_DATE('05/04/2023', 'DD/MM/YYYY'));
INSERT INTO RECEBE (MATRICULA_PROFESSOR, CODIGO_SALARIO, DATA) VALUES (5, 2, TO_DATE('05/05/2023', 'DD/MM/YYYY'));
INSERT INTO RECEBE (MATRICULA_PROFESSOR, CODIGO_SALARIO, DATA) VALUES (5, 2, TO_DATE('05/06/2023', 'DD/MM/YYYY'));
INSERT INTO RECEBE (MATRICULA_PROFESSOR, CODIGO_SALARIO, DATA) VALUES (5, 2, TO_DATE('05/07/2023', 'DD/MM/YYYY'));
INSERT INTO RECEBE (MATRICULA_PROFESSOR, CODIGO_SALARIO, DATA) VALUES (5, 2, TO_DATE('05/08/2023', 'DD/MM/YYYY'));
INSERT INTO RECEBE (MATRICULA_PROFESSOR, CODIGO_SALARIO, DATA) VALUES (5, 2, TO_DATE('05/09/2023', 'DD/MM/YYYY'));
INSERT INTO RECEBE (MATRICULA_PROFESSOR, CODIGO_SALARIO, DATA) VALUES (5, 2, TO_DATE('05/10/2023', 'DD/MM/YYYY'));
INSERT INTO RECEBE (MATRICULA_PROFESSOR, CODIGO_SALARIO, DATA) VALUES (5, 2, TO_DATE('05/11/2023', 'DD/MM/YYYY'));
INSERT INTO RECEBE (MATRICULA_PROFESSOR, CODIGO_SALARIO, DATA, CODIGO_BONUS) VALUES (5, 2, TO_DATE('05/12/2023', 'DD/MM/YYYY'), 2);

INSERT INTO RECEBE (MATRICULA_PROFESSOR, CODIGO_SALARIO, DATA) VALUES (6, 1, TO_DATE('05/01/2023', 'DD/MM/YYYY'));
INSERT INTO RECEBE (MATRICULA_PROFESSOR, CODIGO_SALARIO, DATA) VALUES (6, 1, TO_DATE('05/02/2023', 'DD/MM/YYYY'));
INSERT INTO RECEBE (MATRICULA_PROFESSOR, CODIGO_SALARIO, DATA, CODIGO_BONUS) VALUES (6, 1, TO_DATE('05/03/2023', 'DD/MM/YYYY'), 1);
INSERT INTO RECEBE (MATRICULA_PROFESSOR, CODIGO_SALARIO, DATA) VALUES (6, 1, TO_DATE('05/04/2023', 'DD/MM/YYYY'));
INSERT INTO RECEBE (MATRICULA_PROFESSOR, CODIGO_SALARIO, DATA) VALUES (6, 1, TO_DATE('05/05/2023', 'DD/MM/YYYY'));
INSERT INTO RECEBE (MATRICULA_PROFESSOR, CODIGO_SALARIO, DATA) VALUES (6, 1, TO_DATE('05/06/2023', 'DD/MM/YYYY'));
INSERT INTO RECEBE (MATRICULA_PROFESSOR, CODIGO_SALARIO, DATA) VALUES (6, 1, TO_DATE('05/07/2023', 'DD/MM/YYYY'));
INSERT INTO RECEBE (MATRICULA_PROFESSOR, CODIGO_SALARIO, DATA) VALUES (6, 1, TO_DATE('05/08/2023', 'DD/MM/YYYY'));
INSERT INTO RECEBE (MATRICULA_PROFESSOR, CODIGO_SALARIO, DATA) VALUES (6, 1, TO_DATE('05/09/2023', 'DD/MM/YYYY'));
INSERT INTO RECEBE (MATRICULA_PROFESSOR, CODIGO_SALARIO, DATA) VALUES (6, 1, TO_DATE('05/10/2023', 'DD/MM/YYYY'));
INSERT INTO RECEBE (MATRICULA_PROFESSOR, CODIGO_SALARIO, DATA) VALUES (6, 1, TO_DATE('05/11/2023', 'DD/MM/YYYY'));
INSERT INTO RECEBE (MATRICULA_PROFESSOR, CODIGO_SALARIO, DATA, CODIGO_BONUS) VALUES (6, 1, TO_DATE('05/12/2023', 'DD/MM/YYYY'), 2);

INSERT INTO RECEBE (MATRICULA_PROFESSOR, CODIGO_SALARIO, DATA) VALUES (7, 1, TO_DATE('05/01/2023', 'DD/MM/YYYY'));
INSERT INTO RECEBE (MATRICULA_PROFESSOR, CODIGO_SALARIO, DATA) VALUES (7, 1, TO_DATE('05/02/2023', 'DD/MM/YYYY'));
INSERT INTO RECEBE (MATRICULA_PROFESSOR, CODIGO_SALARIO, DATA) VALUES (7, 1, TO_DATE('05/03/2023', 'DD/MM/YYYY'));
INSERT INTO RECEBE (MATRICULA_PROFESSOR, CODIGO_SALARIO, DATA) VALUES (7, 1, TO_DATE('05/04/2023', 'DD/MM/YYYY'));
INSERT INTO RECEBE (MATRICULA_PROFESSOR, CODIGO_SALARIO, DATA) VALUES (7, 1, TO_DATE('05/05/2023', 'DD/MM/YYYY'));
INSERT INTO RECEBE (MATRICULA_PROFESSOR, CODIGO_SALARIO, DATA) VALUES (7, 1, TO_DATE('05/06/2023', 'DD/MM/YYYY'));
INSERT INTO RECEBE (MATRICULA_PROFESSOR, CODIGO_SALARIO, DATA) VALUES (7, 1, TO_DATE('05/07/2023', 'DD/MM/YYYY'));
INSERT INTO RECEBE (MATRICULA_PROFESSOR, CODIGO_SALARIO, DATA, CODIGO_BONUS) VALUES (7, 1, TO_DATE('05/08/2023', 'DD/MM/YYYY'), 1);
INSERT INTO RECEBE (MATRICULA_PROFESSOR, CODIGO_SALARIO, DATA) VALUES (7, 1, TO_DATE('05/09/2023', 'DD/MM/YYYY'));
INSERT INTO RECEBE (MATRICULA_PROFESSOR, CODIGO_SALARIO, DATA) VALUES (7, 1, TO_DATE('05/10/2023', 'DD/MM/YYYY'));
INSERT INTO RECEBE (MATRICULA_PROFESSOR, CODIGO_SALARIO, DATA) VALUES (7, 1, TO_DATE('05/11/2023', 'DD/MM/YYYY'));
INSERT INTO RECEBE (MATRICULA_PROFESSOR, CODIGO_SALARIO, DATA, CODIGO_BONUS) VALUES (7, 1, TO_DATE('05/12/2023', 'DD/MM/YYYY'), 2);

--POVOAR ALUNO
INSERT INTO ALUNO (MATRICULA, NOME, CPF, NASCIMENTO, TURMA, CURSO_MEDIO, CNPJ_INSTITUICAO) 
VALUES (1, 'Renato Andrade', '1214', TO_DATE('05/11/2005', 'DD/MM/YYYY'), 1, 'ADMINISTRACAO', '1234');
INSERT INTO ALUNO (MATRICULA, NOME, CPF, NASCIMENTO, TURMA, CURSO_MEDIO, CNPJ_INSTITUICAO) 
VALUES (2, 'Maria Silva', '2345', TO_DATE('10/03/2005', 'DD/MM/YYYY'), 1, 'ADMINISTRACAO', '1234');
INSERT INTO ALUNO (MATRICULA, NOME, CPF, NASCIMENTO, TURMA, CURSO_MEDIO, CNPJ_INSTITUICAO) 
VALUES (3, 'João Oliveira', '3456', TO_DATE('15/07/2005', 'DD/MM/YYYY'), 1, 'ADMINISTRACAO', '1234');
INSERT INTO ALUNO (MATRICULA, NOME, CPF, NASCIMENTO, TURMA, CURSO_MEDIO, CNPJ_INSTITUICAO) 
VALUES (4, 'Ana Santos', '4567', TO_DATE('20/09/2005', 'DD/MM/YYYY'), 1, 'ADMINISTRACAO', '1234');
INSERT INTO ALUNO (MATRICULA, NOME, CPF, NASCIMENTO, TURMA, CURSO_MEDIO, CNPJ_INSTITUICAO) 
VALUES (5, 'Pedro Lima', '5678', TO_DATE('25/12/2005', 'DD/MM/YYYY'), 1, 'ADMINISTRACAO', '1234');
INSERT INTO ALUNO (MATRICULA, NOME, CPF, NASCIMENTO, TURMA, CURSO_MEDIO, CNPJ_INSTITUICAO) 
VALUES (6, 'Carla Pereira', '6789', TO_DATE('01/05/2005', 'DD/MM/YYYY'), 1, 'ADMINISTRACAO', '1234');
INSERT INTO ALUNO (MATRICULA, NOME, CPF, NASCIMENTO, TURMA, CURSO_MEDIO, CNPJ_INSTITUICAO) 
VALUES (7, 'Felipe Sousa', '7890', TO_DATE('08/08/2005', 'DD/MM/YYYY'), 1, 'ADMINISTRACAO', '1234');
INSERT INTO ALUNO (MATRICULA, NOME, CPF, NASCIMENTO, TURMA, CURSO_MEDIO, CNPJ_INSTITUICAO) 
VALUES (8, 'Larissa Costa', '8901', TO_DATE('17/10/2005', 'DD/MM/YYYY'), 1, 'ADMINISTRACAO', '1234');
INSERT INTO ALUNO (MATRICULA, NOME, CPF, NASCIMENTO, TURMA, CURSO_MEDIO, CNPJ_INSTITUICAO) 
VALUES (9, 'Lucas Santos', '9012', TO_DATE('23/04/2005', 'DD/MM/YYYY'), 1, 'ADMINISTRACAO', '1234');
INSERT INTO ALUNO (MATRICULA, NOME, CPF, NASCIMENTO, TURMA, CURSO_MEDIO, CNPJ_INSTITUICAO) 
VALUES (10, 'Juliana Oliveira', '0123', TO_DATE('30/06/2005', 'DD/MM/YYYY'), 1, 'ADMINISTRACAO', '1234');

INSERT INTO ALUNO (MATRICULA, NOME, CPF, NASCIMENTO, TURMA, CNPJ_INSTITUICAO) 
VALUES (11, 'Rafaela Souza', '4561', TO_DATE('17/02/2008', 'DD/MM/YYYY'), 2, '1234');
INSERT INTO ALUNO (MATRICULA, NOME, CPF, NASCIMENTO, TURMA, CNPJ_INSTITUICAO) 
VALUES (12, 'Felipe Oliveira', '2349', TO_DATE('21/04/2008', 'DD/MM/YYYY'), 2, '1234');
INSERT INTO ALUNO (MATRICULA, NOME, CPF, NASCIMENTO, TURMA, CNPJ_INSTITUICAO) 
VALUES (13, 'Carolina Costa', '7892', TO_DATE('03/06/2008', 'DD/MM/YYYY'), 2, '1234');
INSERT INTO ALUNO (MATRICULA, NOME, CPF, NASCIMENTO, TURMA, CNPJ_INSTITUICAO) 
VALUES (14, 'Gustavo Santos', '8912', TO_DATE('15/09/2008', 'DD/MM/YYYY'), 2, '1234');
INSERT INTO ALUNO (MATRICULA, NOME, CPF, NASCIMENTO, TURMA, CNPJ_INSTITUICAO) 
VALUES (15, 'Julia Lima', '1239', TO_DATE('29/10/2008', 'DD/MM/YYYY'), 2, '1234');
INSERT INTO ALUNO (MATRICULA, NOME, CPF, NASCIMENTO, TURMA, CNPJ_INSTITUICAO) 
VALUES (16, 'Lucas Oliveira', '5673', TO_DATE('04/12/2008', 'DD/MM/YYYY'), 2, '1234');
INSERT INTO ALUNO (MATRICULA, NOME, CPF, NASCIMENTO, TURMA, CNPJ_INSTITUICAO) 
VALUES (17, 'Beatriz Silva', '8904', TO_DATE('12/03/2008', 'DD/MM/YYYY'), 2, '1234');
INSERT INTO ALUNO (MATRICULA, NOME, CPF, NASCIMENTO, TURMA, CNPJ_INSTITUICAO) 
VALUES (18, 'Marcos Santos', '4321', TO_DATE('26/05/2008', 'DD/MM/YYYY'), 2, '1234');
INSERT INTO ALUNO (MATRICULA, NOME, CPF, NASCIMENTO, TURMA, CNPJ_INSTITUICAO) 
VALUES (19, 'Amanda Pereira', '0987', TO_DATE('08/08/2008', 'DD/MM/YYYY'), 2, '1234');
INSERT INTO ALUNO (MATRICULA, NOME, CPF, NASCIMENTO, TURMA, CNPJ_INSTITUICAO) 
VALUES (20, 'Pedro Oliveira', '6543', TO_DATE('14/11/2008', 'DD/MM/YYYY'), 2, '1234');

INSERT INTO ALUNO (MATRICULA, NOME, CPF, NASCIMENTO, TURMA, CNPJ_INSTITUICAO) 
VALUES (21, 'Isabela Lima', '7896', TO_DATE('17/02/2007', 'DD/MM/YYYY'), 3, '1234');
INSERT INTO ALUNO (MATRICULA, NOME, CPF, NASCIMENTO, TURMA, CNPJ_INSTITUICAO) 
VALUES (22, 'Ricardo Oliveira', '3452', TO_DATE('21/04/2007', 'DD/MM/YYYY'), 3, '1234');
INSERT INTO ALUNO (MATRICULA, NOME, CPF, NASCIMENTO, TURMA, CNPJ_INSTITUICAO) 
VALUES (23, 'Camila Santos', '9018', TO_DATE('03/06/2007', 'DD/MM/YYYY'), 3, '1234');
INSERT INTO ALUNO (MATRICULA, NOME, CPF, NASCIMENTO, TURMA, CNPJ_INSTITUICAO) 
VALUES (24, 'Vinicius Silva', '2346', TO_DATE('15/09/2007', 'DD/MM/YYYY'), 3, '1234');
INSERT INTO ALUNO (MATRICULA, NOME, CPF, NASCIMENTO, TURMA, CNPJ_INSTITUICAO) 
VALUES (25, 'Laura Costa', '5679', TO_DATE('29/10/2007', 'DD/MM/YYYY'), 3, '1234');
INSERT INTO ALUNO (MATRICULA, NOME, CPF, NASCIMENTO, TURMA, CNPJ_INSTITUICAO) 
VALUES (26, 'Gabriel Pereira', '8903', TO_DATE('04/12/2007', 'DD/MM/YYYY'), 3, '1234');
INSERT INTO ALUNO (MATRICULA, NOME, CPF, NASCIMENTO, TURMA, CNPJ_INSTITUICAO) 
VALUES (27, 'Aline Oliveira', '1238', TO_DATE('12/03/2007', 'DD/MM/YYYY'), 3, '1234');
INSERT INTO ALUNO (MATRICULA, NOME, CPF, NASCIMENTO, TURMA, CNPJ_INSTITUICAO) 
VALUES (28, 'Matheus Santos', '4326', TO_DATE('26/05/2007', 'DD/MM/YYYY'), 3, '1234');
INSERT INTO ALUNO (MATRICULA, NOME, CPF, NASCIMENTO, TURMA, CNPJ_INSTITUICAO) 
VALUES (29, 'Isadora Silva', '0984', TO_DATE('08/08/2007', 'DD/MM/YYYY'), 3, '1234');
INSERT INTO ALUNO (MATRICULA, NOME, CPF, NASCIMENTO, TURMA, CNPJ_INSTITUICAO) 
VALUES (30, 'Luiz Oliveira', '6542', TO_DATE('14/11/2007', 'DD/MM/YYYY'), 3, '1234');

--POVOAR ARMARIO
INSERT INTO ARMARIO (MATRICULA_ALUNO, LOCALIZACAO, TAMANHO) VALUES (1, 'TERREO', 'GRANDE');
INSERT INTO ARMARIO (MATRICULA_ALUNO, LOCALIZACAO, TAMANHO) VALUES (2, 'TERREO', 'GRANDE');
INSERT INTO ARMARIO (MATRICULA_ALUNO, LOCALIZACAO, TAMANHO) VALUES (3, 'TERREO', 'GRANDE');
INSERT INTO ARMARIO (MATRICULA_ALUNO, LOCALIZACAO, TAMANHO) VALUES (4, 'TERREO', 'GRANDE');
INSERT INTO ARMARIO (MATRICULA_ALUNO, LOCALIZACAO, TAMANHO) VALUES (5, 'TERREO', 'GRANDE');
INSERT INTO ARMARIO (MATRICULA_ALUNO, LOCALIZACAO, TAMANHO) VALUES (6, 'TERREO', 'GRANDE');
INSERT INTO ARMARIO (MATRICULA_ALUNO, LOCALIZACAO, TAMANHO) VALUES (7, 'TERREO', 'GRANDE');
INSERT INTO ARMARIO (MATRICULA_ALUNO, LOCALIZACAO, TAMANHO) VALUES (8, 'TERREO', 'GRANDE');
INSERT INTO ARMARIO (MATRICULA_ALUNO, LOCALIZACAO, TAMANHO) VALUES (9, 'TERREO', 'GRANDE');
INSERT INTO ARMARIO (MATRICULA_ALUNO, LOCALIZACAO, TAMANHO) VALUES (10, 'TERREO', 'GRANDE');

INSERT INTO ARMARIO (MATRICULA_ALUNO, LOCALIZACAO, TAMANHO) VALUES (11, 'PRIMEIRO ANDAR', 'MEDIO');
INSERT INTO ARMARIO (MATRICULA_ALUNO, LOCALIZACAO, TAMANHO) VALUES (12, 'PRIMEIRO ANDAR', 'MEDIO');
INSERT INTO ARMARIO (MATRICULA_ALUNO, LOCALIZACAO, TAMANHO) VALUES (13, 'PRIMEIRO ANDAR', 'MEDIO');
INSERT INTO ARMARIO (MATRICULA_ALUNO, LOCALIZACAO, TAMANHO) VALUES (14, 'PRIMEIRO ANDAR', 'MEDIO');
INSERT INTO ARMARIO (MATRICULA_ALUNO, LOCALIZACAO, TAMANHO) VALUES (15, 'PRIMEIRO ANDAR', 'MEDIO');
INSERT INTO ARMARIO (MATRICULA_ALUNO, LOCALIZACAO, TAMANHO) VALUES (16, 'PRIMEIRO ANDAR', 'MEDIO');
INSERT INTO ARMARIO (MATRICULA_ALUNO, LOCALIZACAO, TAMANHO) VALUES (17, 'PRIMEIRO ANDAR', 'MEDIO');
INSERT INTO ARMARIO (MATRICULA_ALUNO, LOCALIZACAO, TAMANHO) VALUES (18, 'PRIMEIRO ANDAR', 'MEDIO');
INSERT INTO ARMARIO (MATRICULA_ALUNO, LOCALIZACAO, TAMANHO) VALUES (19, 'PRIMEIRO ANDAR', 'MEDIO');
INSERT INTO ARMARIO (MATRICULA_ALUNO, LOCALIZACAO, TAMANHO) VALUES (20, 'PRIMEIRO ANDAR', 'MEDIO');

INSERT INTO ARMARIO (MATRICULA_ALUNO, LOCALIZACAO, TAMANHO) VALUES (21, 'SEGUNDO ANDAR', 'PEQUENO');
INSERT INTO ARMARIO (MATRICULA_ALUNO, LOCALIZACAO, TAMANHO) VALUES (22, 'SEGUNDO ANDAR', 'PEQUENO');
INSERT INTO ARMARIO (MATRICULA_ALUNO, LOCALIZACAO, TAMANHO) VALUES (23, 'SEGUNDO ANDAR', 'PEQUENO');
INSERT INTO ARMARIO (MATRICULA_ALUNO, LOCALIZACAO, TAMANHO) VALUES (24, 'SEGUNDO ANDAR', 'PEQUENO');
INSERT INTO ARMARIO (MATRICULA_ALUNO, LOCALIZACAO, TAMANHO) VALUES (25, 'SEGUNDO ANDAR', 'PEQUENO');
INSERT INTO ARMARIO (MATRICULA_ALUNO, LOCALIZACAO, TAMANHO) VALUES (26, 'SEGUNDO ANDAR', 'PEQUENO');
INSERT INTO ARMARIO (MATRICULA_ALUNO, LOCALIZACAO, TAMANHO) VALUES (27, 'SEGUNDO ANDAR', 'PEQUENO');
INSERT INTO ARMARIO (MATRICULA_ALUNO, LOCALIZACAO, TAMANHO) VALUES (28, 'SEGUNDO ANDAR', 'PEQUENO');
INSERT INTO ARMARIO (MATRICULA_ALUNO, LOCALIZACAO, TAMANHO) VALUES (29, 'SEGUNDO ANDAR', 'PEQUENO');
INSERT INTO ARMARIO (MATRICULA_ALUNO, LOCALIZACAO, TAMANHO) VALUES (30, 'SEGUNDO ANDAR', 'PEQUENO');


