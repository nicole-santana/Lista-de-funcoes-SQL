-- 1 - Funções de string

-- a)

CREATE DATABASE funcoes;
use funcoes;

create table nomes (
	nome varchar(50)
);
    
insert into nomes(nome) values ('Roberta'),('Roberto'),('Maria Clara'),('João');

-- b)
select upper(nome) from nomes;

-- c)
select length(nome) as tamanho, nome from nomes

-- d)
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


-- 2 - Funções numéricas

-- a)
create table produtos (
	produto varchar(50),
    preco decimal(10,5),
    quantidade int
);

insert into produtos values ('teste','12.675','45'),
('teste2','10.674','34'),
('teste3','12.897','22'),
('teste4','15.1515','40'),
('teste5','3.125','4'),
('teste6','3.125','4'),
('teste7','80.199','-2839428');

-- b)
select produto, round(preco, 2) as preços_arredondados from produtos;

-- c)
select produto, abs(quantidade) as quantidade_absoluta from produtos;

-- d)
select avg(preco) as média_de_preço from produtos ;

-- Funções de data

-- a)

create table eventos (
	data_evento datetime
);

insert into eventos values ('2023-10-1 14:30:00'),( '2024-11-13 15:45:00'), ('2023-1-3 00:50:00'), ('2012-3-1 14:55:00');


-- b) 
insert into eventos values(now());

select data_evento from eventos;

-- c)
select datediff('2023-10-1','2024-11-13') as diferença_em_dias;
select datediff('2024-11-13','2023-10-1') as diferença_em_dias;

-- d)
select dayname('2023-10-1');
select dayname('2024-11-13');
select dayname('2023-1-3');
select dayname('2012-3-1');
select dayname('2023-10-07');


-- Funções de Controle de Fluxo

-- a)
create table produtos (
	produto varchar(50),
    preco decimal(10,5),
    quantidade int
);

insert into produtos values ('teste','12.675','45'),
('teste2','10.674','34'),
('teste3','12.897','22'),
('teste4','15.1515','40'),
('teste5','3.125','4'),
('teste6','3.125','4'),
('teste7','80.199','-2839428');

SELECT produto,quantidade, IF(quantidade > 0, 'Em estoque', 'Fora de estoque') AS status_estoque FROM produtos;

-- b)
SELECT
    produto,
    preco,
    CASE
        WHEN preco < 15 THEN 'Barato'
        WHEN preco >= 15 AND preco < 30 THEN 'Médio'
        ELSE 'Caro'
    END AS categoria_preco
FROM produtos;

--  Função Personalizada:

-- a)
create table produtos (
	produto varchar(50),
    preco decimal(10,5),
    quantidade int
);

insert into produtos values ('teste','12.675','45'),
('teste2','10.674','34'),
('teste3','12.897','22'),
('teste4','15.1515','40'),
('teste5','3.125','4'),
('teste6','3.125','4'),
('teste7','80.199','-2839428');


DELIMITER //

CREATE FUNCTION total_valor(preco DECIMAL(10, 5), quantidade INT)
RETURNS DECIMAL(10, 5)
DETERMINISTIC
BEGIN
    DECLARE total DECIMAL(10, 5);
    SET total = preco * quantidade;
    RETURN total;
END //

DELIMITER ;

-- b)

SELECT
    produto,
    preco,
    quantidade,
    total_valor(preco, quantidade) AS valor_total
FROM produtos;


-- Funções de Agregação

-- a)


select count(produto) from produtos;








-- b)

SELECT produto, MAX(preco) AS preco_maximo
FROM produtos
GROUP BY produto
ORDER BY preco_maximo DESC
LIMIT 1;

-- c)

SELECT produto, min(preco) AS preco_maximo
FROM produtos
GROUP BY produto
ORDER BY preco_maximo asc
LIMIT 1;

-- d)

SELECT SUM(IF(quantidade > 0, quantidade, 0)) AS quantidade_total_em_estoque
FROM produtos;

-- Criando funções

-- a)
DELIMITER //

CREATE FUNCTION Fatorial(numero INT)
RETURNS INT
BEGIN
    DECLARE resultado INT DEFAULT 1;
    WHILE numero > 1 DO
        SET resultado = resultado * numero;
        SET numero = numero - 1;
    END WHILE;
    RETURN resultado;
END //

DELIMITER ;

SELECT Fatorial(9); 

-- b)

DELIMITER //

CREATE FUNCTION f_exponencial(base DECIMAL(10, 5), expoente INT)
RETURNS DECIMAL(10, 5)
BEGIN
    DECLARE resultado DECIMAL(10, 5);
    SET resultado = POW(base, expoente);
    RETURN resultado;
END //

DELIMITER ;

-- eu adicionei o round pq o resultado dava 8.0000 
SELECT round(f_exponencial(2, 3), 2);

-- c)

DELIMITER //

CREATE FUNCTION e_palindromo(palavra VARCHAR(255))
RETURNS INT
BEGIN
    DECLARE palavra_invertida VARCHAR(255);
    SET palavra_invertida = REVERSE(palavra);
    
    IF palavra = palavra_invertida THEN
        RETURN 1;
    ELSE
        RETURN 0;
    END IF;
END //

DELIMITER ;

SELECT e_palindromo('tenet'); 
SELECT e_palindromo('sql'); 



