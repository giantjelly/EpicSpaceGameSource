Particle = inherit('Particle', Entity)

function Particle.new (pos)

	local instance = instance(Particle, pos.x, pos.y)

	instance.pos = pos
	instance.speed = Vec2.new( (math.random()*2)-1, (math.random()*2)-1 )
	instance.life = math.random(500)
	instance.color = (math.random()*0.4)-0.2
	instance.size = Vec2.new( math.random(3), math.random(3) )

	return instance
end

function Particle:render ()

	video.enableTextures(false)
	video.color(0.5+self.color, 0.5+self.color, 0.5+self.color, self.life/100)
	video.renderQuad(self.pos.x+offset.x, self.pos.y+offset.y, self.size.x, self.size.y)
end

function Particle:tick ()

	self.pos.x = self.pos.x + self.speed.x
	self.pos.y = self.pos.y + self.speed.y
	if self.life > 0 then self.life = self.life - 1 end
end