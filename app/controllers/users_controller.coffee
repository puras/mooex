
class UsersController
    list: (req, res) ->
        res.send 'UsersController list method'

module.exports = new UsersController()