http = require 'http'
fs   = require 'fs'
url  = require 'url'

app_handler = (req, res) ->
  _url = url.parse(decodeURI(req.url), true);
  path = if _url.pathname == '/' then '/index.html' else _url.pathname
  console.log "request: #{path}"
  fs.readFile __dirname+path, (err, data) ->
    if err
      res.writeHead 500
      return res.end 'error load file'
    res.writeHead 200
    res.end data

app = http.createServer(app_handler)
io = require('socket.io').listen(app)

io.sockets.on 'connection', (sock) ->
  sock.emit 'chat', {msg: 'hello new client!'}
  sock.on 'chat', (data)->
    console.log data.msg
    io.sockets.emit 'chat', data # echo

port = process.argv[2]-0 || 3000
app.listen port
console.log "server start - port:#{port}"
