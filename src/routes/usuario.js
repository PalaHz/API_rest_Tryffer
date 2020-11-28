const express = require('express');
const router = express.Router();

const mysqlConnection = require('../database');

router.get('/usuario', (req, res) => {
    mysqlConnection.query('SELECT * FROM usuario', (err, rows, fields) =>{
        if(!err) {
            res.json(rows);
        } else {
            console.log(err);
        }
    });
});
router.get('/usuario/:id', (req,res) =>{
    const { id } = req.params;
    mysqlConnection.query('SELECT * FROM usuario WHERE idusuario = ?', [id], (err, rows, fields) => {
        if(!err) {
            res.json(rows);
        } else {
            console.log(err);
        }
    });
});

router.post('/usuario', (req, res) => {
    const { idusuario, nombre, apellido, correo, contrasenia, 
    foto} = req.body;
    const query = `
        CALL usuarioAddOrEdit(?, ?, ?, ?, ?, ?);
    `;
    mysqlConnection.query(query, [idusuario, nombre, apellido, correo, contrasenia, 
        foto], (err, rows, fields) =>{
            if(!err) {
                res.json({status: 'Usuario agregado'});
            } else {
                console.log(err);
            }
        });
});
router.put('/usuario/:idusuario', (req,res) => {
    const {  nombre, apellido, correo, contrasenia, 
        foto} = req.body;
    const { idusuario } = req.params;
    const query = `
        CALL usuarioAddOrEdit(?, ?, ?, ?, ?, ?);
    `;
    mysqlConnection.query(query, [idusuario, nombre, apellido, correo, contrasenia, 
        foto], (err, rows, fields) =>{
            if(!err) {
                res.json({status: 'Usuario editado'});
            } else {
                console.log(err);
            }
        });
});

router.delete('/usuario/:idusuario', (req,res) => {
    const { idusuario } = req.params;
    mysqlConnection.query('DELETE FROM usuario WHERE idusuario = ?', [idusuario], (err,
        rows, fields) =>{
            if(!err) {
                res.json({status: 'Usuario eliminado'});
            } else {
                console.log(err);
            }
        });
});

module.exports = router;