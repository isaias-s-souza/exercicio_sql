DROP database atividade_trigger; 
create database atividade_trigger;

use atividade_trigger;

CREATE TABLE Funcionario ( 
 idFuncionario INTEGER NOT NULL, 
 NomeFuncionario VARCHAR(45) NULL, 
 PRIMARY KEY(idFuncionario) 
); 
CREATE TABLE Documentos ( 
 idFuncionario INTEGER NOT NULL, 
 RG INT(11) NULL, 
 CPF INT(13) NULL, 
 PRIMARY KEY(idFuncionario), 
 INDEX Documentos_FKIndex1(idFuncionario), 
 FOREIGN KEY(idFuncionario) 
 REFERENCES Funcionario(idFuncionario) 
 ON DELETE NO ACTION 
 ON UPDATE NO ACTION 
); 
CREATE TABLE Dependente ( 
 idDependente INTEGER NOT NULL, 
 idFuncionario INTEGER NOT NULL, 
 NomeDependente VARCHAR(45) NULL, 
 PRIMARY KEY(idDependente), 
 INDEX Dependente_FKIndex1(idFuncionario), 
 FOREIGN KEY(idFuncionario) 
 REFERENCES Funcionario(idFuncionario) 
 ON DELETE NO ACTION 
 ON UPDATE NO ACTION 
);

DELIMITER |
CREATE TRIGGER TR_FUNCIONARIO_AFTER
AFTER INSERT ON FUNCIONARIO
FOR EACH ROW
BEGIN
	INSERT INTO DOCUMENTOS (idFuncionario) VALUES (new.idFuncionario);
END
|
DELIMITER ;

INSERT INTO FUNCIONARIO VALUES (9, 'FABIN');
SELECT * FROM DOCUMENTOS;