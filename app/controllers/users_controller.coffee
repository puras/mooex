
class UsersController
    list: (req, resp) ->
        resp.send 'UsersController list method'

module.exports = new UsersController()