const express = require('express');
const router = express.Router();

const mysqlConnection = require('../database');

router.get('/negocio', (req, res) => {
    mysqlConnection.query('SELECT * FROM negocio', (err, rows, fields) => {
        if (!err) {
            res.json(rows);
        } else {
            console.log(err);
        }
    });
});
router.get('/negocio/:id', (req, res) => {
    const { id } = req.params;
    mysqlConnection.query('SELECT * FROM negocio WHERE idnegocio = ?', [id], (err, rows, fields) => {
        if (!err) {
            res.json(rows);
        } else {
            console.log(err);
        }
    });
});

router.get('/negocio/oferta/:idnegocio', (req, res) => {
    const { idnegocio } = req.params;
    mysqlConnection.query('SELECT oferta.* From heroku_86fa010ccbe436d.oferta' +
        'INNER JOIN heroku_86fa010ccbe436d.producto ' +
        'ON oferta.producto_idproductos = producto.idproductos' +
        'AND producto.negocio_idnegocio = ?;', [idnegocio], (err, rows, fields) => {
            if (!err) {
                res.json(rows);
            } else {
                console.log(err);
            }
        });
});

router.get('/negocio/categoria/:idnegocio', (req, res) => {
    const { idnegocio } = req.params;
    mysqlConnection.query('SELECT categoria.* FROM heroku_86fa010ccbe436d.categoria ' +
        'WHERE idcategoria ' +
        'IN (SELECT categoria_idcategoria FROM heroku_86fa010ccbe436d.subcategoria WHERE idsubcategoria ' +
        'IN (SELECT idSubcategoria FROM heroku_86fa010ccbe436d.negocio WHERE negocio.idnegocio = ?) );', [idnegocio], (err, rows, fields) => {
            if (!err) {
                res.json(rows);
            } else {
                console.log(err);
            }
        });
});

router.post('/negocio', (req, res) => {
    const {
        idnegocio,
        nombre,
        descripcion,
        logo,
        horaApertura,
        horaCierre,
        telefono,
        sitioWeb,
        representante,
        idSubcategoria
    } = req.body;
    const query = `
        CALL negocioAddOrEdit(?, ?, ?, ?, ?, ?, ?, ?, ?, ?);
    `;
    mysqlConnection.query(query, [idnegocio, nombre, descripcion, logo, horaApertura,
        horaCierre, telefono, sitioWeb, representante, idSubcategoria
    ], (err, rows, fields) => {
        if (!err) {
            res.json({ status: 'Negocio agregado' });
        } else {
            console.log(err);
        }
    });
});


router.put('/negocio/:idnegocio', (req, res) => {
    const { idnegocio } = req.params;
    const {
        nombre,
        descripcion,
        logo,
        horaApertura,
        horaCierre,
        telefono,
        sitioWeb,
        representante,
        idSubcategoria
    } = req.body;
    const query = `
        CALL negocioAddOrEdit(?, ?, ?, ?, ?, ?, ?, ?, ?);
    `;
    mysqlConnection.query(query, [idnegocio, nombre, descripcion, logo, horaApertura, horaCierre,
        telefono, sitioWeb, representante, idSubcategoria
    ], (err, rows, fields) => {
        if (!err) {
            res.json({ status: 'Negocio editado' });
        } else {
            console.log(err);
        }
    });
});

router.delete('/negocio/:idnegocio', (req, res) => {
    const { idnegocio } = req.params;
    mysqlConnection.query('DELETE FROM negocio WHERE idnegocio = ?', [idnegocio], (err,
        rows, fields) => {
        if (!err) {
            res.json({ status: 'Negocio eliminado' });
        } else {
            console.log(err);
        }
    });
});

module.exports = router;