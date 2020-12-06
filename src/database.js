const mysql = require('mysql');

const mysqlConnection = mysql.createConnection({
    host: 'us-cdbr-east-02.cleardb.com',
    user: 'b5a6f22084c6df',
    password: 'a0147802',
    database: 'heroku_86fa010ccbe436d'
});
//mysql://b8e2ac4f444cd7:47fa8a16@us-cdbr-east-02.cleardb.com/heroku_f224201d36d4da4?reconnect=true
//b5a6f22084c6df:a0147802@us-cdbr-east-02.cleardb.com/heroku_86fa010ccbe436d
mysqlConnection.connect(function (err){
    if(err) {
        console.log(err);
        return;
    } else {
        console.log('Db connected')
    }
})

module.exports = mysqlConnection;