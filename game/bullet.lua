Bullet = inherit('Bullet', Entity)

function Bullet.new (x, y, direction, speed, tag)

	local instance = instance(Bullet, x, y)

	instance.direction = direction
	instance.speed = speed
	instance.dead = false
	instance.tag = tag

	instance.collider = Collider.new( Vec2.new(-2, -2), Vec2.new(4, 4) )

	return instance
end

function Bullet:render ()

	video.enableTextures(false)
	video.color(1, 1, 0, 1)
	video.renderQuad(self.pos.x+offset.x, self.pos.y+offset.y, 2, 2)

	self.collider:render( Vec2.new(self.pos.x+offset.x, self.pos.y+offset.y) )
end

function Bullet:tick ()

	self.pos:add( self.direction:multipied(self.speed) )
end