window.compliments = {} if not window.compliments?

lastData = null
isPlaying = false

window.compliments.handleFrame = (frame, width, height) ->
  data = computeAverageData frame, width, height
  if not lastData?
    lastData = data
    return
  # Compare differences between the two average data samples
  difference = 0
  for x, i in lastData
    difference += Math.abs(x - data[i])
  percentDiff = difference / data.length
  if percentDiff > 0.01
    handleChange()
  lastData = data
  return

computeAverageData = (frame, width, height) ->
  reg = Math.ceil width / 50
  # Compute the average color for each square region
  averages = []
  y = 0
  while y < height
    x = 0
    while x < width
      a = averageRegion frame, x, y, width, height, reg
      averages.push n for n in a
      x += reg
    y += reg
  return averages

averageRegion = (frame, x, y, width, height, regionSize) ->
  sampleCount = 0
  [r, g, b] = [0, 0, 0]
  for i in [0..regionSize]
    useX = x + i
    break if useX >= width
    for j in [0..regionSize]
      useY = y + j
      break if useY >= height
      r += frame[useX * 3 + useY * 3 * width]
      g += frame[useX * 3 + useY * 3 * width + 1]
      b += frame[useX * 3 + useY * 3 * width + 2]
      ++sampleCount
  sampleCount *= 256
  r /= sampleCount
  g /= sampleCount
  b /= sampleCount
  return [r, g, b]

handleChange = ->
  return if isPlaying
  isPlaying = true
  window.compliments.playCompliment ->
    isPlaying = false

