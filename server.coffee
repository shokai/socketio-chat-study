http = require 'http'
fs   = require 'fs'
url  = require 'url'

app_handler = (req, res) ->
  _url = url.parse(decodeURI(req.url), true);
  path = if _url.pathname == '/' then '/index.html' else _url.pathname
  console.log "#{req.method} - #{path}"
  fs.readFile __dirname+path, (err, data) ->
    if err
      res.writeHead 500
      return res.end 'error load file'
    res.writeHead 200
    res.end data

app = http.createServer(app_handler)
io = require('socket.io').listen(app)

io.sockets.on 'connection', (socket) ->
  socket.emit 'chat', {msg: 'hello new client!'}

  socket.once 'join_to_room', (room) ->
    console.log "<#{socket.id}> join_room to \"#{room}\""
    socket.join room

    ## echo to room
    socket.on 'chat', (data) ->
      console.log data.msg
      io.sockets.to(room).emit 'chat', data

    socket.once 'disconnect', ->
      socket.leave room
      notify_rooms()

    notify_rooms()


notify_rooms = ->
  rooms = {}
  for name, ids of io.sockets.manager.rooms
    if name.match /^\/.+$/
      name = name.replace /^\//, ''
      rooms[name] = ids.length
  console.log rooms
  io.sockets.emit 'rooms', rooms

port = process.argv[2]-0 || 3000
app.listen port
console.log "server start - port:#{port}"
