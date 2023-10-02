CREATE DATABASE funcoes;
use funcoes;

create table nomes (
	nome varchar(50)
);
    
insert into nomes(nome) values ('Roberta'),('Roberto'),('Maria Clara'),('João');

select upper(nome) from nomes;
select length(nome) as tamanho, nome from nomes


