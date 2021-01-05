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

USE `heroku_86fa010ccbe436d`;
DROP procedure IF EXISTS `negocioAddOrEdit`;

DELIMITER $$
USE `heroku_86fa010ccbe436d`$$
CREATE PROCEDURE `negocioAddOrEdit` (
    IN _idnegocio VARCHAR(20),
    IN _nombre VARCHAR(45),
    IN _descripcion VARCHAR(250),
    IN _logo VARCHAR(100),
    IN _horaApertura TIME,
    IN _horaCierre TIME,
    IN _telefono VARCHAR(20),
    IN _sitioWeb VARCHAR(45),
    in _representante VARCHAR(20)
)
BEGIN
    REPLACE INTO negocio(idnegocio, nombre, descripcion,
    logo, horaApertura, horaCierre, telefono, sitioWeb, representante) 
    VALUES (_idnegocio, _nombre, _descripcion,
    _logo, _horaApertura, _horaCierre, _telefono, _sitioWeb, _representante);
    SELECT _idnegocio AS idnegocio;
END$$
;


DELIMITER $$
USE `heroku_86fa010ccbe436d`$$
CREATE DEFINER=`b5a6f22084c6df`@`%` PROCEDURE `ubicacionAddOrEdit`(
	IN _idubicacion VARCHAR(20),
    IN _negocio_idnegocio VARCHAR(20),
    IN _referencia VARCHAR(100),
    IN _latitud DECIMAL(10, 8),
    IN _longitud DECIMAL(11, 8)
)
BEGIN
	REPLACE INTO ubicacion(idubicacion, negocio_idnegocio, referencia,
    latitud, longitud) 
    VALUES (_idubicacion, _negocio_idnegocio, _referencia,
    _latitud, _longitud);
    SELECT _idubicacion AS idubicacion;
END$$

DELIMITER ;
;