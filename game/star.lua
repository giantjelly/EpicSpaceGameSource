Star = class('Star')

function Star.new (pos, brightness)

	local instance = instance(Star)

	instance.pos = pos
	instance.brightness = brightness
	instance.r = math.random()
	instance.g = math.random()
	instance.b = math.random()

	return instance
end

function Star:render (x, y)

	video.enableTextures(false)
	video.color((self.r*0.2)+0.8, (self.g*0.2)+0.8, (self.b*0.2)+0.8, self.brightness)
	video.renderQuad(x+self.pos.x, y+self.pos.y, 1, 1)
end