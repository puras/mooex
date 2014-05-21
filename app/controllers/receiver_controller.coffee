
class ReceiverController
    receiver: (req, resp, next) ->
        chunks = []
        size = 0
        req.setEncoding 'utf8'

        req.on 'data', (chunk) ->
            chunks.push chunk
            size += chunk.length

        req.on 'end', ->
            data = null
            switch chunks.length
                when 0 then data = new Buffer(0)
                when 1 then data = chunks[0]
                else
                    data = new Buffer(size)
                    # TODO 在这里做合并
                    # for (var i = 0, pos = 0, l = chunks.length; i < l; i++) {
                    #     var chunk = chunks[i];
                    #     chunk.copy(data, pos);
                    #     pos += chunk.length;
                    # }
            console.log '-----------------------------------------------------------'
            console.log data.toString()
            console.log '-----------------------------------------------------------'
            console.log data.toString('utf-8', 0, data.length)
            console.log '-----------------------------------------------------------'
            console.log new Buffer(data, 'base64').toString()




        resp.json {'status': 'success'}

module.exports = new ReceiverController()