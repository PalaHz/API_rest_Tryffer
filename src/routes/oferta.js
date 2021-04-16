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

router.get('/oferta/categoria/:idCategoria', (req, res) => {
    const { idCategoria } = req.params;
    mysqlConnection.query('SELECT oferta.* From heroku_86fa010ccbe436d.oferta ' +
        'INNER JOIN heroku_86fa010ccbe436d.producto ' +
        'ON oferta.producto_idproductos = producto.idproductos ' +
        'INNER JOIN heroku_86fa010ccbe436d.negocio ' +
        'ON negocio.idnegocio = producto.negocio_idnegocio ' +
        'INNER JOIN heroku_86fa010ccbe436d.subcategoria ' +
        'ON subcategoria.idSubcategoria = negocio.idSubcategoria ' +
        'INNER JOIN heroku_86fa010ccbe436d.categoria ' +
        'ON categoria.idcategoria = subcategoria.categoria_idcategoria ' +
        'AND categoria.idcategoria = ?;', [idCategoria], (err, rows, fields) => {
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
        repiteSemanal,
        repiteMensual,
        producto_idproductos,
        imagen
    } = req.body;
    const query = `
        CALL ofertaAddOrEdit(?, ?, ?, ?, ?, ?, ?, ?, ?);
    `;
    mysqlConnection.query(query, [idofertas, fechaInicio, fechaFin, nombre, descripcion,
        repiteSemanal, repiteMensual, producto_idproductos, imagen
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
        repiteSemanal,
        repiteMensual,
        producto_idproductos,
        imagen
    } = req.body;
    const query = `
        CALL ofertaAddOrEdit(?, ?, ?, ?, ?, ?, ?, ?, ?);
    `;
    mysqlConnection.query(query, [idofertas, fechaInicio, fechaFin, nombre, descripcion,
        repiteSemanal, repiteMensual, producto_idproductos, imagen
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