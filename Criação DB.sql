-- MySQL Workbench Synchronization
-- Generated: 2022-03-27 23:04
-- Model: New Model
-- Version: 1.0
-- Project: Name of the project
-- Author: isaia

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

CREATE SCHEMA IF NOT EXISTS `language_school_ticoop_test` DEFAULT CHARACTER SET utf8 ;

CREATE TABLE IF NOT EXISTS `language_school_ticoop_test`.`student` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(30) NOT NULL,
  `last_name` VARCHAR(75) NOT NULL,
  `cpf` VARCHAR(45) NOT NULL,
  `street` VARCHAR(100) NULL DEFAULT NULL,
  `number` INT(11) NULL DEFAULT NULL,
  `complement` VARCHAR(15) NULL DEFAULT NULL,
  `district` VARCHAR(60) NULL DEFAULT NULL,
  `postal_code` INT(11) NULL DEFAULT NULL,
  `email` VARCHAR(255) NULL DEFAULT NULL,
  `phone_number` VARCHAR(45) NOT NULL,
  `city_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`, `city_id`),
  INDEX `fk_student_cities_idx` (`city_id` ASC) VISIBLE,
  CONSTRAINT `fk_student_cities`
    FOREIGN KEY (`city_id`)
    REFERENCES `language_school_ticoop_test`.`city` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `language_school_ticoop_test`.`city` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  `value_state` CHAR(2) NOT NULL,
  `ibge` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `language_school_ticoop_test`.`study_plan` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(35) NOT NULL,
  `price` DECIMAL(12,2) NOT NULL,
  `promotion` TINYINT(4) NULL DEFAULT NULL,
  `total_hour` DECIMAL(8,2) NOT NULL,
  `language_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`, `language_id`),
  INDEX `fk_study_plan_language1_idx` (`language_id` ASC) VISIBLE,
  CONSTRAINT `fk_study_plan_language1`
    FOREIGN KEY (`language_id`)
    REFERENCES `language_school_ticoop_test`.`language` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `language_school_ticoop_test`.`contract` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `study_plan_id` INT(11) NOT NULL,
  `created_at` DATETIME NOT NULL,
  `contractcol` VARCHAR(45) NULL DEFAULT NULL,
  `end_of_contract` DATE NOT NULL,
  `price` DECIMAL(12,2) NOT NULL,
  `discount` DECIMAL(12,2) NULL DEFAULT NULL,
  `total_price` DECIMAL(12,2) NOT NULL,
  `number_of_installments` INT(11) NOT NULL,
  `total_hour` DECIMAL(8,2) NOT NULL,
  `status_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`, `study_plan_id`, `status_id`),
  INDEX `fk_contracts_study_plans1_idx` (`study_plan_id` ASC) VISIBLE,
  INDEX `fk_contract_status1_idx` (`status_id` ASC) VISIBLE,
  CONSTRAINT `fk_contracts_study_plans1`
    FOREIGN KEY (`study_plan_id`)
    REFERENCES `language_school_ticoop_test`.`study_plan` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_contract_status1`
    FOREIGN KEY (`status_id`)
    REFERENCES `language_school_ticoop_test`.`status` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `language_school_ticoop_test`.`teacher` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(30) NOT NULL,
  `last_name` VARCHAR(75) NOT NULL,
  `phone_number` INT(11) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `language_school_ticoop_test`.`language` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `language_school_ticoop_test`.`teacher_language` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `teacher_id` INT(11) NOT NULL,
  `language_id` INT(11) NOT NULL,
  `cost_per_hour` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`, `teacher_id`, `language_id`),
  INDEX `fk_teacher_language_teacher1_idx` (`teacher_id` ASC) VISIBLE,
  INDEX `fk_teacher_language_language1_idx` (`language_id` ASC) VISIBLE,
  CONSTRAINT `fk_teacher_language_teacher1`
    FOREIGN KEY (`teacher_id`)
    REFERENCES `language_school_ticoop_test`.`teacher` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_teacher_language_language1`
    FOREIGN KEY (`language_id`)
    REFERENCES `language_school_ticoop_test`.`language` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `language_school_ticoop_test`.`contract_teacher` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `contract_id` INT(11) NOT NULL,
  `teacher_id` INT(11) NOT NULL,
  `begin` DATE NULL DEFAULT NULL,
  `end` DATE NULL DEFAULT NULL,
  `work_hours` DECIMAL(8,2) NOT NULL,
  PRIMARY KEY (`id`, `contract_id`, `teacher_id`),
  INDEX `fk_contract_teacher_contract1_idx` (`contract_id` ASC) VISIBLE,
  INDEX `fk_contract_teacher_teacher1_idx` (`teacher_id` ASC) VISIBLE,
  CONSTRAINT `fk_contract_teacher_contract1`
    FOREIGN KEY (`contract_id`)
    REFERENCES `language_school_ticoop_test`.`contract` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_contract_teacher_teacher1`
    FOREIGN KEY (`teacher_id`)
    REFERENCES `language_school_ticoop_test`.`teacher` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `language_school_ticoop_test`.`book` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(60) NOT NULL,
  `price` DECIMAL(12,2) NOT NULL,
  `publishing_company_id` INT(11) NOT NULL,
  `author_id` INT(11) NOT NULL,
  `language_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`, `publishing_company_id`, `author_id`, `language_id`),
  INDEX `fk_book_publishing_company1_idx` (`publishing_company_id` ASC) VISIBLE,
  INDEX `fk_book_author1_idx` (`author_id` ASC) VISIBLE,
  INDEX `fk_book_language1_idx` (`language_id` ASC) VISIBLE,
  CONSTRAINT `fk_book_publishing_company1`
    FOREIGN KEY (`publishing_company_id`)
    REFERENCES `language_school_ticoop_test`.`publishing_company` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_book_author1`
    FOREIGN KEY (`author_id`)
    REFERENCES `language_school_ticoop_test`.`author` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_book_language1`
    FOREIGN KEY (`language_id`)
    REFERENCES `language_school_ticoop_test`.`language` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `language_school_ticoop_test`.`sale` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `date` DATE NOT NULL,
  `discount` DECIMAL(10,2) NULL DEFAULT NULL,
  `total_price` VARCHAR(45) NOT NULL,
  `student_id` INT(11) NOT NULL,
  `price` DECIMAL(12,2) NULL DEFAULT NULL,
  `status_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`, `student_id`, `status_id`),
  INDEX `fk_sale_student1_idx` (`student_id` ASC) VISIBLE,
  INDEX `fk_sale_status1_idx` (`status_id` ASC) VISIBLE,
  CONSTRAINT `fk_sale_student1`
    FOREIGN KEY (`student_id`)
    REFERENCES `language_school_ticoop_test`.`student` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sale_status1`
    FOREIGN KEY (`status_id`)
    REFERENCES `language_school_ticoop_test`.`status` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `language_school_ticoop_test`.`book_sale` (
  `id` INT(11) NOT NULL,
  `amount` INT(11) NOT NULL,
  `book_id` INT(11) NOT NULL,
  `sale_id` INT(11) NOT NULL,
  `price` DECIMAL(12,2) NOT NULL,
  PRIMARY KEY (`id`, `book_id`, `sale_id`),
  INDEX `fk_book_sale_book1_idx` (`book_id` ASC) VISIBLE,
  INDEX `fk_book_sale_sale1_idx` (`sale_id` ASC) VISIBLE,
  CONSTRAINT `fk_book_sale_book1`
    FOREIGN KEY (`book_id`)
    REFERENCES `language_school_ticoop_test`.`book` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_book_sale_sale1`
    FOREIGN KEY (`sale_id`)
    REFERENCES `language_school_ticoop_test`.`sale` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `language_school_ticoop_test`.`author` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(30) NOT NULL,
  `last_name` VARCHAR(75) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `language_school_ticoop_test`.`publishing_company` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(60) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `language_school_ticoop_test`.`contract_student` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `student_id` INT(11) NOT NULL,
  `contract_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`, `student_id`, `contract_id`),
  INDEX `fk_contract_student_student1_idx` (`student_id` ASC) VISIBLE,
  INDEX `fk_contract_student_contract1_idx` (`contract_id` ASC) VISIBLE,
  CONSTRAINT `fk_contract_student_student1`
    FOREIGN KEY (`student_id`)
    REFERENCES `language_school_ticoop_test`.`student` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_contract_student_contract1`
    FOREIGN KEY (`contract_id`)
    REFERENCES `language_school_ticoop_test`.`contract` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `language_school_ticoop_test`.`status` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `description` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
