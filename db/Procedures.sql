USE `tryffer`;
DROP procedure IF EXISTS `usuarioAddOrEdit`;

DELIMITER $$
USE `tryffer`$$
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

USE `tryffer`;
DROP procedure IF EXISTS `representanteAddOrEdit`;

DELIMITER $$
USE `tryffer`$$
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

