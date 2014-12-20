# BTW, this only runs on OS X incase you didn't figure that out

compliments = ["All of your ideas are brilliant",
  "You deserve a compliment",
  "Looking good",
  "You are tremendous",
  "Your smile is breath taking",
  "Hello, good looking",
  "You get an A plus",
  "You are so smart",
  "You are pretty groovy, dude",
  "Your skin is radiant",
  "You are so rad",
  "You are a bucket of awesome",
  "I like your style"]

i = 0
compliments.each { |x|
  str = "say -v vicki -o output#{i}.aiff #{x}"
  `#{str}`
  `afconvert -f 'WAVE' -d I16@44100 output#{i}.aiff output#{i}.wav`
  puts str
  i += 1
}
