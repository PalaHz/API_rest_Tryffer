const express = require('express');
const router = express.Router();

const mysqlConnection = require('../database');

router.get('/representante', (req, res) => {
    mysqlConnection.query('SELECT * FROM representante', (err, rows, fields) =>{
        if(!err) {
            res.json(rows);
        } else {
            console.log(err);
        }
    });
});
router.get('/representante/:id', (req,res) =>{
    const { id } = req.params;
    mysqlConnection.query('SELECT * FROM representante WHERE idrepresentante = ?', [id], (err, rows, fields) => {
        if(!err) {
            res.json(rows);
        } else {
            console.log(err);
        }
    });
});

router.post('/representante', (req, res) => {
    const {idrepresentante, nombre, apellido, cedula, ruc, 
    celular} = req.body;
    const query = `
        CALL representanteAddOrEdit(?, ?, ?, ?, ?, ?);
    `;
    mysqlConnection.query(query, [idrepresentante, nombre, apellido, cedula, ruc, 
        celular], (err, rows, fields) =>{
            if(!err) {
                res.json({status: 'Representante agregado'});
            } else {
                console.log(err);
            }
        });
});

router.put('/representante/:idrepresentante', (req,res) => {
    const { nombre, apellido, cedula, ruc, 
        celular} = req.body;
    const { idrepresentante } = req.params;
    const query = `
        CALL representanteAddOrEdit(?, ?, ?, ?, ?, ?);
    `;
    mysqlConnection.query(query, [idrepresentante, nombre, apellido, cedula, ruc, 
        celular], (err, rows, fields) =>{
            if(!err) {
                res.json({status: 'Representante agregado'});
            } else {
                console.log(err);
            }
        });
});

router.delete('/representante/:idrepresentante', (req,res) => {
    const { idrepresentante } = req.params;
    mysqlConnection.query('DELETE FROM representante WHERE idrepresentante = ?', [idrepresentante], (err,
        rows, fields) =>{
            if(!err) {
                res.json({status: 'Representante eliminado'});
            } else {
                console.log(err);
            }
        });
});

module.exports = router;