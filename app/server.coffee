express = require 'express'
config = require __dirname + '/config/config'
app = express()

app.config = config

require(__dirname + '/config/express')(app, express)

app.listen app.get('port'), ->
    console.log "\n✔ Express server listening on port %d in %s mode", app.get('port'), app.get('env')

module.exports = app