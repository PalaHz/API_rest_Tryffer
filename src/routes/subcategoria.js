const express = require('express');
const router = express.Router();

const mysqlConnection = require('../database');

router.get('/subcategoria', (req, res) => {
    mysqlConnection.query('SELECT * FROM subcategoria', (err, rows, fields) => {
        if (!err) {
            res.json(rows);
        } else {
            console.log(err);
        }
    });
});
router.get('/subcategoria/:id', (req, res) => {
    const { id } = req.params;
    mysqlConnection.query('SELECT * FROM subcategoria WHERE idsubcategoria = ?', [id], (err, rows, fields) => {
        if (!err) {
            res.json(rows);
        } else {
            console.log(err);
        }
    });
});

router.get('/subcategoria/negocio/:idSubcategoria', (req, res) => {
    const { idSubcategoria } = req.params;
    mysqlConnection.query('SELECT * FROM heroku_86fa010ccbe436d.negocio where idSubcategoria = ?', [idSubcategoria], (err, rows, fields) => {
        if (!err) {
            res.json(rows);
        } else {
            console.log(err);
        }
    });
});

router.post('/subcategoria', (req, res) => {
    const { idsubcategoria, nombre, img, descripcion, categoria_idcategoria } = req.body;
    const query = `
        CALL subcategoriaAddOrEdit(?, ?, ?, ?, ?);
    `;
    mysqlConnection.query(query, [idsubcategoria, nombre, img, descripcion, categoria_idcategoria], (err, rows, fields) => {
        if (!err) {
            res.json({ status: 'Subcategoria agregada' });
        } else {
            console.log(err);
        }
    });
});

router.delete('/subcategoria/:idsubcategoria', (req, res) => {
    const { idsubcategoria } = req.params;
    mysqlConnection.query('DELETE FROM subcategoria WHERE idsubcategoria = ?', [idsubcategoria], (err,
        rows, fields) => {
        if (!err) {
            res.json({ status: 'Categoria eliminada' });
        } else {
            console.log(err);
        }
    });
});


module.exports = router;