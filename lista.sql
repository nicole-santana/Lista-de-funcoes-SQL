CREATE DATABASE funcoes;
use funcoes;

create table nomes (
	nome varchar(50)
);
    
insert into nomes(nome) values ('Roberta'),('Roberto'),('Maria Clara'),('João');

select upper(nome) from nomes;
select length(nome) as tamanho, nome from nomes


DELIMITER //

CREATE FUNCTION concatenar(nomes CHAR(20))
RETURNS CHAR(50)
BEGIN
  DECLARE resultado CHAR(50);
  
  IF nomes LIKE '%a' THEN
    SET resultado = CONCAT('Sra. ', nomes);
  ELSE
    SET resultado = CONCAT('Sr. ', nomes);
  END IF;

  RETURN resultado;
END //

DELIMITER ;

SELECT concatenar('Roberta') AS resultado;
SELECT concatenar('Roberto') AS resultado;
SELECT concatenar('Maria Clara') AS resultado;
SELECT concatenar('João') AS resultado;
