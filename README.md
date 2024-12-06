# Projeto: Packages em PL-SQL
Este repositório contém scripts para criação de tabelas e pacotes no Oracle, com exemplos de operações utilizando procedures, functions e cursores.

## Objetivo
O projeto foi desenvolvido para consolidar o conhecimento sobre manipulação de dados no Oracle usando PL/SQL. O script abrange operações como exclusão de registros, listagem com filtros, cálculos de médias, e outras tarefas relacionadas a entidades de um sistema acadêmico.

## Estrutura do Projeto
### Tabelas Criadas
#### 1. ALUNOS
  Contém informações sobre os alunos, como nome, data de nascimento e curso.
#### 2. DISCIPLINAS
  Registra as disciplinas oferecidas, com nome, descrição e carga horária.
#### 3. PROFESSORES
  Armazena dados dos professores.

## Pacotes Implementados
### PKG_ALUNO
Conjunto de procedures e cursores para manipulação de dados relacionados a alunos:

- excluir_aluno: Exclui um aluno e todas as suas matrículas.
- listar_alunos_maiores: Lista alunos maiores de 18 anos.
- listar_alunos_por_curso: Lista alunos matriculados em um curso específico.

### PKG_DISCIPLINA
Procedures e cursores relacionados às disciplinas:

- cadastrar_disciplina: Cadastra uma nova disciplina.
- listar_total_alunos_disciplina: Lista disciplinas com mais de 10 alunos matriculados.
- media_idade_disciplina: Calcula a média de idade dos alunos de uma disciplina.
- listar_alunos_disciplina: Lista os alunos matriculados em uma disciplina.

### PKG_PROFESSOR
Procedures e funções relacionadas a professores:

- total_turmas_professor: Lista professores que possuem mais de uma turma.
- total_turmas: Retorna o número total de turmas de um professor.
- professor_disciplina: Retorna o nome do professor responsável por uma disciplina.

## Como Executar
### Pré-requisitos
- Oracle Database instalado.
- Acesso ao SQL*Plus, SQL Developer ou Oracle Live SQL.
- Permissões para criar tabelas, pacotes e executar scripts.

## Passo a Passo
### 1. Criação das tabelas

- Copie e execute o script de criação das tabelas no Oracle.
- Certifique-se de que o comando CREATE TABLE foi bem-sucedido.

### 2. Inserção de dados

- Execute o script de inserção de dados de teste para popular as tabelas.

### 3. Criação dos pacotes

- Copie e execute os scripts para criar cada pacote (PKG_ALUNO, PKG_DISCIPLINA, PKG_PROFESSOR).
- Verifique se todos os pacotes foram criados sem erros.

### 4. Execução de procedimentos e funções

- Use o comando EXEC ou SELECT para testar as procedures e funções. Exemplos:

  EXEC PKG_ALUNO.excluir_aluno(1);

  EXEC PKG_DISCIPLINA.cadastrar_disciplina('Física', 'Estudo de mecânica', 60);

  SELECT PKG_PROFESSOR.total_turmas(1) FROM DUAL;

### Saída Esperada
Ao executar cada procedimento ou função, você verá mensagens no console ou os resultados das consultas, dependendo do caso. Exemplos:

![image](https://github.com/user-attachments/assets/5e967a5b-3e4e-474f-82d0-919ba0fce6b5)

- Aluno 1 excluído com sucesso.
- Disciplina Física cadastrada com sucesso.
- Total de turmas de um professor.
