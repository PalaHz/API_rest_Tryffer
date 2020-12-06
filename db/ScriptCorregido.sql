-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema heroku_86fa010ccbe436d
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema heroku_86fa010ccbe436d
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `heroku_86fa010ccbe436d` DEFAULT CHARACTER SET utf8 ;
USE `heroku_86fa010ccbe436d` ;

-- -----------------------------------------------------
-- Table `heroku_86fa010ccbe436d`.`representante`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `heroku_86fa010ccbe436d`.`representante` (
  `idrepresentante` VARCHAR(20) NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `apellido` VARCHAR(45) NOT NULL,
  `cedula` VARCHAR(10) NOT NULL,
  `ruc` VARCHAR(13) NULL,
  `celular` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`idrepresentante`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `heroku_86fa010ccbe436d`.`negocio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `heroku_86fa010ccbe436d`.`negocio` (
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
  INDEX `fk_negocio_representante_idx` (`representante` ASC)  ,
  CONSTRAINT `fk_negocio_representante`
    FOREIGN KEY (`representante`)
    REFERENCES `heroku_86fa010ccbe436d`.`representante` (`idrepresentante`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `heroku_86fa010ccbe436d`.`ubicacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `heroku_86fa010ccbe436d`.`ubicacion` (
  `idubicacion` INT NOT NULL AUTO_INCREMENT,
  `negocio_idnegocio` VARCHAR(20) NOT NULL,
  `referencia` VARCHAR(100) NULL,
  `latitud` FLOAT NOT NULL,
  `longitud` FLOAT NOT NULL,
  PRIMARY KEY (`idubicacion`),
  INDEX `fk_ubicacion_negocio1_idx` (`negocio_idnegocio` ASC)  ,
  CONSTRAINT `fk_ubicacion_negocio1`
    FOREIGN KEY (`negocio_idnegocio`)
    REFERENCES `heroku_86fa010ccbe436d`.`negocio` (`idnegocio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `heroku_86fa010ccbe436d`.`producto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `heroku_86fa010ccbe436d`.`producto` (
  `idproductos` VARCHAR(45) NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `precio` FLOAT NOT NULL,
  `detalle` VARCHAR(100) NOT NULL,
  `disponibilidad` INT NOT NULL,
  `negocio_idnegocio` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`idproductos`),
  INDEX `fk_productos_negocio1_idx` (`negocio_idnegocio` ASC)  ,
  CONSTRAINT `fk_productos_negocio1`
    FOREIGN KEY (`negocio_idnegocio`)
    REFERENCES `heroku_86fa010ccbe436d`.`negocio` (`idnegocio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `heroku_86fa010ccbe436d`.`oferta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `heroku_86fa010ccbe436d`.`oferta` (
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
  INDEX `fk_oferta_producto1_idx` (`producto_idproductos` ASC)  ,
  CONSTRAINT `fk_oferta_producto1`
    FOREIGN KEY (`producto_idproductos`)
    REFERENCES `heroku_86fa010ccbe436d`.`producto` (`idproductos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `heroku_86fa010ccbe436d`.`categoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `heroku_86fa010ccbe436d`.`categoria` (
  `idcategoria` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `imgCategoria` VARCHAR(100) NOT NULL,
  `descripcion` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`idcategoria`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `heroku_86fa010ccbe436d`.`negocioTieneCategorias`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `heroku_86fa010ccbe436d`.`negocioTieneCategorias` (
  `negocio_idnegocio` VARCHAR(20) NOT NULL,
  `categoria_idcategoria` INT NOT NULL,
  PRIMARY KEY (`negocio_idnegocio`, `categoria_idcategoria`),
  INDEX `fk_negocio_has_categoria_categoria1_idx` (`categoria_idcategoria` ASC)  ,
  INDEX `fk_negocio_has_categoria_negocio1_idx` (`negocio_idnegocio` ASC)  ,
  CONSTRAINT `fk_negocio_has_categoria_negocio1`
    FOREIGN KEY (`negocio_idnegocio`)
    REFERENCES `heroku_86fa010ccbe436d`.`negocio` (`idnegocio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_negocio_has_categoria_categoria1`
    FOREIGN KEY (`categoria_idcategoria`)
    REFERENCES `heroku_86fa010ccbe436d`.`categoria` (`idcategoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `heroku_86fa010ccbe436d`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `heroku_86fa010ccbe436d`.`usuario` (
  `idusuario` VARCHAR(45) NOT NULL,
  `nombre` VARCHAR(60) NOT NULL,
  `apellido` VARCHAR(60) NOT NULL,
  `correo` VARCHAR(80) NOT NULL,
  `contrasenia` VARCHAR(80) NOT NULL,
  `foto` VARCHAR(100) NULL,
  PRIMARY KEY (`idusuario`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `heroku_86fa010ccbe436d`.`UsuarioPreferencias`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `heroku_86fa010ccbe436d`.`UsuarioPreferencias` (
  `usuario_idusuario` VARCHAR(45) NOT NULL,
  `categoria_idcategoria` INT NOT NULL,
  PRIMARY KEY (`usuario_idusuario`, `categoria_idcategoria`),
  INDEX `fk_usuario_has_categoria_categoria1_idx` (`categoria_idcategoria` ASC)  ,
  INDEX `fk_usuario_has_categoria_usuario1_idx` (`usuario_idusuario` ASC)  ,
  CONSTRAINT `fk_usuario_has_categoria_usuario1`
    FOREIGN KEY (`usuario_idusuario`)
    REFERENCES `heroku_86fa010ccbe436d`.`usuario` (`idusuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_usuario_has_categoria_categoria1`
    FOREIGN KEY (`categoria_idcategoria`)
    REFERENCES `heroku_86fa010ccbe436d`.`categoria` (`idcategoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `heroku_86fa010ccbe436d`.`valoracion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `heroku_86fa010ccbe436d`.`valoracion` (
  `usuario_idusuario` VARCHAR(45) NOT NULL,
  `comentario` VARCHAR(200) NULL,
  `estrellas` INT NULL,
  `negocio_idnegocio` VARCHAR(20) NOT NULL,
  INDEX `fk_Comentarios_usuario1_idx` (`usuario_idusuario` ASC)  ,
  INDEX `fk_valoracion_negocio1_idx` (`negocio_idnegocio` ASC)  ,
  CONSTRAINT `fk_Comentarios_usuario1`
    FOREIGN KEY (`usuario_idusuario`)
    REFERENCES `heroku_86fa010ccbe436d`.`usuario` (`idusuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_valoracion_negocio1`
    FOREIGN KEY (`negocio_idnegocio`)
    REFERENCES `heroku_86fa010ccbe436d`.`negocio` (`idnegocio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `heroku_86fa010ccbe436d`.`tokens`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `heroku_86fa010ccbe436d`.`tokens` (
  `idtokens` VARCHAR(45) NOT NULL,
  `usuario_idusuario` VARCHAR(45) NOT NULL,
  `token` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`idtokens`),
  INDEX `fk_tokens_usuario1_idx` (`usuario_idusuario` ASC)  ,
  CONSTRAINT `fk_tokens_usuario1`
    FOREIGN KEY (`usuario_idusuario`)
    REFERENCES `heroku_86fa010ccbe436d`.`usuario` (`idusuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `heroku_86fa010ccbe436d`.`UsuarioNegociosFavs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `heroku_86fa010ccbe436d`.`UsuarioNegociosFavs` (
  `usuario_idusuario` VARCHAR(45) NOT NULL,
  `negocio_idnegocio` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`usuario_idusuario`, `negocio_idnegocio`),
  INDEX `fk_usuario_has_negocio_negocio1_idx` (`negocio_idnegocio` ASC)  ,
  INDEX `fk_usuario_has_negocio_usuario1_idx` (`usuario_idusuario` ASC)  ,
  CONSTRAINT `fk_usuario_has_negocio_usuario1`
    FOREIGN KEY (`usuario_idusuario`)
    REFERENCES `heroku_86fa010ccbe436d`.`usuario` (`idusuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_usuario_has_negocio_negocio1`
    FOREIGN KEY (`negocio_idnegocio`)
    REFERENCES `heroku_86fa010ccbe436d`.`negocio` (`idnegocio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `heroku_86fa010ccbe436d`.`Busquedas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `heroku_86fa010ccbe436d`.`Busquedas` (
  `idBusquedas` INT NOT NULL AUTO_INCREMENT,
  `busqueda` VARCHAR(45) NULL,
  `usuario_idusuario` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idBusquedas`),
  INDEX `fk_Busquedas_usuario1_idx` (`usuario_idusuario` ASC)  ,
  CONSTRAINT `fk_Busquedas_usuario1`
    FOREIGN KEY (`usuario_idusuario`)
    REFERENCES `heroku_86fa010ccbe436d`.`usuario` (`idusuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `heroku_86fa010ccbe436d`.`etiquetas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `heroku_86fa010ccbe436d`.`etiquetas` (
  `idetiquetas` INT NOT NULL AUTO_INCREMENT,
  `etiqueta` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idetiquetas`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `heroku_86fa010ccbe436d`.`producto_has_etiquetas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `heroku_86fa010ccbe436d`.`producto_has_etiquetas` (
  `producto_idproductos` VARCHAR(45) NOT NULL,
  `etiquetas_idetiquetas` INT NOT NULL,
  PRIMARY KEY (`producto_idproductos`, `etiquetas_idetiquetas`),
  INDEX `fk_producto_has_etiquetas_etiquetas1_idx` (`etiquetas_idetiquetas` ASC)  ,
  INDEX `fk_producto_has_etiquetas_producto1_idx` (`producto_idproductos` ASC)  ,
  CONSTRAINT `fk_producto_has_etiquetas_producto1`
    FOREIGN KEY (`producto_idproductos`)
    REFERENCES `heroku_86fa010ccbe436d`.`producto` (`idproductos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_producto_has_etiquetas_etiquetas1`
    FOREIGN KEY (`etiquetas_idetiquetas`)
    REFERENCES `heroku_86fa010ccbe436d`.`etiquetas` (`idetiquetas`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `heroku_86fa010ccbe436d`.`ImagenProducto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `heroku_86fa010ccbe436d`.`ImagenProducto` (
  `idImagen` INT NOT NULL AUTO_INCREMENT,
  `imagen` VARCHAR(100) NOT NULL,
  `producto_idproductos` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idImagen`),
  INDEX `fk_ImagenProducto_producto1_idx` (`producto_idproductos` ASC)  ,
  CONSTRAINT `fk_ImagenProducto_producto1`
    FOREIGN KEY (`producto_idproductos`)
    REFERENCES `heroku_86fa010ccbe436d`.`producto` (`idproductos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `heroku_86fa010ccbe436d`.`subcategoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `heroku_86fa010ccbe436d`.`subcategoria` (
  `idsubcategoria` INT NOT NULL,
  `nombre` VARCHAR(45) NULL,
  `img` VARCHAR(45) NULL,
  `descripcion` VARCHAR(100) NULL,
  `categoria_idcategoria` INT NULL,
  PRIMARY KEY (`idsubcategoria`),
  INDEX `categoria_idcategoria_idx` (`categoria_idcategoria` ASC)  ,
  CONSTRAINT `categoria_idcategoria`
    FOREIGN KEY (`categoria_idcategoria`)
    REFERENCES `heroku_86fa010ccbe436d`.`categoria` (`idcategoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
