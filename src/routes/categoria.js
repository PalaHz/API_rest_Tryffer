const express = require('express');
const router = express.Router();

const mysqlConnection = require('../database');

router.get('/categoria', (req, res) => {
    mysqlConnection.query('SELECT * FROM categoria', (err, rows, fields) => {
        if (!err) {
            res.json(rows);
        } else {
            console.log(err);
        }
    });
});
router.get('/categoria/:id', (req, res) => {
    const { id } = req.params;
    mysqlConnection.query('SELECT * FROM categoria WHERE idcategoria = ?', [id], (err, rows, fields) => {
        if (!err) {
            res.json(rows);
        } else {
            console.log(err);
        }
    });
});
router.get('/categoria/negocio/:idCategoria', (req, res) => {
    const { idCategoria } = req.params;
    mysqlConnection.query('SELECT negocio.* From heroku_86fa010ccbe436d.negocio ' +
        'INNER JOIN subcategoria ' +
        'ON negocio.idSubcategoria = subcategoria.idSubcategoria ' +
        'INNER JOIN categoria ON subcategoria.categoria_idcategoria = categoria.idcategoria ' +
        'AND categoria.idcategoria = ?;', [idCategoria], (err, rows, fields) => {
            if (!err) {
                res.json(rows);
            } else {
                console.log(err);
            }
        });
});

router.post('/categoria', (req, res) => {
    const { idcategoria, nombre, imgCategoria, descripcion } = req.body;
    const query = `
        CALL categoriaAddOrEdit(?, ?, ?, ?);
    `;
    mysqlConnection.query(query, [idcategoria, nombre, imgCategoria, descripcion], (err, rows, fields) => {
        if (!err) {
            res.json({ status: 'Categoria agregada' });
        } else {
            console.log(err);
        }
    });
});

router.put('/categoria/:idcategoria', (req, res) => {
    const { nombre, imgCategoria, descripcion } = req.body;
    const { idcategoria } = req.params;
    const query = `
        CALL categoriaAddOrEdit(?, ?, ?, ?);
    `;
    mysqlConnection.query(query, [idcategoria, nombre, imgCategoria, descripcion], (err, rows, fields) => {
        if (!err) {
            res.json({ status: 'Categoria agregada' });
        } else {
            console.log(err);
        }
    });
});

router.delete('/categoria/:idcategoria', (req, res) => {
    const { idcategoria } = req.params;
    mysqlConnection.query('DELETE FROM categoria WHERE idcategoria = ?', [idcategoria], (err,
        rows, fields) => {
        if (!err) {
            res.json({ status: 'Categoria eliminada' });
        } else {
            console.log(err);
        }
    });
});


module.exports = router;