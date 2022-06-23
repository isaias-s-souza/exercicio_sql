DROP DATABASE IF EXISTS padariaead;
CREATE DATABASE padariaead;
use padariaead;

-- 

CREATE TABLE Ingredientes (
  idIngredientes INTEGER NOT NULL,
  Nome VARCHAR(40) NULL,
  QtdeEstoque DECIMAL(8,2) NULL,
  PRIMARY KEY(idIngredientes)
);

CREATE TABLE Cozinheiro (
  idCozinheiro INTEGER NOT NULL,
  Nome VARCHAR(40) NULL,
  Sexo CHAR(1) NULL,
  Salario DECIMAL(8,2) NULL,
  PRIMARY KEY(idCozinheiro)
);

CREATE TABLE Prato (
  idPrato INTEGER NOT NULL,
  idCozinheiro INTEGER NOT NULL, -- Comentar para testar a questão 3
  Nome VARCHAR(40) NULL,
  Preco DECIMAL(8,2) NULL,
  PRIMARY KEY(idPrato),
  INDEX Prato_FKIndex1(idCozinheiro),
  FOREIGN KEY(idCozinheiro)
    REFERENCES Cozinheiro(idCozinheiro)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
);

CREATE TABLE Receita (
  idPrato INTEGER NOT NULL,
  idIngredientes INTEGER NOT NULL,
  PRIMARY KEY(idPrato, idIngredientes),
  INDEX Receita_FKIndex1(idPrato),
  INDEX Receita_FKIndex2(idIngredientes),
  FOREIGN KEY(idPrato)
    REFERENCES Prato(idPrato)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION,
  FOREIGN KEY(idIngredientes)
    REFERENCES Ingredientes(idIngredientes)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
);

--
insert into cozinheiro values (1,'Joao','M',1500.00);
insert into cozinheiro values (2,'Jose','M',1600.00);
insert into cozinheiro values (3,'Ana','M',900.00);
insert into cozinheiro values (4,'Ricardo','M',1800.00);
insert into cozinheiro values (5,'Alberto','M',17000.00);

insert into ingredientes values (1,'Ovo',500);
insert into ingredientes values (2,'Farinha',1500);
insert into ingredientes values (3,'Leite',2500);
insert into ingredientes values (4,'Sal',300);
insert into ingredientes values (5,'Coco',600);
insert into ingredientes values (6,'Carne Moida',1000);
insert into ingredientes values (7,'Cebolinha',300);
insert into ingredientes values (8,'Cereja',450);
insert into ingredientes values (9,'Salsinha',600);
insert into ingredientes values (10,'Creme de Leite',200);
insert into ingredientes values (11,'Leite Condensado',660);
insert into ingredientes values (12,'Farinha de rosca',300);
insert into ingredientes values (13,'Leite em pó',630);
insert into ingredientes values (14,'Chocolate',100);
insert into ingredientes values (15,'Doce de leite',350);
insert into ingredientes values (16,'Açucar',20);
insert into ingredientes values (17,'Cebola',600);

insert into prato values (1,1,'Quindim',5.00);
insert into prato values (2,1,'Coxinha',3.00);
insert into prato values (3,2,'Risoles',3.00);
insert into prato values (4,4,'Kibe',3.00);
insert into prato values (5,3,'Hamburguer',3.00);
insert into prato values (6,5,'Bolo',4.00);
insert into prato values (7,5,'Pão',0.30);
insert into prato values (8,2,'Rosca',2.00);
insert into prato values (9,4,'Pão de queijo',1.00);
insert into prato values (10,3,'Lasanha',10.00);
insert into prato values (11,3,'Nhoque',12.00);
insert into prato values (12,2,'Pudim',8.00);

insert into receita values (1,1);
insert into receita values (1,3);
insert into receita values (1,4);
insert into receita values (1,5);
insert into receita values (2,3);
insert into receita values (2,6);
insert into receita values (2,9);
insert into receita values (2,12);
insert into receita values (3,2);
insert into receita values (3,5);
insert into receita values (3,7);
insert into receita values (3,13);
insert into receita values (4,14);
insert into receita values (4,13);
insert into receita values (4,2);
insert into receita values (4,1);
insert into receita values (5,3);
insert into receita values (5,4);
insert into receita values (5,16);
insert into receita values (5,14);
insert into receita values (6,9);
insert into receita values (6,7);
insert into receita values (6,4);
insert into receita values (6,5);
insert into receita values (7,3);
insert into receita values (7,2);
insert into receita values (7,11);
insert into receita values (7,14);
insert into receita values (8,15);
insert into receita values (8,13);
insert into receita values (8,3);
insert into receita values (8,11);
insert into receita values (9,4);
insert into receita values (9,7);
insert into receita values (9,14);
insert into receita values (9,8);
insert into receita values (10,9);
insert into receita values (10,15);
insert into receita values (10,11);
insert into receita values (10,3);
insert into receita values (11,2);
insert into receita values (11,4);
insert into receita values (11,12);
insert into receita values (11,16);
insert into receita values (12,2);
insert into receita values (12,5);
insert into receita values (12,7);
insert into receita values (12,9);

-- 1) Existe algum cozinheiro que não faz prato? Quem é(são) ele(s)?
INSERT INTO cozinheiro VALUES (6,'Cozinheiro Teste','F',0);
SELECT cozinheiro.Nome FROM cozinheiro
LEFT JOIN prato ON cozinheiro.idCozinheiro = prato.idCozinheiro
WHERE prato.idPrato IS NULL;

-- 2) Existe algum prato que não possui receita? Qual(is) é(são) ele(s)?
INSERT INTO prato VALUES (13,6,'Prato Teste',0);
SELECT prato.Nome FROM prato 
LEFT JOIN receita ON prato.idPrato = receita.idPrato
WHERE receita.idPrato IS NULL;

-- 3) Existe algum prato que não é produzido por algum cozinheiro? Qual(is) é(são) ele(s)?
INSERT INTO prato VALUES (14,NULL,'Prato Teste2',0);
SELECT prato.Nome FROM prato 
LEFT JOIN cozinheiro ON prato.idCozinheiro = cozinheiro.idCozinheiro
WHERE cozinheiro.idCozinheiro IS NULL;

-- 4) Existe algum ingrediente que não é utilizado (em nenhum prato)? Qual(is) é(são) ele(s)?
insert into ingredientes VALUES (18,'Ingrediente Teste', 0);
SELECT ingredientes.Nome FROM ingredientes
LEFT JOIN receita ON ingredientes.idReceita = receita.idIngredientes
LEFT JOIN prato ON receita.idPrato = prato.idPrato
WHERE prato.idPrato IS NULL;

-- -------------------------------------------------------------------------------------------------
-- Depois de verificadas as respostas utilizando os comandos LEFT E RIGHT JOIN, responda:         --
-- -------------------------------------------------------------------------------------------------
-- 1) Qual a importância dos comandos LEFT JOIN e do RIGHT JOIN?
-- - Os comandos LEFT e RIGHT são importantes quanto se deseja trazer todos os dados de uma tabela
-- independente de ter relação com a outra tabela que se deseja relacionar oos registros.

-- 2) Quais dos comandos (ou quais das situações acima), são permitidas ocorrerem em um
-- banco de dados (ou podem ocorrer em alguma empresa)? Especifique detalhadamente sua
-- resposta.
-- - Das situações acima que podem ocorrer em um caso real podemos listar as questões (1, 2 e 4), 
-- - sendo a terceira impossível dada o contexto que a coluna (prato.idCozinheiro) esta setada como "NOT NULL".
-- - Dentro do dia a dia de uma empresa é possível acontecer de ter a necessidade de extrair
-- - exceções como nos casos acima apresentados.

-- 3) Para os casos que não são permitidos, o que deveria ser feito para que a situação acima
-- não acontecesse?
-- - Deve se fazer uma alteração via um comando DDL para que a coluna aceite um prato sem um cozinheiro 
-- - atrelado incialmente.
-- - Usando o seguinte comando:
-- ALTER TABLE prato MODIFY idCozinheiro INT NULL;

-- 4) Seria possível restringir isso na criação do Banco de Dados? De que forma? Pesquise sobre
-- como isso pode ser feito e escreva sua resposta.
-- Na criação do banco de dados bastava que a coluna (prato.idCozinheiro) fosse setada com "NULL" ao invés de "NOT NULL".