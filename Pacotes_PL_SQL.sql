REM   Script: Packages
REM   O projeto foi desenvolvido para consolidar o conhecimento sobre manipulação de dados no Oracle usando PL/SQL. O script abrange operações como exclusão de registros, listagem com filtros, cálculos de médias, e outras tarefas relacionadas a entidades de um sistema acadêmico.

CREATE TABLE DISCIPLINAS ( 
    ID_DISCIPLINA NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY, -- Identificador único 
    NOME_DISCIPLINA VARCHAR2(100) NOT NULL, -- Nome da disciplina 
    DESCRICAO VARCHAR2(255), -- Descrição da disciplina 
    CARGA_HORARIA NUMBER NOT NULL -- Carga horária da disciplina 
);

CREATE TABLE ALUNOS ( 
    ID_ALUNO NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY, -- Identificador único 
    NOME VARCHAR2(100) NOT NULL, -- Nome do aluno 
    DATA_NASCIMENTO DATE NOT NULL, -- Data de nascimento 
    ID_CURSO NUMBER -- Curso ao qual o aluno está vinculado (se houver) 
);

CREATE TABLE DISCIPLINAS ( 
    ID_DISCIPLINA NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY, -- Identificador único 
    NOME_DISCIPLINA VARCHAR2(100) NOT NULL, -- Nome da disciplina 
    DESCRICAO VARCHAR2(255), -- Descrição da disciplina 
    CARGA_HORARIA NUMBER NOT NULL -- Carga horária da disciplina 
);

CREATE TABLE PROFESSORES ( 
    ID_PROFESSOR NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY, -- Identificador único 
    NOME_PROFESSOR VARCHAR2(100) NOT NULL -- Nome do professor 
);

CREATE TABLE MATRICULAS ( 
    ID_MATRICULA NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY, -- Identificador único 
    ID_ALUNO NUMBER NOT NULL, -- ID do aluno matriculado 
    ID_DISCIPLINA NUMBER NOT NULL, -- ID da disciplina 
    DATA_MATRICULA DATE DEFAULT SYSDATE, -- Data da matrícula 
    FOREIGN KEY (ID_ALUNO) REFERENCES ALUNOS(ID_ALUNO) ON DELETE CASCADE, -- Chave estrangeira para Alunos 
    FOREIGN KEY (ID_DISCIPLINA) REFERENCES DISCIPLINAS(ID_DISCIPLINA) ON DELETE CASCADE -- Chave estrangeira para Disciplinas 
);

CREATE TABLE TURMAS ( 
    ID_TURMA NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY, -- Identificador único 
    ID_DISCIPLINA NUMBER NOT NULL, -- ID da disciplina da turma 
    ID_PROFESSOR NUMBER NOT NULL, -- ID do professor responsável 
    SEMESTRE VARCHAR2(10), -- Semestre da turma (ex: "2024/1") 
    FOREIGN KEY (ID_DISCIPLINA) REFERENCES DISCIPLINAS(ID_DISCIPLINA) ON DELETE CASCADE, -- Chave estrangeira para Disciplinas 
    FOREIGN KEY (ID_PROFESSOR) REFERENCES PROFESSORES(ID_PROFESSOR) ON DELETE CASCADE -- Chave estrangeira para Professores 
);

INSERT INTO ALUNOS (NOME, DATA_NASCIMENTO, ID_CURSO) VALUES ('João Silva', TO_DATE('2000-01-15', 'YYYY-MM-DD'), 1);

INSERT INTO ALUNOS (NOME, DATA_NASCIMENTO, ID_CURSO) VALUES ('Maria Oliveira', TO_DATE('2002-08-25', 'YYYY-MM-DD'), 1);

INSERT INTO ALUNOS (NOME, DATA_NASCIMENTO, ID_CURSO) VALUES ('Ana Souza', TO_DATE('1998-03-10', 'YYYY-MM-DD'), 2);

INSERT INTO ALUNOS (NOME, DATA_NASCIMENTO, ID_CURSO) VALUES ('Pedro Santos', TO_DATE('1995-07-05', 'YYYY-MM-DD'), 3);

SELECT * FROM ALUNOS;

INSERT INTO DISCIPLINAS (NOME_DISCIPLINA, DESCRICAO, CARGA_HORARIA) VALUES ('Matemática', 'Matemática básica e avançada', 60);

INSERT INTO DISCIPLINAS (NOME_DISCIPLINA, DESCRICAO, CARGA_HORARIA) VALUES ('Português', 'Gramática, literatura e redação', 50);

INSERT INTO DISCIPLINAS (NOME_DISCIPLINA, DESCRICAO, CARGA_HORARIA) VALUES ('História', 'História geral e do Brasil', 40);

INSERT INTO DISCIPLINAS (NOME_DISCIPLINA, DESCRICAO, CARGA_HORARIA) VALUES ('Geografia', 'Geografia física e política', 45);

SELECT * FROM DISCIPLINAS;

INSERT INTO TURMAS (ID_DISCIPLINA, ID_PROFESSOR, SEMESTRE) VALUES (1, 1, '2024/1');

INSERT INTO TURMAS (ID_DISCIPLINA, ID_PROFESSOR, SEMESTRE) VALUES (2, 2, '2024/1');

INSERT INTO TURMAS (ID_DISCIPLINA, ID_PROFESSOR, SEMESTRE) VALUES (3, 3, '2024/1');

INSERT INTO TURMAS (ID_DISCIPLINA, ID_PROFESSOR, SEMESTRE) VALUES (4, 4, '2024/1');

INSERT INTO TURMAS (ID_DISCIPLINA, ID_PROFESSOR, SEMESTRE) VALUES (2, 1, '2024/2');

INSERT INTO TURMAS (ID_DISCIPLINA, ID_PROFESSOR, SEMESTRE) VALUES (3, 2, '2024/2');

INSERT INTO PROFESSORES (NOME_PROFESSOR) VALUES ('Prof. Carlos Ferreira');

INSERT INTO PROFESSORES (NOME_PROFESSOR) VALUES ('Profª. Helena Martins');

INSERT INTO PROFESSORES (NOME_PROFESSOR) VALUES ('Prof. João Almeida');

INSERT INTO PROFESSORES (NOME_PROFESSOR) VALUES ('Profª. Cláudia Lima');

INSERT INTO MATRICULAS (ID_ALUNO, ID_DISCIPLINA, DATA_MATRICULA) VALUES (1, 1, TO_DATE('2024-01-10', 'YYYY-MM-DD'));

INSERT INTO MATRICULAS (ID_ALUNO, ID_DISCIPLINA, DATA_MATRICULA) VALUES (2, 2, TO_DATE('2024-01-12', 'YYYY-MM-DD'));

INSERT INTO MATRICULAS (ID_ALUNO, ID_DISCIPLINA, DATA_MATRICULA) VALUES (3, 3, TO_DATE('2024-01-15', 'YYYY-MM-DD'));

INSERT INTO MATRICULAS (ID_ALUNO, ID_DISCIPLINA, DATA_MATRICULA) VALUES (4, 4, TO_DATE('2024-01-18', 'YYYY-MM-DD'));

INSERT INTO MATRICULAS (ID_ALUNO, ID_DISCIPLINA, DATA_MATRICULA) VALUES (1, 2, TO_DATE('2024-01-20', 'YYYY-MM-DD'));

INSERT INTO MATRICULAS (ID_ALUNO, ID_DISCIPLINA, DATA_MATRICULA) VALUES (3, 1, TO_DATE('2024-01-22', 'YYYY-MM-DD'));

SELECT * FROM ALUNOS;

SELECT * FROM DISCIPLINAS;

SELECT * FROM PROFESSORES;

SELECT * FROM MATRICULAS;

SELECT * FROM TURMAS;

CREATE OR REPLACE PACKAGE PKG_ALUNO AS 
    PROCEDURE excluir_aluno(p_id_aluno IN NUMBER); 
    PROCEDURE listar_alunos_maiores; 
    PROCEDURE listar_alunos_por_curso(p_id_curso IN NUMBER); 
END PKG_ALUNO; 
/

CREATE OR REPLACE PACKAGE BODY PKG_ALUNO AS 
    -- Procedure para excluir aluno 
    PROCEDURE excluir_aluno(p_id_aluno IN NUMBER) IS 
    BEGIN 
        DELETE FROM MATRICULAS WHERE ID_ALUNO = p_id_aluno; 
        DELETE FROM ALUNOS WHERE ID_ALUNO = p_id_aluno; 
        COMMIT; 
        DBMS_OUTPUT.PUT_LINE('Aluno ' || p_id_aluno || ' excluído com sucesso.'); 
    EXCEPTION 
        WHEN OTHERS THEN 
            ROLLBACK; 
            DBMS_OUTPUT.PUT_LINE('Erro ao excluir aluno: ' || SQLERRM); 
    END excluir_aluno; 
 
    -- Procedure para listar alunos maiores de 18 anos 
    PROCEDURE listar_alunos_maiores IS 
        CURSOR c_maiores IS 
        SELECT NOME, DATA_NASCIMENTO 
        FROM ALUNOS 
        WHERE TRUNC(MONTHS_BETWEEN(SYSDATE, DATA_NASCIMENTO) / 12) > 18; 
        v_nome ALUNOS.NOME%TYPE; 
        v_data ALUNOS.DATA_NASCIMENTO%TYPE; 
    BEGIN 
        OPEN c_maiores; 
        LOOP 
            FETCH c_maiores INTO v_nome, v_data; 
            EXIT WHEN c_maiores%NOTFOUND; 
            DBMS_OUTPUT.PUT_LINE(v_nome || ' - Nascimento: ' || TO_CHAR(v_data, 'DD/MM/YYYY')); 
        END LOOP; 
        CLOSE c_maiores; 
    END listar_alunos_maiores; 
 
    -- Procedure para listar alunos por curso 
    PROCEDURE listar_alunos_por_curso(p_id_curso IN NUMBER) IS 
        CURSOR c_alunos IS 
        SELECT NOME 
        FROM ALUNOS 
        WHERE ID_CURSO = p_id_curso; 
        v_nome ALUNOS.NOME%TYPE; 
    BEGIN 
        OPEN c_alunos; 
        LOOP 
            FETCH c_alunos INTO v_nome; 
            EXIT WHEN c_alunos%NOTFOUND; 
            DBMS_OUTPUT.PUT_LINE('Aluno: ' || v_nome); 
        END LOOP; 
        CLOSE c_alunos; 
    END listar_alunos_por_curso; 
END PKG_ALUNO; 
/

CREATE OR REPLACE PACKAGE PKG_DISCIPLINA AS 
    PROCEDURE cadastrar_disciplina(p_nome IN VARCHAR2, p_desc IN VARCHAR2, p_carga IN NUMBER); 
    PROCEDURE listar_total_alunos_disciplina; 
    PROCEDURE media_idade_disciplina(p_id_disciplina IN NUMBER); 
    PROCEDURE listar_alunos_disciplina(p_id_disciplina IN NUMBER); 
END PKG_DISCIPLINA; 
/

CREATE OR REPLACE PACKAGE BODY PKG_DISCIPLINA AS 
    -- Procedure para cadastrar disciplina 
    PROCEDURE cadastrar_disciplina(p_nome IN VARCHAR2, p_desc IN VARCHAR2, p_carga IN NUMBER) IS 
    BEGIN 
        INSERT INTO DISCIPLINAS (NOME_DISCIPLINA, DESCRICAO, CARGA_HORARIA) 
        VALUES (p_nome, p_desc, p_carga); 
        COMMIT; 
        DBMS_OUTPUT.PUT_LINE('Disciplina ' || p_nome || ' cadastrada com sucesso.'); 
    END cadastrar_disciplina; 
 
    -- Cursor para listar disciplinas com mais de 10 alunos 
    PROCEDURE listar_total_alunos_disciplina IS 
        CURSOR c_disciplina IS 
        SELECT d.NOME_DISCIPLINA, COUNT(m.ID_ALUNO) AS TOTAL 
        FROM DISCIPLINAS d 
        JOIN MATRICULAS m ON d.ID_DISCIPLINA = m.ID_DISCIPLINA 
        GROUP BY d.NOME_DISCIPLINA 
        HAVING COUNT(m.ID_ALUNO) > 10; 
        v_nome DISCIPLINAS.NOME_DISCIPLINA%TYPE; 
        v_total NUMBER; 
    BEGIN 
        OPEN c_disciplina; 
        LOOP 
            FETCH c_disciplina INTO v_nome, v_total; 
            EXIT WHEN c_disciplina%NOTFOUND; 
            DBMS_OUTPUT.PUT_LINE(v_nome || ': ' || v_total || ' alunos.'); 
        END LOOP; 
        CLOSE c_disciplina; 
    END listar_total_alunos_disciplina; 
 
    -- Cursor para calcular a média de idade por disciplina 
    PROCEDURE media_idade_disciplina(p_id_disciplina IN NUMBER) IS 
        CURSOR c_media IS 
        SELECT AVG(TRUNC(MONTHS_BETWEEN(SYSDATE, a.DATA_NASCIMENTO) / 12)) AS MEDIA_IDADE 
        FROM ALUNOS a 
        JOIN MATRICULAS m ON a.ID_ALUNO = m.ID_ALUNO 
        WHERE m.ID_DISCIPLINA = p_id_disciplina; 
        v_media NUMBER; 
    BEGIN 
        OPEN c_media; 
        FETCH c_media INTO v_media; 
        DBMS_OUTPUT.PUT_LINE('Média de idade: ' || v_media); 
        CLOSE c_media; 
    END media_idade_disciplina; 
 
    -- Procedure para listar alunos de uma disciplina 
    PROCEDURE listar_alunos_disciplina(p_id_disciplina IN NUMBER) IS 
        CURSOR c_alunos IS 
        SELECT a.NOME 
        FROM ALUNOS a 
        JOIN MATRICULAS m ON a.ID_ALUNO = m.ID_ALUNO 
        WHERE m.ID_DISCIPLINA = p_id_disciplina; 
        v_nome ALUNOS.NOME%TYPE; 
    BEGIN 
        OPEN c_alunos; 
        LOOP 
            FETCH c_alunos INTO v_nome; 
            EXIT WHEN c_alunos%NOTFOUND; 
            DBMS_OUTPUT.PUT_LINE('Aluno: ' || v_nome); 
        END LOOP; 
        CLOSE c_alunos; 
    END listar_alunos_disciplina; 
END PKG_DISCIPLINA; 
/

SELECT * FROM ALUNOS;

SELECT * FROM DISCIPLINAS;

SELECT * FROM PROFESSORES;

SELECT * FROM MATRICULAS;

SELECT * FROM TURMAS;

CREATE OR REPLACE PACKAGE PKG_PROFESSOR AS 
    PROCEDURE total_turmas_professor; 
    FUNCTION total_turmas(p_id_professor IN NUMBER) RETURN NUMBER; 
    FUNCTION professor_disciplina(p_id_disciplina IN NUMBER) RETURN VARCHAR2; 
END PKG_PROFESSOR; 
/

CREATE OR REPLACE PACKAGE BODY PKG_PROFESSOR AS 
    -- Procedure para listar professores com mais de uma turma 
    PROCEDURE total_turmas_professor IS 
        CURSOR c_professores IS 
        SELECT p.NOME_PROFESSOR, COUNT(t.ID_TURMA) AS TOTAL 
        FROM PROFESSORES p 
        JOIN TURMAS t ON p.ID_PROFESSOR = t.ID_PROFESSOR 
        GROUP BY p.NOME_PROFESSOR 
        HAVING COUNT(t.ID_TURMA) > 1; 
        v_nome PROFESSORES.NOME_PROFESSOR%TYPE; 
        v_total NUMBER; 
    BEGIN 
        OPEN c_professores; 
        LOOP 
            FETCH c_professores INTO v_nome, v_total; 
            EXIT WHEN c_professores%NOTFOUND; 
            DBMS_OUTPUT.PUT_LINE(v_nome || ': ' || v_total || ' turmas.'); 
        END LOOP; 
        CLOSE c_professores; 
    END total_turmas_professor; 
 
    -- Function para retornar o total de turmas de um professor 
    FUNCTION total_turmas(p_id_professor IN NUMBER) RETURN NUMBER IS 
        v_total NUMBER; 
    BEGIN 
        SELECT COUNT(*) 
        INTO v_total 
        FROM TURMAS 
        WHERE ID_PROFESSOR = p_id_professor; 
        RETURN v_total; 
    END total_turmas; 
 
    -- Function para retornar o professor de uma disciplina 
    FUNCTION professor_disciplina(p_id_disciplina IN NUMBER) RETURN VARCHAR2 IS 
        v_nome PROFESSORES.NOME_PROFESSOR%TYPE; 
    BEGIN 
        SELECT p.NOME_PROFESSOR 
        INTO v_nome 
        FROM PROFESSORES p 
        JOIN TURMAS t ON p.ID_PROFESSOR = t.ID_PROFESSOR 
        WHERE t.ID_DISCIPLINA = p_id_disciplina; 
        RETURN v_nome; 
    EXCEPTION 
        WHEN NO_DATA_FOUND THEN 
            RETURN 'Nenhum professor encontrado.'; 
    END professor_disciplina; 
END PKG_PROFESSOR; 
/

EXEC PKG_ALUNO.listar_alunos_por_curso(1)


CREATE TABLE ALUNOS ( 
    ID_ALUNO NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY, -- Identificador único 
    NOME VARCHAR2(100) NOT NULL, -- Nome do aluno 
    DATA_NASCIMENTO DATE NOT NULL, -- Data de nascimento 
    ID_CURSO NUMBER -- Curso ao qual o aluno está vinculado (se houver) 
);

CREATE TABLE DISCIPLINAS ( 
    ID_DISCIPLINA NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY, -- Identificador único 
    NOME_DISCIPLINA VARCHAR2(100) NOT NULL, -- Nome da disciplina 
    DESCRICAO VARCHAR2(255), -- Descrição da disciplina 
    CARGA_HORARIA NUMBER NOT NULL -- Carga horária da disciplina 
);

CREATE TABLE PROFESSORES ( 
    ID_PROFESSOR NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY, -- Identificador único 
    NOME_PROFESSOR VARCHAR2(100) NOT NULL -- Nome do professor 
);

CREATE TABLE MATRICULAS ( 
    ID_MATRICULA NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY, -- Identificador único 
    ID_ALUNO NUMBER NOT NULL, -- ID do aluno matriculado 
    ID_DISCIPLINA NUMBER NOT NULL, -- ID da disciplina 
    DATA_MATRICULA DATE DEFAULT SYSDATE, -- Data da matrícula 
    FOREIGN KEY (ID_ALUNO) REFERENCES ALUNOS(ID_ALUNO) ON DELETE CASCADE, -- Chave estrangeira para Alunos 
    FOREIGN KEY (ID_DISCIPLINA) REFERENCES DISCIPLINAS(ID_DISCIPLINA) ON DELETE CASCADE -- Chave estrangeira para Disciplinas 
);

CREATE TABLE TURMAS ( 
    ID_TURMA NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY, -- Identificador único 
    ID_DISCIPLINA NUMBER NOT NULL, -- ID da disciplina da turma 
    ID_PROFESSOR NUMBER NOT NULL, -- ID do professor responsável 
    SEMESTRE VARCHAR2(10), -- Semestre da turma (ex: "2024/1") 
    FOREIGN KEY (ID_DISCIPLINA) REFERENCES DISCIPLINAS(ID_DISCIPLINA) ON DELETE CASCADE, -- Chave estrangeira para Disciplinas 
    FOREIGN KEY (ID_PROFESSOR) REFERENCES PROFESSORES(ID_PROFESSOR) ON DELETE CASCADE -- Chave estrangeira para Professores 
);

INSERT INTO ALUNOS (NOME, DATA_NASCIMENTO, ID_CURSO) VALUES ('João Silva', TO_DATE('2000-01-15', 'YYYY-MM-DD'), 1);

INSERT INTO ALUNOS (NOME, DATA_NASCIMENTO, ID_CURSO) VALUES ('Maria Oliveira', TO_DATE('2002-08-25', 'YYYY-MM-DD'), 1);

EXEC PKG_ALUNO.listar_alunos_por_curso(2)


INSERT INTO ALUNOS (NOME, DATA_NASCIMENTO, ID_CURSO) VALUES ('Ana Souza', TO_DATE('1998-03-10', 'YYYY-MM-DD'), 2);

INSERT INTO ALUNOS (NOME, DATA_NASCIMENTO, ID_CURSO) VALUES ('Pedro Santos', TO_DATE('1995-07-05', 'YYYY-MM-DD'), 3);

INSERT INTO DISCIPLINAS (NOME_DISCIPLINA, DESCRICAO, CARGA_HORARIA) VALUES ('Matemática', 'Matemática básica e avançada', 60);

INSERT INTO DISCIPLINAS (NOME_DISCIPLINA, DESCRICAO, CARGA_HORARIA) VALUES ('Português', 'Gramática, literatura e redação', 50);

INSERT INTO DISCIPLINAS (NOME_DISCIPLINA, DESCRICAO, CARGA_HORARIA) VALUES ('História', 'História geral e do Brasil', 40);

INSERT INTO DISCIPLINAS (NOME_DISCIPLINA, DESCRICAO, CARGA_HORARIA) VALUES ('Geografia', 'Geografia física e política', 45);

INSERT INTO PROFESSORES (NOME_PROFESSOR) VALUES ('Prof. Carlos Ferreira');

INSERT INTO PROFESSORES (NOME_PROFESSOR) VALUES ('Profª. Helena Martins');

INSERT INTO PROFESSORES (NOME_PROFESSOR) VALUES ('Prof. João Almeida');

INSERT INTO PROFESSORES (NOME_PROFESSOR) VALUES ('Profª. Cláudia Lima');

INSERT INTO MATRICULAS (ID_ALUNO, ID_DISCIPLINA, DATA_MATRICULA) VALUES (1, 1, TO_DATE('2024-01-10', 'YYYY-MM-DD'));

INSERT INTO MATRICULAS (ID_ALUNO, ID_DISCIPLINA, DATA_MATRICULA) VALUES (2, 2, TO_DATE('2024-01-12', 'YYYY-MM-DD'));

INSERT INTO MATRICULAS (ID_ALUNO, ID_DISCIPLINA, DATA_MATRICULA) VALUES (3, 3, TO_DATE('2024-01-15', 'YYYY-MM-DD'));

INSERT INTO MATRICULAS (ID_ALUNO, ID_DISCIPLINA, DATA_MATRICULA) VALUES (4, 4, TO_DATE('2024-01-18', 'YYYY-MM-DD'));

INSERT INTO MATRICULAS (ID_ALUNO, ID_DISCIPLINA, DATA_MATRICULA) VALUES (1, 2, TO_DATE('2024-01-20', 'YYYY-MM-DD'));

INSERT INTO MATRICULAS (ID_ALUNO, ID_DISCIPLINA, DATA_MATRICULA) VALUES (3, 1, TO_DATE('2024-01-22', 'YYYY-MM-DD'));

INSERT INTO TURMAS (ID_DISCIPLINA, ID_PROFESSOR, SEMESTRE) VALUES (1, 1, '2024/1');

INSERT INTO TURMAS (ID_DISCIPLINA, ID_PROFESSOR, SEMESTRE) VALUES (2, 2, '2024/1');

INSERT INTO TURMAS (ID_DISCIPLINA, ID_PROFESSOR, SEMESTRE) VALUES (3, 3, '2024/1');

INSERT INTO TURMAS (ID_DISCIPLINA, ID_PROFESSOR, SEMESTRE) VALUES (4, 4, '2024/1');

INSERT INTO TURMAS (ID_DISCIPLINA, ID_PROFESSOR, SEMESTRE) VALUES (2, 1, '2024/2');

INSERT INTO TURMAS (ID_DISCIPLINA, ID_PROFESSOR, SEMESTRE) VALUES (3, 2, '2024/2');

COMMIT;

SELECT * FROM ALUNOS;

SELECT * FROM DISCIPLINAS;

SELECT * FROM PROFESSORES;

SELECT * FROM MATRICULAS;

SELECT * FROM TURMAS;

CREATE OR REPLACE PACKAGE PKG_ALUNO AS 
    PROCEDURE excluir_aluno(p_id_aluno IN NUMBER); 
    PROCEDURE listar_alunos_maiores; 
    PROCEDURE listar_alunos_por_curso(p_id_curso IN NUMBER); 
END PKG_ALUNO; 
/

CREATE OR REPLACE PACKAGE BODY PKG_ALUNO AS 
    -- Procedure para excluir aluno 
    PROCEDURE excluir_aluno(p_id_aluno IN NUMBER) IS 
    BEGIN 
        DELETE FROM MATRICULAS WHERE ID_ALUNO = p_id_aluno; 
        DELETE FROM ALUNOS WHERE ID_ALUNO = p_id_aluno; 
        COMMIT; 
        DBMS_OUTPUT.PUT_LINE('Aluno ' || p_id_aluno || ' excluído com sucesso.'); 
    EXCEPTION 
        WHEN OTHERS THEN 
            ROLLBACK; 
            DBMS_OUTPUT.PUT_LINE('Erro ao excluir aluno: ' || SQLERRM); 
    END excluir_aluno; 
 
    -- Procedure para listar alunos maiores de 18 anos 
    PROCEDURE listar_alunos_maiores IS 
        CURSOR c_maiores IS 
        SELECT NOME, DATA_NASCIMENTO 
        FROM ALUNOS 
        WHERE TRUNC(MONTHS_BETWEEN(SYSDATE, DATA_NASCIMENTO) / 12) > 18; 
        v_nome ALUNOS.NOME%TYPE; 
        v_data ALUNOS.DATA_NASCIMENTO%TYPE; 
    BEGIN 
        OPEN c_maiores; 
        LOOP 
            FETCH c_maiores INTO v_nome, v_data; 
            EXIT WHEN c_maiores%NOTFOUND; 
            DBMS_OUTPUT.PUT_LINE(v_nome || ' - Nascimento: ' || TO_CHAR(v_data, 'DD/MM/YYYY')); 
        END LOOP; 
        CLOSE c_maiores; 
    END listar_alunos_maiores; 
 
    -- Procedure para listar alunos por curso 
    PROCEDURE listar_alunos_por_curso(p_id_curso IN NUMBER) IS 
        CURSOR c_alunos IS 
        SELECT NOME 
        FROM ALUNOS 
        WHERE ID_CURSO = p_id_curso; 
        v_nome ALUNOS.NOME%TYPE; 
    BEGIN 
        OPEN c_alunos; 
        LOOP 
            FETCH c_alunos INTO v_nome; 
            EXIT WHEN c_alunos%NOTFOUND; 
            DBMS_OUTPUT.PUT_LINE('Aluno: ' || v_nome); 
        END LOOP; 
        CLOSE c_alunos; 
    END listar_alunos_por_curso; 
END PKG_ALUNO; 
/

CREATE OR REPLACE PACKAGE PKG_DISCIPLINA AS 
    PROCEDURE cadastrar_disciplina(p_nome IN VARCHAR2, p_desc IN VARCHAR2, p_carga IN NUMBER); 
    PROCEDURE listar_total_alunos_disciplina; 
    PROCEDURE media_idade_disciplina(p_id_disciplina IN NUMBER); 
    PROCEDURE listar_alunos_disciplina(p_id_disciplina IN NUMBER); 
END PKG_DISCIPLINA; 
/

CREATE OR REPLACE PACKAGE BODY PKG_DISCIPLINA AS 
    -- Procedure para cadastrar disciplina 
    PROCEDURE cadastrar_disciplina(p_nome IN VARCHAR2, p_desc IN VARCHAR2, p_carga IN NUMBER) IS 
    BEGIN 
        INSERT INTO DISCIPLINAS (NOME_DISCIPLINA, DESCRICAO, CARGA_HORARIA) 
        VALUES (p_nome, p_desc, p_carga); 
        COMMIT; 
        DBMS_OUTPUT.PUT_LINE('Disciplina ' || p_nome || ' cadastrada com sucesso.'); 
    END cadastrar_disciplina; 
 
    -- Cursor para listar disciplinas com mais de 10 alunos 
    PROCEDURE listar_total_alunos_disciplina IS 
        CURSOR c_disciplina IS 
        SELECT d.NOME_DISCIPLINA, COUNT(m.ID_ALUNO) AS TOTAL 
        FROM DISCIPLINAS d 
        JOIN MATRICULAS m ON d.ID_DISCIPLINA = m.ID_DISCIPLINA 
        GROUP BY d.NOME_DISCIPLINA 
        HAVING COUNT(m.ID_ALUNO) > 10; 
        v_nome DISCIPLINAS.NOME_DISCIPLINA%TYPE; 
        v_total NUMBER; 
    BEGIN 
        OPEN c_disciplina; 
        LOOP 
            FETCH c_disciplina INTO v_nome, v_total; 
            EXIT WHEN c_disciplina%NOTFOUND; 
            DBMS_OUTPUT.PUT_LINE(v_nome || ': ' || v_total || ' alunos.'); 
        END LOOP; 
        CLOSE c_disciplina; 
    END listar_total_alunos_disciplina; 
 
    -- Cursor para calcular a média de idade por disciplina 
    PROCEDURE media_idade_disciplina(p_id_disciplina IN NUMBER) IS 
        CURSOR c_media IS 
        SELECT AVG(TRUNC(MONTHS_BETWEEN(SYSDATE, a.DATA_NASCIMENTO) / 12)) AS MEDIA_IDADE 
        FROM ALUNOS a 
        JOIN MATRICULAS m ON a.ID_ALUNO = m.ID_ALUNO 
        WHERE m.ID_DISCIPLINA = p_id_disciplina; 
        v_media NUMBER; 
    BEGIN 
        OPEN c_media; 
        FETCH c_media INTO v_media; 
        DBMS_OUTPUT.PUT_LINE('Média de idade: ' || v_media); 
        CLOSE c_media; 
    END media_idade_disciplina; 
 
    -- Procedure para listar alunos de uma disciplina 
    PROCEDURE listar_alunos_disciplina(p_id_disciplina IN NUMBER) IS 
        CURSOR c_alunos IS 
        SELECT a.NOME 
        FROM ALUNOS a 
        JOIN MATRICULAS m ON a.ID_ALUNO = m.ID_ALUNO 
        WHERE m.ID_DISCIPLINA = p_id_disciplina; 
        v_nome ALUNOS.NOME%TYPE; 
    BEGIN 
        OPEN c_alunos; 
        LOOP 
            FETCH c_alunos INTO v_nome; 
            EXIT WHEN c_alunos%NOTFOUND; 
            DBMS_OUTPUT.PUT_LINE('Aluno: ' || v_nome); 
        END LOOP; 
        CLOSE c_alunos; 
    END listar_alunos_disciplina; 
END PKG_DISCIPLINA; 
/

CREATE OR REPLACE PACKAGE PKG_PROFESSOR AS 
    PROCEDURE total_turmas_professor; 
    FUNCTION total_turmas(p_id_professor IN NUMBER) RETURN NUMBER; 
    FUNCTION professor_disciplina(p_id_disciplina IN NUMBER) RETURN VARCHAR2; 
END PKG_PROFESSOR; 
/

CREATE OR REPLACE PACKAGE BODY PKG_PROFESSOR AS 
    -- Procedure para listar professores com mais de uma turma 
    PROCEDURE total_turmas_professor IS 
        CURSOR c_professores IS 
        SELECT p.NOME_PROFESSOR, COUNT(t.ID_TURMA) AS TOTAL 
        FROM PROFESSORES p 
        JOIN TURMAS t ON p.ID_PROFESSOR = t.ID_PROFESSOR 
        GROUP BY p.NOME_PROFESSOR 
        HAVING COUNT(t.ID_TURMA) > 1; 
        v_nome PROFESSORES.NOME_PROFESSOR%TYPE; 
        v_total NUMBER; 
    BEGIN 
        OPEN c_professores; 
        LOOP 
            FETCH c_professores INTO v_nome, v_total; 
            EXIT WHEN c_professores%NOTFOUND; 
            DBMS_OUTPUT.PUT_LINE(v_nome || ': ' || v_total || ' turmas.'); 
        END LOOP; 
        CLOSE c_professores; 
    END total_turmas_professor; 
 
    -- Function para retornar o total de turmas de um professor 
    FUNCTION total_turmas(p_id_professor IN NUMBER) RETURN NUMBER IS 
        v_total NUMBER; 
    BEGIN 
        SELECT COUNT(*) 
        INTO v_total 
        FROM TURMAS 
        WHERE ID_PROFESSOR = p_id_professor; 
        RETURN v_total; 
    END total_turmas; 
 
    -- Function para retornar o professor de uma disciplina 
    FUNCTION professor_disciplina(p_id_disciplina IN NUMBER) RETURN VARCHAR2 IS 
        v_nome PROFESSORES.NOME_PROFESSOR%TYPE; 
    BEGIN 
        SELECT p.NOME_PROFESSOR 
        INTO v_nome 
        FROM PROFESSORES p 
        JOIN TURMAS t ON p.ID_PROFESSOR = t.ID_PROFESSOR 
        WHERE t.ID_DISCIPLINA = p_id_disciplina; 
        RETURN v_nome; 
    EXCEPTION 
        WHEN NO_DATA_FOUND THEN 
            RETURN 'Nenhum professor encontrado.'; 
    END professor_disciplina; 
END PKG_PROFESSOR; 
/

EXEC PKG_ALUNO.listar_alunos_por_curso(2)


EXEC PKG_ALUNO.listar_alunos_por_curso(3)


EXEC PKG_ALUNO.listar_alunos_por_curso(4)


EXEC PKG_ALUNO.listar_alunos_por_curso(5)


EXEC PKG_ALUNO.listar_alunos_por_curso(1)


EXEC PKG_DISCIPLINA.cadastrar_disciplina('Física', 'Mecânica e Eletricidade', 45)


EXEC PKG_ALUNO.excluir_aluno(1)


EXEC PKG_DISCIPLINA.cadastrar_disciplina('Física', 'Estudo de mecânica', 60)


SELECT PKG_PROFESSOR.total_turmas(1) FROM DUAL;

