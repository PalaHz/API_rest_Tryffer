-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema tryffer
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema tryffer
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `tryffer` DEFAULT CHARACTER SET utf8 ;
USE `tryffer` ;

-- -----------------------------------------------------
-- Table `tryffer`.`representante`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tryffer`.`representante` (
  `idrepresentante` VARCHAR(20) NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `apellido` VARCHAR(45) NOT NULL,
  `cedula` VARCHAR(10) NOT NULL,
  `ruc` VARCHAR(13) NULL,
  `celular` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`idrepresentante`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tryffer`.`negocio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tryffer`.`negocio` (
  `idnegocio` VARCHAR(20) NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `descripcion` VARCHAR(250) NOT NULL,
  `logo` VARCHAR(100) NULL,
  `horaApertura` TIME NOT NULL,
  `horaCierre` TIME NOT NULL,
  `telefono` VARCHAR(10) NULL,
  `sitioWeb` VARCHAR(45) NULL,
  `representante` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`idnegocio`),
  INDEX `fk_negocio_representante_idx` (`representante` ASC) VISIBLE,
  CONSTRAINT `fk_negocio_representante`
    FOREIGN KEY (`representante`)
    REFERENCES `tryffer`.`representante` (`idrepresentante`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tryffer`.`ubicacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tryffer`.`ubicacion` (
  `idubicacion` INT NOT NULL AUTO_INCREMENT,
  `negocio_idnegocio` VARCHAR(20) NOT NULL,
  `referencia` VARCHAR(100) NULL,
  `latitud` FLOAT NOT NULL,
  `longitud` FLOAT NOT NULL,
  PRIMARY KEY (`idubicacion`),
  INDEX `fk_ubicacion_negocio1_idx` (`negocio_idnegocio` ASC) VISIBLE,
  CONSTRAINT `fk_ubicacion_negocio1`
    FOREIGN KEY (`negocio_idnegocio`)
    REFERENCES `tryffer`.`negocio` (`idnegocio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE `tryffer`.`subcategoria` (
  `idsubcategoria` INT NOT NULL,
  `nombre` VARCHAR(45) NULL,
  `imgSubcat` VARCHAR(45) NULL,
  `descripcion` VARCHAR(150) NULL,
  `idcategoria` INT NULL,
  PRIMARY KEY (`idsubcategoria`),
  INDEX `idcategoria_idx` (`idcategoria` ASC) VISIBLE,
  CONSTRAINT `idcategoria`
    FOREIGN KEY (`idcategoria`)
    REFERENCES `tryffer`.`categoria` (`idcategoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- -----------------------------------------------------
-- Table `tryffer`.`producto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tryffer`.`producto` (
  `idproductos` VARCHAR(45) NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `precio` FLOAT NOT NULL,
  `detalle` VARCHAR(100) NOT NULL,
  `disponibilidad` INT NOT NULL,
  `negocio_idnegocio` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`idproductos`),
  INDEX `fk_productos_negocio1_idx` (`negocio_idnegocio` ASC) VISIBLE,
  CONSTRAINT `fk_productos_negocio1`
    FOREIGN KEY (`negocio_idnegocio`)
    REFERENCES `tryffer`.`negocio` (`idnegocio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tryffer`.`oferta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tryffer`.`oferta` (
  `idofertas` VARCHAR(45) NOT NULL,
  `fechaInicio` DATE NOT NULL,
  `fechaFin` DATE NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `descripcion` VARCHAR(100) NULL,
  `incentivo` VARCHAR(100) NULL,
  `repiteSemanal` INT NOT NULL,
  `repiteMensual` INT NOT NULL,
  `producto_idproductos` VARCHAR(45) NOT NULL,
  `imagen` VARCHAR(100) NULL,
  PRIMARY KEY (`idofertas`),
  INDEX `fk_oferta_producto1_idx` (`producto_idproductos` ASC) VISIBLE,
  CONSTRAINT `fk_oferta_producto1`
    FOREIGN KEY (`producto_idproductos`)
    REFERENCES `tryffer`.`producto` (`idproductos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tryffer`.`categoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tryffer`.`categoria` (
  `idcategoria` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `imgCategoria` VARCHAR(100) NOT NULL,
  `descripcion` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idcategoria`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tryffer`.`negocioTieneCategorias`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tryffer`.`negocioTieneCategorias` (
  `negocio_idnegocio` VARCHAR(20) NOT NULL,
  `categoria_idcategoria` INT NOT NULL,
  PRIMARY KEY (`negocio_idnegocio`, `categoria_idcategoria`),
  INDEX `fk_negocio_has_categoria_categoria1_idx` (`categoria_idcategoria` ASC) VISIBLE,
  INDEX `fk_negocio_has_categoria_negocio1_idx` (`negocio_idnegocio` ASC) VISIBLE,
  CONSTRAINT `fk_negocio_has_categoria_negocio1`
    FOREIGN KEY (`negocio_idnegocio`)
    REFERENCES `tryffer`.`negocio` (`idnegocio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_negocio_has_categoria_categoria1`
    FOREIGN KEY (`categoria_idcategoria`)
    REFERENCES `tryffer`.`categoria` (`idcategoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tryffer`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tryffer`.`usuario` (
  `idusuario` VARCHAR(45) NOT NULL,
  `nombre` VARCHAR(60) NOT NULL,
  `apellido` VARCHAR(60) NOT NULL,
  `correo` VARCHAR(80) NOT NULL,
  `contrasenia` VARCHAR(80) NOT NULL,
  `foto` VARCHAR(100) NULL,
  PRIMARY KEY (`idusuario`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tryffer`.`UsuarioPreferencias`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tryffer`.`UsuarioPreferencias` (
  `usuario_idusuario` VARCHAR(45) NOT NULL,
  `categoria_idcategoria` INT NOT NULL,
  PRIMARY KEY (`usuario_idusuario`, `categoria_idcategoria`),
  INDEX `fk_usuario_has_categoria_categoria1_idx` (`categoria_idcategoria` ASC) VISIBLE,
  INDEX `fk_usuario_has_categoria_usuario1_idx` (`usuario_idusuario` ASC) VISIBLE,
  CONSTRAINT `fk_usuario_has_categoria_usuario1`
    FOREIGN KEY (`usuario_idusuario`)
    REFERENCES `tryffer`.`usuario` (`idusuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_usuario_has_categoria_categoria1`
    FOREIGN KEY (`categoria_idcategoria`)
    REFERENCES `tryffer`.`categoria` (`idcategoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tryffer`.`valoracion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tryffer`.`valoracion` (
  `usuario_idusuario` VARCHAR(45) NOT NULL,
  `comentario` VARCHAR(200) NULL,
  `estrellas` INT NULL,
  `negocio_idnegocio` VARCHAR(20) NOT NULL,
  INDEX `fk_Comentarios_usuario1_idx` (`usuario_idusuario` ASC) VISIBLE,
  INDEX `fk_valoracion_negocio1_idx` (`negocio_idnegocio` ASC) VISIBLE,
  CONSTRAINT `fk_Comentarios_usuario1`
    FOREIGN KEY (`usuario_idusuario`)
    REFERENCES `tryffer`.`usuario` (`idusuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_valoracion_negocio1`
    FOREIGN KEY (`negocio_idnegocio`)
    REFERENCES `tryffer`.`negocio` (`idnegocio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tryffer`.`tokens`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tryffer`.`tokens` (
  `idtokens` VARCHAR(45) NOT NULL,
  `usuario_idusuario` VARCHAR(45) NOT NULL,
  `token` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`idtokens`),
  INDEX `fk_tokens_usuario1_idx` (`usuario_idusuario` ASC) VISIBLE,
  CONSTRAINT `fk_tokens_usuario1`
    FOREIGN KEY (`usuario_idusuario`)
    REFERENCES `tryffer`.`usuario` (`idusuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tryffer`.`UsuarioNegociosFavs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tryffer`.`UsuarioNegociosFavs` (
  `usuario_idusuario` VARCHAR(45) NOT NULL,
  `negocio_idnegocio` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`usuario_idusuario`, `negocio_idnegocio`),
  INDEX `fk_usuario_has_negocio_negocio1_idx` (`negocio_idnegocio` ASC) VISIBLE,
  INDEX `fk_usuario_has_negocio_usuario1_idx` (`usuario_idusuario` ASC) VISIBLE,
  CONSTRAINT `fk_usuario_has_negocio_usuario1`
    FOREIGN KEY (`usuario_idusuario`)
    REFERENCES `tryffer`.`usuario` (`idusuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_usuario_has_negocio_negocio1`
    FOREIGN KEY (`negocio_idnegocio`)
    REFERENCES `tryffer`.`negocio` (`idnegocio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tryffer`.`Busquedas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tryffer`.`Busquedas` (
  `idBusquedas` INT NOT NULL AUTO_INCREMENT,
  `busqueda` VARCHAR(45) NULL,
  `usuario_idusuario` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idBusquedas`),
  INDEX `fk_Busquedas_usuario1_idx` (`usuario_idusuario` ASC) VISIBLE,
  CONSTRAINT `fk_Busquedas_usuario1`
    FOREIGN KEY (`usuario_idusuario`)
    REFERENCES `tryffer`.`usuario` (`idusuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tryffer`.`etiquetas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tryffer`.`etiquetas` (
  `idetiquetas` INT NOT NULL AUTO_INCREMENT,
  `etiqueta` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idetiquetas`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tryffer`.`producto_has_etiquetas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tryffer`.`producto_has_etiquetas` (
  `producto_idproductos` VARCHAR(45) NOT NULL,
  `etiquetas_idetiquetas` INT NOT NULL,
  PRIMARY KEY (`producto_idproductos`, `etiquetas_idetiquetas`),
  INDEX `fk_producto_has_etiquetas_etiquetas1_idx` (`etiquetas_idetiquetas` ASC) VISIBLE,
  INDEX `fk_producto_has_etiquetas_producto1_idx` (`producto_idproductos` ASC) VISIBLE,
  CONSTRAINT `fk_producto_has_etiquetas_producto1`
    FOREIGN KEY (`producto_idproductos`)
    REFERENCES `tryffer`.`producto` (`idproductos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_producto_has_etiquetas_etiquetas1`
    FOREIGN KEY (`etiquetas_idetiquetas`)
    REFERENCES `tryffer`.`etiquetas` (`idetiquetas`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tryffer`.`ImagenProducto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tryffer`.`ImagenProducto` (
  `idImagen` INT NOT NULL AUTO_INCREMENT,
  `imagen` VARCHAR(100) NOT NULL,
  `producto_idproductos` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idImagen`),
  INDEX `fk_ImagenProducto_producto1_idx` (`producto_idproductos` ASC) VISIBLE,
  CONSTRAINT `fk_ImagenProducto_producto1`
    FOREIGN KEY (`producto_idproductos`)
    REFERENCES `tryffer`.`producto` (`idproductos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
