window.compliments = {} if not compliments?

files = ("audio/output#{x}.wav" for x in [0..12])
idx = 0

window.compliments.playCompliment = (endCb) ->
  idx = 0 if idx is files.length
  a = new Audio files[idx++]
  a.play()
  setTimeout endCb, 3000

