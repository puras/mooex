path = require 'path'
root_path = path.normalize __dirname + '/../..'
config = 
    development: 
        server:
            port: 8210
            hostname: 'localhost'
        root: root_path

module.exports = config[process.env.NODE_ENV || 'development']