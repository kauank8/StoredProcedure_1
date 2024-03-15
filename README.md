# StoredProcedure_1
Exercicio baseado em stored procedure, trabalhando com imc e algumas regras.
Criar uma Stored Procedure (sp_alunoatividades), com as seguintes regras:
- Se, dos dados inseridos, o código for nulo, mas, existirem nome, altura, peso, deve-se inserir um
novo registro nas tabelas aluno e aluno atividade com o imc calculado e as atividades pelas
regras estabelecidas acima.
- Se, dos dados inseridos, o nome for (ou não nulo), mas, existirem código, altura, peso, deve-se
verificar se aquele código existe na base de dados e atualizar a altura, o peso, o imc calculado e
as atividades pelas regras estabelecidas acima.
