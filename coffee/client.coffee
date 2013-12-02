print = (msg) ->
  $('#log').prepend $('<p>').text(msg)

socket = io.connect "#{location.protocol}//#{location.hostname}"

socket.on 'connect', ->
  room =
    if (shebang = location.href.match(/#([^#]+)$/))
      shebang[1]
    else
      'room1'
  socket.emit 'join_to_room', room
  print "connect!!! (room:#{room})"

socket.on 'chat', (data) ->
  print data.msg

send_msg = ->
  msg = $('#msg_body').val()
  socket.emit 'chat', {msg: msg}
  $('#msg_body').val('')

$('#btn_send').click send_msg
$('#msg_body').on 'keydown', (e) ->
  send_msg() if e.keyCode == 13

socket.on 'rooms', (rooms) ->
  dom = $('#rooms').html('')
  for name, num of rooms
    dom.append $('<a>')
    .attr('href', location.origin+'#'+name)
    .attr('target', '_blank')
    .text("##{name}(#{num})")
    dom.append ' '
