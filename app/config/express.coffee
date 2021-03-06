path = require 'path'
resp_time = require 'response-time'
compression = require 'compression'
body_parser = require 'body-parser'
error_handler = require 'errorhandler'
env = process.env.NODE_ENV || 'development'
routes = require '../routes'

module.exports = (app, express) ->
    app.set 'env', env
    app.set 'port', app.config.server.port || 8210
    app.set 'views', path.join(__dirname, '../views')
    app.set 'view engine', 'jade'

    app.enable 'trust proxy'
    app.disable 'x-powered-by'

    # app.use body_parser.json()
    # app.use body_parser.urlencoded()

    app.use express.static(path.join(app.config.root, 'public'))
    # simple logger
    if app.get('env') is 'development'
        app.use (req, res, next) ->
            console.log '%s %s', req.method, req.url
            next()

    app.use routes

    if app.get('env') is 'development'
        app.use error_handler()
        app.use resp_time()
    else
        app.use compression(
            filter: (req, res) ->
                /json|text|javascript|css/.test res.getHeader('Content-Type')
            level: 9
        )

    app.use (req, res, next) ->
        err = new Error('Not Found')
        res.status(404).render '404', 
            url: req.protocol + '://' + req.headers.host + req.originalUrl
            error: 'Page not found!!!'

    app.use (err, req, res, next) ->
        res.status err.status || 500
        res.render '500', 
            message: err.message
            error: {}