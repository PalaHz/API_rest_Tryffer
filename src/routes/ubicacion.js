const express = require('express');
const router = express.Router();

const mysqlConnection = require('../database');

router.get('/ubicacion', (req, res) => {
    mysqlConnection.query('SELECT * FROM ubicacion', (err, rows, fields) =>{
        if(!err) {
            res.json(rows);
        } else {
            console.log(err);
        }
    });
});
router.get('/ubicacion/:id', (req,res) =>{
    const { id } = req.params;
    mysqlConnection.query('SELECT * FROM ubicacion WHERE idubicacion = ?', [id], (err, rows, fields) => {
        if(!err) {
            res.json(rows);
        } else {
            console.log(err);
        }
    });
});

router.post('/ubicacion', (req, res) => {
    const { idubicacion, negocio_idnegocio, referencia,
        latitud, longitud} = req.body;
    const query = `
        CALL ubicacionAddOrEdit(?, ?, ?, ?, ?);
    `;
    mysqlConnection.query(query, [idubicacion, negocio_idnegocio, referencia,
        latitud, longitud], (err, rows, fields) =>{
            if(!err) {
                res.json({status: 'Ubicacion agregada'});
            } else {
                console.log(err);
            }
        });
});
router.put('/ubicacion/:idubicacion', (req,res) => {
    const {negocio_idnegocio, referencia,
        latitud, longitud} = req.body;
    const { idubicacion } = req.params;
    const query = `
        CALL ubicacionAddOrEdit(?, ?, ?, ?, ?);
    `;
    mysqlConnection.query(query, [ idubicacion, negocio_idnegocio, referencia,
        latitud, longitud], (err, rows, fields) =>{
            if(!err) {
                res.json({status: 'Ubicacion editada'});
            } else {
                console.log(err);
            }
        });
});

router.delete('/ubicacion/:idubicacion', (req,res) => {
    const { idubicacion } = req.params;
    mysqlConnection.query('DELETE FROM ubicacion WHERE idubicacion = ?', [idubicacion], (err,
        rows, fields) =>{
            if(!err) {
                res.json({status: 'Ubicacion eliminada'});
            } else {
                console.log(err);
            }
        });
});

module.exports = router;