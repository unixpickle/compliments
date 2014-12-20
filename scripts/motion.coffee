window.compliments = {} if not window.compliments?

lastData = null

window.compliments.handleFrame = (frame) ->
  {videoWidth: width, videoHeight: height} = document.getElementById 'video'
  data = computeAverageData frame
  if not lastData?
    lastData = data
    return
  # Compare differences between the two average data samples
  difference = 0
  for x, i in lastData
    difference += Math.abs(x - data[i])
  percentDiff = difference / data.length
  console.log 'percent difference:', percentDiff
  lastData = data
  return

computeAverageData = (frame, width, height) ->
  reg = 5
  # Compute the average color for each square region
  averages = []
  [x, y] = [0, 0]
  while y < height
    while x < width
      a = averageRegion frame, x, y, width, height, reg
      averages.push x for x in a
      x += reg
    y += reg

averageRegion = (frame, x, y, width, height, regionSize) ->
  sampleCount = 0
  [r, g, b] = [0, 0, 0]
  for i in [0..regionSize]
    break if x + i >= width
    for j in [0..regionSize]
      break if y + j >= height
      r += frame[x * 3 + y * 3 * width]
      g += frame[x * 3 + y * 3 * width + 1]
      b += frame[x * 3 + y * 3 * width + 2]
      ++sampleCount
  sampleCount *= 256
  r /= sampleCount
  g /= sampleCount
  b /= sampleCount
  return [r, g, b]
