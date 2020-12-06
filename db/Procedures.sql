USE `heroku_86fa010ccbe436d`;
DROP procedure IF EXISTS `usuarioAddOrEdit`;

DELIMITER $$
USE `heroku_86fa010ccbe436d`$$
CREATE PROCEDURE usuarioAddOrEdit (
	IN _idusuario VARCHAR(45),
    IN _nombre VARCHAR(60),
    IN _apellido VARCHAR(60),
    IN _correo VARCHAR(80),
    IN _contrasenia VARCHAR(80),
    IN _foto VARCHAR(100)
)
BEGIN
	REPLACE INTO usuario(idusuario, nombre, apellido,
    correo, contrasenia, foto) 
    VALUES (_idusuario, _nombre, _apellido,
    _correo, _contrasenia, _foto);
    SELECT _idusuario AS idusuario;
END$$
DELIMITER ;

USE `heroku_86fa010ccbe436d`;
DROP procedure IF EXISTS `representanteAddOrEdit`;

DELIMITER $$
USE `heroku_86fa010ccbe436d`$$
CREATE PROCEDURE representanteAddOrEdit (
	IN _idrepresentante VARCHAR(20),
    IN _nombre VARCHAR(45),
    IN _apellido VARCHAR(45),
    IN _cedula VARCHAR(10),
    IN _ruc VARCHAR(13),
    IN _celular VARCHAR(10)
)
BEGIN
	REPLACE INTO representante(idrepresentante, nombre, apellido,
    cedula, ruc, celular) 
    VALUES (_idrepresentante, _nombre, _apellido,
    _cedula, _ruc, _celular);
    SELECT _idrepresentante AS idrepresentante;
END$$

DELIMITER ;


USE `heroku_86fa010ccbe436d`;
DROP procedure IF EXISTS `heroku_86fa010ccbe436d`.`categoriaAddOrEdit`;
;

DELIMITER $$
USE `heroku_86fa010ccbe436d`$$
CREATE DEFINER=`b5a6f22084c6df`@`%` PROCEDURE `categoriaAddOrEdit`(
IN _idcategoria INT,
    IN _nombre VARCHAR(45),
    IN _imgCategoria VARCHAR(100),
    IN _descripcion VARCHAR(45)
)
BEGIN
    IF _idcategoria = 0 THEN
    INSERT INTO categoria( nombre, imgCategoria, descripcion)
    VALUES ( _nombre, _imgCategoria, _descripcion);
    ELSE
    UPDATE categoria
    SET
    nombre = _nombre,
    imgCategoria = _imgCategoria,
    descripcion = _descripcion
    WHERE idcategoria = _idcategoria;
    END IF;
    SELECT _idcategoria AS idcategoria;
END$$

DELIMITER ;
;
