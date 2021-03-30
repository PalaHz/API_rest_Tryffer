const express = require('express');
const router = express.Router();

const mysqlConnection = require('../database');

router.get('/oferta', (req, res) => {
    mysqlConnection.query('SELECT * FROM oferta', (err, rows, fields) => {
        if (!err) {
            res.json(rows);
        } else {
            console.log(err);
        }
    });
});
router.get('/oferta/:id', (req, res) => {
    const { id } = req.params;
    mysqlConnection.query('SELECT * FROM oferta WHERE idofertas = ?', [id], (err, rows, fields) => {
        if (!err) {
            res.json(rows);
        } else {
            console.log(err);
        }
    });
});

router.get('/oferta/categoria/:nombreCategoria', (req, res) => {
    const { nombreCategoria } = req.params;
    mysqlConnection.query('SELECT * FROM heroku_86fa010ccbe436d.oferta' +
        'WHERE negocioID' +
        'IN (SELECT idnegocio FROM heroku_86fa010ccbe436d.negocio WHERE idCategoria' +
        'IN (SELECT idCategoria FROM heroku_86fa010ccbe436d.categoria WHERE nombre = "?"));', [nombreCategoria], (err, rows, fields) => {
            if (!err) {
                res.json(rows);
            } else {
                console.log(err);
            }
        });
});


router.post('/oferta', (req, res) => {
    const {
        idofertas,
        fechaInicio,
        fechaFin,
        nombre,
        descripcion,
        incentivo,
        repiteSemanal,
        repiteMensual,
        producto_idproductos,
        imagen,
        negocioID
    } = req.body;
    const query = `
        CALL ofertaAddOrEdit(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);
    `;
    mysqlConnection.query(query, [idofertas, fechaInicio, fechaFin, nombre, descripcion,
        incentivo, repiteSemanal, repiteMensual, producto_idproductos, imagen, negocioID
    ], (err, rows, fields) => {
        if (!err) {
            res.json({ status: 'Oferta agregada' });
        } else {
            console.log(err);
        }
    });
});


router.put('/oferta/:idofertas', (req, res) => {
    const { idofertas } = req.params;
    const {
        fechaInicio,
        fechaFin,
        nombre,
        descripcion,
        incentivo,
        repiteSemanal,
        repiteMensual,
        producto_idproductos,
        imagen,
        negocioID
    } = req.body;
    const query = `
        CALL ofertaAddOrEdit(?, ?, ?, ?, ?, ?, ?);
    `;
    mysqlConnection.query(query, [idofertas, fechaInicio, fechaFin, nombre, descripcion,
        incentivo, repiteSemanal, repiteMensual, producto_idproductos, imagen, negocioID
    ], (err, rows, fields) => {
        if (!err) {
            res.json({ status: 'Oferta editada' });
        } else {
            console.log(err);
        }
    });
});

router.delete('/oferta/:idofertas', (req, res) => {
    const { idofertas } = req.params;
    mysqlConnection.query('DELETE FROM oferta WHERE idofertas = ?', [idofertas], (err,
        rows, fields) => {
        if (!err) {
            res.json({ status: 'Oferta eliminada' });
        } else {
            console.log(err);
        }
    });
});

module.exports = router;