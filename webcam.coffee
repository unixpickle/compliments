window.addEventListener 'DOMContentLoaded', ->
	navigator.webkitGetUserMedia {video: true, audio: false},
		(stream) ->
			url = window.URL
			v = document.getElementById 'video'
			v.src = if url? then url.createObjectURL(stream) else stream
			v.play()
			v.addEventListener 'canplay', ->
				canvas = document.createElement 'canvas'
				{videoWidth: w, videoHeight: h} = v
				console.log 'width', w, 'height', h
				canvas.width = w
				canvas.height = h
				context = canvas.getContext '2d'
				lastData = null
				func = ->
					return if v.paused or v.ended
					context.clearRect 0, 0, w, h
					context.drawImage v, 0, 0, w, h
					difference = 0
					{data} = context.getImageData 0, 0, w, h
					if lastData?
						for num, i in data
							difference += Math.abs(num - lastData[i]) / 256
					lastData = data
					percent = difference / data.length
					if percent > 0.07
						motionDetected()
					return
				setInterval func, 33
		(error) ->
			alert 'K, there was an error' + error

lastMotion = null

motionDetected = ->
	if not lastMotion?
		lastMotion = new Date()
		playCompliment()
	else
		now = new Date()
		if Math.abs(lastMotion.getTime() - now.getTime()) > 2000
			playCompliment()
			lastMotion = now

playCompliment = ->
	audio = new Audio 'test.wav'
	audio.play()

