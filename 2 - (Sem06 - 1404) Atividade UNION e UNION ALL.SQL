-- Atividade UNION e UNION ALL

/* create database exempuniao;
use exempuniao;

create table cadfun (
codfun integer primary key not null,
nome varchar(40) not null
);

create table morto (
codfun integer primary key not null,
nome varchar(40) not null
);

insert into cadfun values (1,'Silvio de Menezes');
insert into cadfun values (2,'Wilson de Macedo');
insert into cadfun values (3,'Ana Bastos');
insert into cadfun values (4,'Carlos Bastos');
insert into cadfun values (5,'Augusto Souza');
insert into cadfun values (6,'Silvia da Silva');
insert into cadfun values (7,'Aparecido Silva');
insert into cadfun values (8,'Antonio da Silva');
insert into cadfun values (9,'Solange Pacheco');
insert into cadfun values (10,'Antonia de Carvalho');
insert into cadfun values (11,'Silvana dos Santos');
insert into cadfun values (12,'Antonio dos Santos');
insert into cadfun values (20,'Audrey Toledo');
insert into cadfun values (21,'Epaminondas da Silva');
insert into cadfun values (22,'Sandra Manzano');
insert into cadfun values (24,'Marcio Canuto');
insert into cadfun values (25,'Pedro Silva');


insert into morto values (12,'Carlos Alberto');


select * from cadfun;
select * from morto; */

-- Atividade UNION e UNION ALL
select * from cadfun;
select * from morto;
-- Insira na tabela MORTO os registros cujo código do funcionário(Atributo CODFUN) seja igual a:7; 3; 9; 25; 4; 2; 5; 15.
INSERT INTO MORTO
SELECT CODFUN, NOME
FROM CADFUN WHERE CODFUN = 7;

INSERT INTO MORTO
SELECT CODFUN, NOME
FROM CADFUN WHERE CODFUN = 3;

INSERT INTO MORTO
SELECT CODFUN, NOME
FROM CADFUN WHERE CODFUN = 9;

INSERT INTO MORTO
SELECT CODFUN, NOME
FROM CADFUN WHERE CODFUN = 25;

INSERT INTO MORTO
SELECT CODFUN, NOME
FROM CADFUN WHERE CODFUN = 4;

INSERT INTO MORTO
SELECT CODFUN, NOME
FROM CADFUN WHERE CODFUN = 2;

INSERT INTO MORTO
SELECT CODFUN, NOME
FROM CADFUN WHERE CODFUN = 5;

INSERT INTO MORTO
SELECT CODFUN, NOME
FROM CADFUN WHERE CODFUN = 15;

select * from cadfun;
select * from morto;

/*Exclua da tabela CADFUN os registros acima inseridos na tabela MORTO. Ou seja, 
exclua da tabela CADFUN os registros cujo código do funcionário (Atributo CODFUN) 
seja igual a:7; 3; 9; 25; 4; 2; 5; 15 */

DELETE FROM CADFUN WHERE CODFUN = 7;
DELETE FROM CADFUN WHERE CODFUN = 3;
DELETE FROM CADFUN WHERE CODFUN = 9;
DELETE FROM CADFUN WHERE CODFUN = 25;
DELETE FROM CADFUN WHERE CODFUN = 4;
DELETE FROM CADFUN WHERE CODFUN = 2;
DELETE FROM CADFUN WHERE CODFUN = 5;
DELETE FROM CADFUN WHERE CODFUN = 15;

select * from cadfun;
-- Realize as seguintes instruções:

SELECT CODFUN, NOME FROM CADFUN;
SELECT CODFUN, NOME FROM MORTO;

-- União de Dados Prática:
/*Pode-se agora usar as duas tabelas (CADFUN e MORTO) para uma
execução prática do comando UNION. O exemplo a seguir
apresenta numa única consulta todos os registros existentes nas
tabelas CADFUN e MORTO.*/

SELECT CODFUN, NOME FROM CADFUN UNION
SELECT CODFUN, NOME FROM MORTO;

/*Há uma característica importante do operador UNION. Quando ele
une duas ou mais tabelas, apresenta apenas uma linha de registro caso
haja nas tabelas envolvidas duplicidade daquele registro.
Para exemplificar execute a seguinte instrução:
*/
INSERT INTO MORTO VALUES (21, 'EPAMINONDAS DA SILVA');

/*Execute as instruções para verificar a existência do registro de
funcionário de código 21 nas duas tabelas (CADFUN e MORTO)*/

SELECT * FROM CADFUN WHERE CODFUN = 21 ;
SELECT * FROM MORTO WHERE CODFUN = 21;

/*Execute novamente a instrução de união de duas tabelas (CADFUN e
MORTO) e verifique que são apresentados apenas 19 registros,
sendo a duplicidade do funcionário de código 21 desconsiderada
pelo operador UNION.*/
SELECT CODFUN, NOME FROM CADFUN UNION
SELECT CODFUN, NOME FROM MORTO;

/*União de Dados
Prática:
Caso deseje que a consulta feita com o operador UNION apresente
os registros eventualmente duplicados, no lugar de usar o operador
UNION, basta usar o operador UNION ALL. Exemplo:
*/
SELECT CODFUN, NOME FROM CADFUN UNION ALL
SELECT CODFUN, NOME FROM MORTO;