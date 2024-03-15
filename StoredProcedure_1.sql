Create database StoredProcedure_1
go
Use StoredProcedure_1
go
Create table Aluno(
codigo int not null Identity,
nome varchar(70) not null
Primary key(codigo)
)
go
Create table Atividade(
codigo int not null,
descricao varchar(100) not null,
imc decimal(7,2) not null
Primary Key(codigo)
)
go
Create table Atividade_Aluno(
codigo_aluno int not null,
altura decimal(7,2) not null,
peso decimal(7,2) not null,
imc decimal(7,2) not null,
atividade int not null
Primary key(codigo_aluno, atividade),
Foreign key (codigo_aluno) References Aluno(codigo),
Foreign key(atividade) References Atividade(codigo)
)
go
Insert into Atividade values
(1, 'Corrida + Step', 18.5),
(2, 'Biceps + Costas + Pernas', 24.9),
(3, 'Esteira + Biceps + Costas + Pernas', 29.9),
(4, 'Bicicleta + Biceps + Costa + Pernas', 34.9),
(5, 'Esteira + Bicicleta', 39.9)
go


Create Procedure sp_alunoatividade(@codigo int, @nome varchar(70), @altura decimal(7,2), @peso decimal(7,2), @saida varchar(100) output)
as
If(@peso is null or @altura is null) Begin
Raiserror('Altura e peso não podem ser nulo', 16,1)
End 

Else Begin
Declare @imc decimal(7,2)
Set @imc = @peso / POWER(@altura,2)
If (@codigo is null and @nome is not null)
	Begin
		Insert into Aluno Values(@nome)
	    set @codigo = (select TOP 1 codigo from Aluno order by codigo desc)
		Set @saida ='Aluno Cadastrado com sucesso'
		If(@imc <=18.5) Begin
			Insert Into Atividade_Aluno Values(@codigo,@altura,@peso,@imc,1)
		End
		If(@imc Between 18.6 and 24.9) Begin
			Insert Into Atividade_Aluno Values(@codigo,@altura,@peso,@imc,2)
		End
		If(@imc Between 25 and 29.9) Begin
			Insert Into Atividade_Aluno Values(@codigo,@altura,@peso,@imc,3)
		End
		If(@imc Between 30 and 34.9) Begin
			Insert Into Atividade_Aluno Values(@codigo,@altura,@peso,@imc,4)
		End
		If (@imc > 34.9) Begin
			Insert Into Atividade_Aluno Values(@codigo,@altura,@peso,@imc,5)
		End
	End

	Else Begin
	If (@codigo is not null)
	Begin
		set @codigo = (select codigo from Aluno where codigo = @codigo)
		If (@codigo is null) Begin
		RaisError('Esse codigo não pertence a nenhum aluno',16,1)
		End
		Else begin
		Declare @atividade int

		If(@imc <=18.5) Begin
			set @atividade = 1
		End
		If(@imc Between 18.6 and 24.9) Begin
			set @atividade = 2
		End
		If(@imc Between 25 and 29.9) Begin
			set @atividade = 3
		End
		If(@imc Between 30 and 34.9) Begin
			set @atividade = 4
		End
		If (@imc > 34.9) Begin
			set @atividade = 5
		End
		update Atividade_Aluno set peso = @peso, altura=@altura, imc = @imc, atividade = @atividade where codigo_aluno = @codigo
		End
	End
End
End

Declare @out varchar(100)
Exec sp_alunoatividade null,'Lucas', 1.80, 90, @out output
print @out

Declare @out varchar(100)
Exec sp_alunoatividade 16, null, 1.95, 90, @out output
print @out



Select * from Aluno
Select * from Atividade_Aluno

Drop Procedure sp_alunoatividade
Delete from Aluno
Delete from Atividade_Aluno

	