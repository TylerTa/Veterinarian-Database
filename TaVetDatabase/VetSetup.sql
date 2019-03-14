-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema Vet
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Vet
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Vet` DEFAULT CHARACTER SET utf8 ;

-- -----------------------------------------------------
-- Table `Vet`.`CLIENT`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Vet`.`CLIENT` (
  `clientID` INT NOT NULL,
  `clientName` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`clientID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Vet`.`PET`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Vet`.`PET` (
  `petID` INT NOT NULL,
  `petName` VARCHAR(45) NOT NULL,
  `petSpecies` VARCHAR(45) NOT NULL,
  `petBirthday` DATE NOT NULL,
  `clientID` INT NULL,
  PRIMARY KEY (`petID`),
  INDEX `clientID PET_CLIENT_idx` (`clientID` ASC),
  CONSTRAINT `clientID PET_CLIENT`
    FOREIGN KEY (`clientID`)
    REFERENCES `Vet`.`CLIENT` (`clientID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Vet`.`STAFF`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Vet`.`STAFF` (
  `staffID` INT NOT NULL,
  `staffName` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`staffID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Vet`.`APPOINTMENT`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Vet`.`APPOINTMENT` (
  `appID` INT NOT NULL,
  `appDate` DATETIME NOT NULL,
  `petID` INT NOT NULL,
  `staffID` INT NOT NULL,
  PRIMARY KEY (`appID`),
  INDEX `petID APP_PET_idx` (`petID` ASC),
  INDEX `staffID APP_STAFF_idx` (`staffID` ASC),
  CONSTRAINT `petID APP_PET`
    FOREIGN KEY (`petID`)
    REFERENCES `Vet`.`PET` (`petID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `staffID APP_STAFF`
    FOREIGN KEY (`staffID`)
    REFERENCES `Vet`.`STAFF` (`staffID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Vet`.`TREATMENT`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Vet`.`TREATMENT` (
  `treatmentID` INT NOT NULL,
  `tDescription` TEXT NOT NULL,
  `tPrice` DECIMAL(5,2) NOT NULL,
  PRIMARY KEY (`treatmentID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Vet`.`ADMINISTER`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Vet`.`ADMINISTER` (
  `appID` INT NOT NULL,
  `treatmentID` INT NOT NULL,
  PRIMARY KEY (`appID`, `treatmentID`),
  INDEX `treatmentID ADMIN_TREAT_idx` (`treatmentID` ASC),
  CONSTRAINT `treatmentID ADMIN_TREAT`
    FOREIGN KEY (`treatmentID`)
    REFERENCES `Vet`.`TREATMENT` (`treatmentID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `appID ADMIN_APP`
    FOREIGN KEY (`appID`)
    REFERENCES `Vet`.`APPOINTMENT` (`appID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Vet`.`INVOICE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Vet`.`INVOICE` (
  `invoiceID` INT NOT NULL,
  `appID` INT NOT NULL,
  PRIMARY KEY (`invoiceID`),
  INDEX `appID INVOICE_APP_idx` (`appID` ASC),
  CONSTRAINT `appID INVOICE_APP`
    FOREIGN KEY (`appID`)
    REFERENCES `Vet`.`APPOINTMENT` (`appID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `vet2` ;

-- -----------------------------------------------------
-- Table `vet2`.`client`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `vet2`.`client` (
  `clientID` INT(11) NOT NULL,
  `clientName` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`clientID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `vet2`.`pet`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `vet2`.`pet` (
  `petID` INT(11) NOT NULL,
  `petName` VARCHAR(45) NOT NULL,
  `petSpecies` VARCHAR(45) NOT NULL,
  `petBirthday` DATE NOT NULL,
  `clientID` INT(11) NOT NULL,
  PRIMARY KEY (`petID`),
  INDEX `PET_CLIENT_ID_idx` (`clientID` ASC),
  CONSTRAINT `PET_CLIENT_ID`
    FOREIGN KEY (`clientID`)
    REFERENCES `vet2`.`client` (`clientID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `vet2`.`staff`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `vet2`.`staff` (
  `staffID` INT(11) NOT NULL,
  `staffName` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`staffID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `vet2`.`appointment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `vet2`.`appointment` (
  `appID` INT(11) NOT NULL,
  `appDate` DATETIME NOT NULL,
  `petID` INT(11) NOT NULL,
  `staffID` INT(11) NOT NULL,
  PRIMARY KEY (`appID`),
  INDEX `APP_PET_ID_idx` (`petID` ASC),
  INDEX `APP_STAFF_ID_idx` (`staffID` ASC),
  CONSTRAINT `APP_PET_ID`
    FOREIGN KEY (`petID`)
    REFERENCES `vet2`.`pet` (`petID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `APP_STAFF_ID`
    FOREIGN KEY (`staffID`)
    REFERENCES `vet2`.`staff` (`staffID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `vet2`.`treatment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `vet2`.`treatment` (
  `treatmentID` INT(11) NOT NULL,
  `tDescription` TEXT NOT NULL,
  `tPrice` DECIMAL(5,2) NOT NULL,
  PRIMARY KEY (`treatmentID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `vet2`.`administer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `vet2`.`administer` (
  `appID` INT(11) NOT NULL,
  `treatmentID` INT(11) NOT NULL,
  PRIMARY KEY (`appID`, `treatmentID`),
  INDEX `TREAT_ADMIN_APP_ID_idx` (`treatmentID` ASC),
  CONSTRAINT `APP_ADMIN_TREAT_ID`
    FOREIGN KEY (`appID`)
    REFERENCES `vet2`.`appointment` (`appID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `TREAT_ADMIN_APP_ID`
    FOREIGN KEY (`treatmentID`)
    REFERENCES `vet2`.`treatment` (`treatmentID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `vet2`.`invoice`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `vet2`.`invoice` (
  `invoiceID` INT(11) NOT NULL,
  `appID` INT(11) NOT NULL,
  PRIMARY KEY (`invoiceID`),
  INDEX `INVOICE_APP_ID_idx` (`appID` ASC),
  CONSTRAINT `INVOICE_APP_ID`
    FOREIGN KEY (`appID`)
    REFERENCES `vet2`.`appointment` (`appID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
