const express = require('express');
const app = express();

// Config
app.set('port', process.env.PORT || 3000);

// Middlewares
app.use(express.json());

// Routes
app.use(require('./routes/usuario'));
app.use(require('./routes/representante'));
app.use(require('./routes/categoria'));
// Start server
app.listen(app.get('port'), () => {
    console.log ('server on port ', app.get('port'))
});