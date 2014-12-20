window.compliments = {} if not window.compliments?

running = false
button = null
video = null
stopFunc = null
stream = null

window.compliments.startStop = ->
  getElements()
  if running
    stopFunc?()
    stopFunc = null
    button.innerHTML = 'Start'
    button.disabled = false
    running = false
  else
    button.innerHTML = 'Waiting...'
    button.disabled = true
    start (err) ->
      if err?
        button.innerHTML = 'Start'
      else
        button.innerHTML = 'Stop'
        running = true
      button.disabled = false

start = (cb) ->
  window.compliments.getStream (err, st) ->
    return cb? err if err?
    stream = st
    window.compliments.playStream video, stream, (err) ->
      return cb? err if err?
      f = window.compliments.handleFrame
      sf = window.compliments.getFrames video, f
      stopFunc = ->
        sf()
        stream.stop?()
        video.pause()
      cb null

getElements = ->
  if not button?
    button = document.getElementById 'startStop'
  if not video?
    video = document.getElementById 'video'
