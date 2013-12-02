socket = io.connect 'http://localhost'

print = (msg) ->
  $('#log').append $('<p>').text(msg)

socket.on 'chat', (data) ->
  print data.msg

$('#btn_send').click ->
  msg = $('#msg_body').val()
  socket.emit 'chat', {msg: msg}
