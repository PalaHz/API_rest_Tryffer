const express = require('express');
const wakeDyno = require("woke-dyno");
const app = express();


// Config

app.set('port', process.env.PORT || 3000);

// Middlewares
app.use(express.json());

// Routes
//app.get('/',(req,res) =>{
//    res.send('Bienvenido a Tryffer API');
//});
app.use(require('./routes/usuario'));
app.use(require('./routes/representante'));
app.use(require('./routes/categoria'));
app.use(require('./routes/negocio'));
app.use(require('./routes/ubicacion'));
// Start server
app.listen(app.get('port'), () => {
    console.log('Server on port', app.get('port'));
    wakeDyno({
        url: "https://tryffer-apirest.herokuapp.com/usuario",  // url string
        interval: 20000, // interval in milliseconds (1 minute in this example)
        startNap: [12, 0, 0, 0], // the time to start nap in UTC, as [h, m, s, ms] (05:00 UTC in this example)
        endNap: [13, 00, 10, 000] // time to wake up again, in UTC (09:59:59.999 in this example)
    }).start(); 
});