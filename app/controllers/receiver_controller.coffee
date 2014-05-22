BufferHelper = require 'bufferhelper'

class ReceiverController
    receiver: (req, res, next) ->
        buffer_helper = new BufferHelper()
        req.setEncoding 'utf8'

        req.on 'data', (chunk) ->
            buffer_helper.concat chunk

        req.on 'end', ->
            data = buffer_helper.toBuffer()

            input = new InputStream(new Buffer(data, 'base64'))
            key = input.read_utf()
            while key.length != 0
                val = input.read_utf()
                console.log key + '===' + val
                key = input.read_utf()


        res.json {'status': 'success'}

module.exports = new ReceiverController()

class InputStream
    constructor: (@buffer) ->

    read_utf: ->
        # 在Java传递的Stream中，头两个字节是下一个字段的长度
        # 之后按长度取出下一字段
        # 再两个字节是记录再之下一个字段的长度
        # 以此类推
        idx = @buffer.slice(0, 2).toString('hex')
        idx = parseInt(idx, 16)
        str = @buffer.slice(2, idx + 2).toString()
        @buffer = @buffer.slice(idx + 2, @buffer.length)
        str
class OutputStream
    constructor: (@buffer) ->

    write_utf: (str)->
        @buffer.write()