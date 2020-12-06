const express = require('express');
const wakeDyno = require("woke-dyno");
const app = express();


// Config

app.set('port', process.env.PORT || 3000);
app.listen(app.get('port'), () => {
    wakeDyno(tryffer-apirest.herokuapp.com/usuario).start(); // DYNO_URL should be the url of your Heroku app
});
// Middlewares
app.use(express.json());

// Routes
//app.get('/',(req,res) =>{
//    res.send('Bienvenido a Tryffer API');
//});
app.use(require('./routes/usuario'));
app.use(require('./routes/representante'));
app.use(require('./routes/categoria'));
// Start server
app.listen(app.get('port'), () => {
    console.log ('server on port ', app.get('port'))
});