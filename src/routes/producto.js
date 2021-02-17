const express = require('express');
const router = express.Router();

const mysqlConnection = require('../database');

router.get('/producto', (req, res) => {
    mysqlConnection.query('SELECT * FROM producto', (err, rows, fields) =>{
        if(!err) {
            res.json(rows);
        } else {
            console.log(err);
        }
    });
});
router.get('/producto/:id', (req,res) =>{
    const { id } = req.params;
    mysqlConnection.query('SELECT * FROM producto WHERE idproducto = ?', [id], (err, rows, fields) => {
        if(!err) {
            res.json(rows);
        } else {
            console.log(err);
        }
    });
});

router.post('/producto', (req, res) => {
    const {idproducto, nombre, precio,
        detalle, disponibilidad, negocio_idnegocio} = req.body;
    const query = `
        CALL productoAddOrEdit(?, ?, ?, ?, ?, ?);
    `;
    mysqlConnection.query(query, [idproducto, nombre, precio,
        detalle, disponibilidad, negocio_idnegocio], (err, rows, fields) =>{
            if(!err) {
                res.json({status: 'Producto agregado'});
            } else {
                console.log(err);
            }
        });
});


router.put('/producto/:idproducto', (req,res) => {
    const { idproducto } = req.params;
    const {nombre, precio,
        detalle, disponibilidad, negocio_idnegocio} = req.body;
    const query = `
        CALL productoAddOrEdit(?, ?, ?, ?, ?, ?);
    `;
    mysqlConnection.query(query, [idproducto, nombre, precio,
        detalle, disponibilidad, negocio_idnegocio], (err, rows, fields) =>{
            if(!err) {
                res.json({status: 'Producto editado'});
            } else {
                console.log(err);
            }
        });
});

router.delete('/producto/:idproducto', (req,res) => {
    const { idproducto } = req.params;
    mysqlConnection.query('DELETE FROM producto WHERE idproducto = ?', [idproducto], (err,
        rows, fields) =>{
            if(!err) {
                res.json({status: 'Producto eliminado'});
            } else {
                console.log(err);
            }
        });
});

module.exports = router;