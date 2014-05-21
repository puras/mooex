express = require 'express'
route = express.Router()
config = require '../config/config'

receiver_controller = require config.root + '/app/controllers/receiver'

route.get '/', (req, resp, next) ->
    resp.render 'index'
route.get '/receiver', receiver_controller.receiver

module.exports = route