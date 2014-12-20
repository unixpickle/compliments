window.compliments = {} if not compliments?

window.compliments.playCompliment = (endCb) ->
  a = new Audio 'test.wav'
  a.play()
  setTimeout endCb, 2000

