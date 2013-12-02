// Generated by CoffeeScript 1.6.3
var print, socket;

print = function(msg) {
  return $('#log').append($('<p>').text(msg));
};

socket = io.connect("" + location.protocol + "//" + location.hostname);

socket.on('connect', function() {
  var room, shebang;
  room = (shebang = location.href.match(/#([^#]+)$/)) ? shebang[1] : 'room1';
  socket.emit('join_to_room', room);
  return print("connect!!! (room:" + room + ")");
});

socket.on('chat', function(data) {
  return print(data.msg);
});

$('#btn_send').click(function() {
  var msg;
  msg = $('#msg_body').val();
  return socket.emit('chat', {
    msg: msg
  });
});

socket.on('rooms', function(rooms) {
  var dom, name, num, _results;
  dom = $('#rooms').html('');
  _results = [];
  for (name in rooms) {
    num = rooms[name];
    dom.append($('<a>').attr('href', location.origin + '#' + name).attr('target', '_blank').text("#" + name + "(" + num + ")"));
    _results.push(dom.append(' '));
  }
  return _results;
});
