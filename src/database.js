const mysql = require('mysql');

const mysqlConnection = mysql.createConnection({
    host: 'us-cdbr-east-02.cleardb.com',
    user: 'b8e2ac4f444cd7',
    password: '47fa8a16',
    database: 'heroku_f224201d36d4da4'
});


mysqlConnection.connect(function (err){
    if(err) {
        console.log(err);
        return;
    } else {
        console.log('Db connected')
    }
})

module.exports = mysqlConnection;