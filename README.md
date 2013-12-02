Socket.IO chat study
====================

- https://github.com/shokai/socketio-chat-study
- [demo](http://socketio-chat-study.herokuapp.com)

## Install Dependencies

    % npm install

## Run

    % coffee server.coffee 3000

=> http://localhost:3000


## Deploy on Heroku

    % heroku create
    % heroku labs:enable websockets
    % git push heroku master
    % heroku open
