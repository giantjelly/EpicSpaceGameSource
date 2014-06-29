Usf119 = inherit('Usf119', Spaceship)

function Usf119.new (x, y, side)

	local instance = instance(Usf119, x, y, side)

	instance.center = Vec2.new(12*2, 24*2)
	instance.collider = Collider.new( Vec2.new(-32, -32), Vec2.new(64, 64) )
	instance.maxLife = 200
	instance.life = instance.maxLife
	instance.maxShield = 500
	instance.shield = instance.maxShield

	return instance
end

function Usf119:render ()

	self:renderDangerZone()

	-- video.enableTextures(false)
	-- video.color(80/255, 200/255, 1, 0.5)
	-- video.renderCircle(self.pos.x+offset.x, self.pos.y+offset.y, 50, 1)

	x = (self.pos.x+offset.x)-self.center.x
	y = (self.pos.y+offset.y)-self.center.y

	video.color(1, 1, 1, 1)
	
	video.loadIdentity()
	video.translate(x, y)
	video.rotate(self.center.x, self.center.y, self.angle)

	-- video.renderSprite(usf119, 0, 0, 64, 64, 0, 0, 2)
	sprites.usf119:render(0, 0, 2)
	if self.enginesOn then sprites.usf119engine:render(0, 0, 2) end

	if self.shield > 0 then
		local shieldAlpha = (0.3*(self.shield/self.maxShield))
		video.enableTextures(false)
		video.color(0.0, 0.7, 1.0, 0.1 + shieldAlpha)
		video.renderElipse(self.center.x, self.center.y, 30, 50, 1)
	end

	video.loadIdentity()

	--self.collider:render( Vec2.new(self.pos.x+offset.x, self.pos.y+offset.y) )
end