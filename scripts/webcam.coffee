window.compliments = {} if not window.compliments?

window.compliments.getStream = (cb) ->
  keys = ['getUserMedia', 'webkitGetUserMedia', 'mozGetUserMedia',
    'msGetUserMedia']
  gum = null
  for key in keys
    break if (gum = navigator[key])?
  if not gum?
    setTimeout (-> cb 'Camera unavailable', null), 10
    return
  gum.call navigator, {video: true, audio: false},
    (stream) ->
      cb null, stream
    (error) ->
      if error?
        cb error, null
      else cb 'Unknown error', null
  return

window.compliments.playStream = (v, stream, cb) ->
  url = window.URL
  if url?
    v.src = url.createObjectURL stream
  else
    v.src = stream
  v.play()
  v.addEventListener 'canplay', ->
    cb? null
    cb = null
  v.addEventListener 'error', (error) ->
    if error?
      cb? error
    else
      cb? 'Unknown error'
    cb = null
  return

window.compliments.getFrames = (v, cb) ->
  canvas = document.createElement 'canvas'
  {videoWidth: width, videoHeight: height} = v
  [canvas.width, canvas.height] = [width, height]
  ctx = canvas.getContext '2d'
  intervalId = null
  func = ->
    if v.paused or v.ended
      if intervalId?
        clearInterval intervalId
        intervalId = null
      return
    context.clearRect 0, 0, width, height
    context.drawImage v, 0, 0, width, height
    cb context.getImageData(0, 0, w, h).data
  intervalId = setInterval func, 100
  return ->
    if intervalId?
      clearInterval intervalId
      intervalId = null
