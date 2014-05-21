express = require 'express'
route = express.Router()
config = require '../config/config'

receiver_controller = require config.root + '/app/controllers/receiver_controller'
users_controller = require config.root + '/app/controllers/users_controller'

route.get '/', (req, resp, next) ->
    resp.render 'index'
route
    .get '/receiver', receiver_controller.receiver
    .post '/receiver', receiver_controller.receiver
route
    .get '/users', users_controller.list

module.exports = route

