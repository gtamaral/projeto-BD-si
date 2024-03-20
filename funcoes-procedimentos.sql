--FUNÇÕES E PROCEDIMENTOS


--FUNÇÕES--


–-FUNÇÃO QUE RECEBE O CÓDIGO DA TURMA E RETORNA A QUANTIDADE DE ALUNOS DESSA TURMA

CREATE OR REPLACE FUNCTION quantidade_alunos(codigo_turma IN NUMBER) 
RETURN VARCHAR2
IS
    quantidade NUMBER := 0;
    resultado VARCHAR2(100);
BEGIN
    SELECT COUNT(*) INTO quantidade
    FROM ALUNO
    WHERE TURMA = codigo_turma;
    
    resultado := 'A turma ' || codigo_turma || ' tem ' || quantidade || ' aluno(s).';
    
    RETURN resultado;
END;

–Exemplo de chamada de função: SELECT quantidade_alunos(1) FROM DUAL; 



--Função que recebe o cpf do professor e retorna o seu nome e a sua idade

CREATE OR REPLACE FUNCTION calcular_idade_prof(cpf_professor VARCHAR2)
RETURN VARCHAR2
IS
    nome_professor VARCHAR2(100);
    idade_professor NUMBER;
    resultado VARCHAR2(200);

BEGIN
    SELECT NOME, EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM NASCIMENTO) INTO nome_professor, idade_professor
    FROM PROFESSOR
    WHERE CPF = cpf_professor;

    resultado := 'Nome: ' || nome_professor || ', Idade: ' || idade_professor;
    RETURN resultado;
END;

--Exemplo de chamada da função: SELECT calcular_idade_prof (54321) AS IDADE_PROFESSOR FROM DUAL;



-- Função para calcular o número de disciplinas que um professor ensina:

CREATE OR REPLACE FUNCTION contar_disciplinas_professor(matricula_prof IN NUMBER)
RETURN VARCHAR2
IS
    nome_professor Professor.nome%TYPE;
    num_disciplinas NUMBER := 0;
    resultado VARCHAR2(200);
BEGIN
    SELECT p.nome, COUNT(*) INTO nome_professor, num_disciplinas
    FROM PROFESSOR p
    JOIN ENSINA e ON p.matricula = e.matricula
    WHERE p.matricula = matricula_prof
    GROUP BY p.nome;
    
    resultado := 'O professor ' || nome_professor || ' ensina ' || num_disciplinas || ' disciplina(s).';
    
    RETURN resultado;
END;

--Exemplo de chamada: SELECT contar_disciplinas_professor(123) AS total_disciplinas FROM DUAL;


-- Função: Calcular a Média de Carga Horária das Matérias de uma Série

CREATE OR REPLACE FUNCTION media_carga_horaria_serie(serie_in VARCHAR2)
RETURN NUMBER
IS
    media_carga_horaria NUMBER;
BEGIN
    SELECT AVG(carga_horaria) INTO media_carga_horaria
    FROM MATERIA
    WHERE SERIE = serie_in;
    
    RETURN media_carga_horaria;
END;

-- Exemplo de chamada: SELECT media_carga_horaria_serie('1EM') AS MEDIA_CARGA_HORARIA FROM DUAL;



--PROCEDIMENTOS--

–-RECEBE MATRÍCULA DO PROFESSOR E LISTA TODAS AS DATAS E SALÁRIOS QUE JÁ RECEBEU

CREATE OR REPLACE PROCEDURE listar_salario_professor(p_matricula IN NUMBER)
IS
  nome_professor PROFESSOR.NOME%TYPE;
BEGIN
  SELECT NOME INTO nome_professor
  FROM PROFESSOR
  WHERE MATRICULA = p_matricula;

  DBMS_OUTPUT.PUT_LINE('Nome do Professor: ' || nome_professor);

  FOR r_salario IN (SELECT DATA, VALOR
                    FROM RECEBE R JOIN SALARIO_PROFESSORES S ON R.CODIGO_SALARIO = S.CODIGO
                    WHERE MATRICULA_PROFESSOR = p_matricula
                    ORDER BY DATA)
  LOOP
    DBMS_OUTPUT.PUT_LINE('Data de Recebimento do Salário: ' || TO_CHAR(r_salario.DATA, 'DD/MM/YYYY'));
    DBMS_OUTPUT.PUT_LINE('Salário Recebido: R$ ' || r_salario.VALOR);
  END LOOP;
END;

--Exemplo de chamada:
BEGIN
 listar_salario_professor(1);
END;


--Procedimento para inserir dados na tabela aluno.

CREATE OR REPLACE PROCEDURE inserir_aluno(
    matricula_aluno IN NUMBER,
    nome_aluno IN VARCHAR2,
    cpf_aluno IN VARCHAR2,
    nascimento_aluno IN DATE,
    turma_aluno IN NUMBER,
    curso_medio_aluno IN VARCHAR2,
    cnpj_instituicao_aluno IN VARCHAR2
)
IS
BEGIN
    INSERT INTO ALUNO (MATRICULA, NOME, CPF, NASCIMENTO, TURMA, CURSO_MEDIO, CNPJ_INSTITUICAO)
    VALUES (matricula_aluno, nome_aluno, cpf_aluno, nascimento_aluno, turma_aluno, curso_medio_aluno, cnpj_instituicao_aluno);
    COMMIT;
END;

--Exemplo de chamada: 
BEGIN 
inserir_aluno(70,'Marina Souza','9981',TO_DATE('25/04/2008','DD/MM/YYYY'),4,'','1234');
END;


--Procedimento que torna o nome de todas as matérias de uma turma:


CREATE OR REPLACE PROCEDURE listar_materias_turma(
    codigo_turma IN NUMBER
)
IS
    nome_turma VARCHAR2(100);
BEGIN
    SELECT nome INTO nome_turma
    FROM TURMA
    WHERE codigo = codigo_turma;
    
    DBMS_OUTPUT.PUT_LINE('Matérias da turma ' || nome_turma || ':');
    
    FOR materia_rec IN (SELECT DISTINCT m.nome
                        FROM MATERIA m
                        JOIN POSSUI p ON m.codigo = p.codigo_materia
                        WHERE p.codigo_turma = codigo_turma)
    LOOP
        DBMS_OUTPUT.PUT_LINE('- ' || materia_rec.nome);
    END LOOP;
END;

--Exemplo de chamada:

BEGIN
    listar_materias_turma(123);
END;


--Procedimento para atualizar a carga horária de uma matéria:

CREATE OR REPLACE PROCEDURE atualizar_carga_horaria(
    p_codigo_materia IN NUMBER,
    nova_carga_horaria IN NUMBER
)
IS
BEGIN
    UPDATE MATERIA
    SET CARGA_HORARIA = nova_carga_horaria
    WHERE CODIGO = p_codigo_materia;
    
    COMMIT;
    
    DBMS_OUTPUT.PUT_LINE('Carga horária atualizada com sucesso para a matéria de código ' || p_codigo_materia || '.');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro ao atualizar a carga horária: ' || SQLERRM);
        ROLLBACK;
END;

--Exemplo de chamada:
BEGIN
    atualizar_carga_horaria(1, 100);
END;


