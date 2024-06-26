-- MySQL Script generated by MySQL Workbench
-- Wed Apr 17 14:32:26 2024
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema doenet2
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema doenet2
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `doenet2` DEFAULT CHARACTER SET utf8 ;
USE `doenet2` ;

-- -----------------------------------------------------
-- Table `doenet2`.`users`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `doenet2`.`users` ;

CREATE TABLE IF NOT EXISTS `doenet2`.`users` (
  `userId` INT NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`userId`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `doenet2`.`documents`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `doenet2`.`documents` ;

CREATE TABLE IF NOT EXISTS `doenet2`.`documents` (
  `docId` INT NOT NULL,
  `owner` INT NOT NULL,
  `contentLocation` VARCHAR(255) NULL,
  `lastEdited` DATETIME NULL,
  PRIMARY KEY (`docId`),
  INDEX `fk_activities_users_idx` (`owner` ASC) VISIBLE,
  UNIQUE INDEX `docId_UNIQUE` (`docId` ASC) VISIBLE,
  CONSTRAINT `fk_activities_users`
    FOREIGN KEY (`owner`)
    REFERENCES `doenet2`.`users` (`userId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `doenet2`.`activities`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `doenet2`.`activities` ;

CREATE TABLE IF NOT EXISTS `doenet2`.`activities` (
  `activityId` INT NOT NULL,
  `owner` INT NOT NULL,
  `name` VARCHAR(255) NULL,
  `createdAt` DATETIME NULL,
  `lastEdited` DATETIME NULL,
  PRIMARY KEY (`activityId`),
  INDEX `fk_assignments_users1_idx` (`owner` ASC) VISIBLE,
  UNIQUE INDEX `activityId_UNIQUE` (`activityId` ASC) VISIBLE,
  CONSTRAINT `fk_assignments_users1`
    FOREIGN KEY (`owner`)
    REFERENCES `doenet2`.`users` (`userId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `doenet2`.`documentVersions`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `doenet2`.`documentVersions` ;

CREATE TABLE IF NOT EXISTS `doenet2`.`documentVersions` (
  `version` INT NOT NULL,
  `docId` INT NOT NULL,
  `cid` VARCHAR(255) NULL,
  `createdAt` DATETIME NULL,
  PRIMARY KEY (`version`, `docId`),
  INDEX `fk_documents_activities1_idx` (`docId` ASC) VISIBLE,
  CONSTRAINT `fk_documents_activities1`
    FOREIGN KEY (`docId`)
    REFERENCES `doenet2`.`documents` (`docId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `doenet2`.`assignments`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `doenet2`.`assignments` ;

CREATE TABLE IF NOT EXISTS `doenet2`.`assignments` (
  `assignmentId` INT NOT NULL,
  `classCode` VARCHAR(45) NULL,
  `activityId` INT NOT NULL,
  `owner` INT NOT NULL,
  PRIMARY KEY (`assignmentId`),
  INDEX `fk_assignments_activities1_idx` (`activityId` ASC) VISIBLE,
  INDEX `fk_assignments_users2_idx` (`owner` ASC) VISIBLE,
  UNIQUE INDEX `assignmentId_UNIQUE` (`assignmentId` ASC) VISIBLE,
  CONSTRAINT `fk_assignments_activities1`
    FOREIGN KEY (`activityId`)
    REFERENCES `doenet2`.`activities` (`activityId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_assignments_users2`
    FOREIGN KEY (`owner`)
    REFERENCES `doenet2`.`users` (`userId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `doenet2`.`activityItems`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `doenet2`.`activityItems` ;

CREATE TABLE IF NOT EXISTS `doenet2`.`activityItems` (
  `activityId` INT NOT NULL,
  `docId` INT NOT NULL,
  PRIMARY KEY (`activityId`, `docId`),
  INDEX `fk_activities_has_documents_documents1_idx` (`docId` ASC) VISIBLE,
  INDEX `fk_activities_has_documents_activities1_idx` (`activityId` ASC) VISIBLE,
  CONSTRAINT `fk_activities_has_documents_activities1`
    FOREIGN KEY (`activityId`)
    REFERENCES `doenet2`.`activities` (`activityId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_activities_has_documents_documents1`
    FOREIGN KEY (`docId`)
    REFERENCES `doenet2`.`documents` (`docId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `doenet2`.`studentAssignmentResponses`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `doenet2`.`studentAssignmentResponses` ;

CREATE TABLE IF NOT EXISTS `doenet2`.`studentAssignmentResponses` (
  `assignmentId` INT NOT NULL,
  `userId` INT NOT NULL,
  `score` FLOAT NULL,
  PRIMARY KEY (`assignmentId`, `userId`),
  INDEX `fk_assignments_has_users_users1_idx` (`userId` ASC) VISIBLE,
  INDEX `fk_assignments_has_users_assignments1_idx` (`assignmentId` ASC) VISIBLE,
  CONSTRAINT `fk_assignments_has_users_assignments1`
    FOREIGN KEY (`assignmentId`)
    REFERENCES `doenet2`.`assignments` (`assignmentId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_assignments_has_users_users1`
    FOREIGN KEY (`userId`)
    REFERENCES `doenet2`.`users` (`userId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `doenet2`.`assignmentItems`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `doenet2`.`assignmentItems` ;

CREATE TABLE IF NOT EXISTS `doenet2`.`assignmentItems` (
  `assignmentId` INT NOT NULL,
  `docVersion` INT NOT NULL,
  `docId` INT NOT NULL,
  PRIMARY KEY (`assignmentId`, `docVersion`, `docId`),
  INDEX `fk_assignments_has_documentVersions_documentVersions1_idx` (`docVersion` ASC, `docId` ASC) VISIBLE,
  INDEX `fk_assignments_has_documentVersions_assignments1_idx` (`assignmentId` ASC) VISIBLE,
  CONSTRAINT `fk_assignments_has_documentVersions_assignments1`
    FOREIGN KEY (`assignmentId`)
    REFERENCES `doenet2`.`assignments` (`assignmentId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_assignments_has_documentVersions_documentVersions1`
    FOREIGN KEY (`docVersion` , `docId`)
    REFERENCES `doenet2`.`documentVersions` (`version` , `docId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `doenet2`.`studentItemResponses`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `doenet2`.`studentItemResponses` ;

CREATE TABLE IF NOT EXISTS `doenet2`.`studentItemResponses` (
  `assignmentId` INT NOT NULL,
  `docVersion` INT NOT NULL,
  `docId` INT NOT NULL,
  `userId` INT NOT NULL,
  `response` VARCHAR(255) NULL,
  PRIMARY KEY (`assignmentId`, `docVersion`, `docId`, `userId`),
  INDEX `fk_assignmentItems_has_users_users1_idx` (`userId` ASC) VISIBLE,
  INDEX `fk_assignmentItems_has_users_assignmentItems1_idx` (`assignmentId` ASC, `docVersion` ASC, `docId` ASC) VISIBLE,
  CONSTRAINT `fk_assignmentItems_has_users_assignmentItems1`
    FOREIGN KEY (`assignmentId` , `docVersion` , `docId`)
    REFERENCES `doenet2`.`assignmentItems` (`assignmentId` , `docVersion` , `docId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_assignmentItems_has_users_users1`
    FOREIGN KEY (`userId`)
    REFERENCES `doenet2`.`users` (`userId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
