print = (msg) ->
  $('#log').append $('<p>').text(msg)

socket = io.connect 'http://localhost'

socket.on 'connect', ->
  room =
    if (shebang = location.href.match(/#([^#]+)$/))
      shebang[1]
    else
      'default'
  socket.emit 'join_to_room', room
  print "connect!!! (room:#{room})"

socket.on 'chat', (data) ->
  print data.msg

$('#btn_send').click ->
  msg = $('#msg_body').val()
  socket.emit 'chat', {msg: msg}
