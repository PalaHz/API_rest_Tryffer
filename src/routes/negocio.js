const express = require('express');
const router = express.Router();

const mysqlConnection = require('../database');

router.get('/negocio', (req, res) => {
    mysqlConnection.query('SELECT * FROM negocio', (err, rows, fields) =>{
        if(!err) {
            res.json(rows);
        } else {
            console.log(err);
        }
    });
});
router.get('/negocio/:id', (req,res) =>{
    const { id } = req.params;
    mysqlConnection.query('SELECT * FROM negocio WHERE idnegocio = ?', [id], (err, rows, fields) => {
        if(!err) {
            res.json(rows);
        } else {
            console.log(err);
        }
    });
});

router.post('/negocio', (req, res) => {
    const {idnegocio, nombre, descripcion, logo, horaApertura, horaCierre,
    telefono, sitioWeb, representante} = req.body;
    const query = `
        CALL negocioAddOrEdit(?, ?, ?, ?, ?, ?, ?, ?, ?);
    `;
    mysqlConnection.query(query, [idnegocio, nombre, descripcion, logo, horaApertura,
        horaCierre, telefono, sitioWeb, representante], (err, rows, fields) =>{
            if(!err) {
                res.json({status: 'Negocio agregado'});
            } else {
                console.log(err);
            }
        });
});


router.put('/negocio/:idnegocio', (req,res) => {
    const { idnegocio } = req.params;
    const {nombre, descripcion, logo, horaApertura, horaCierre,
        telefono, sitioWeb, representante} = req.body;
    const query = `
        CALL negocioAddOrEdit(?, ?, ?, ?, ?, ?, ?, ?, ?);
    `;
    mysqlConnection.query(query, [idnegocio, nombre, descripcion, logo, horaApertura, horaCierre,
        telefono, sitioWeb, representante], (err, rows, fields) =>{
            if(!err) {
                res.json({status: 'Negocio editado'});
            } else {
                console.log(err);
            }
        });
});

router.delete('/negocio/:idnegocio', (req,res) => {
    const { idnegocio } = req.params;
    mysqlConnection.query('DELETE FROM negocio WHERE idnegocio = ?', [idnegocio], (err,
        rows, fields) =>{
            if(!err) {
                res.json({status: 'Negocio eliminado'});
            } else {
                console.log(err);
            }
        });
});

module.exports = router;