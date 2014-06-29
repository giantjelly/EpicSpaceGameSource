Usf102 = inherit('Usf102', Spaceship)

function Usf102.new (x, y, side)

	local instance = instance(Usf102, x, y, side)

	instance.center = Vec2.new(21*2, 32*2)
	instance.rotationSpeedMultiplier = 0.7
	-- instance.target = Vec2.new(0, -200)

	instance.collider = Collider.new( Vec2.new(-48, -48), Vec2.new(96, 96) )

	return instance
end

function Usf102:render ()

	self:renderDangerZone()

	x = (self.pos.x+offset.x)-self.center.x
	y = (self.pos.y+offset.y)-self.center.y

	video.color(1, 1, 1, 1)
	
	video.loadIdentity()
	video.translate(x, y)
	video.rotate(self.center.x, self.center.y, self.angle)

	sprites.usf102:render(0, 0, 2)
	if self.enginesOn then sprites.usf102engine:render(0, 0, 2) end
	video.loadIdentity()

	--self.collider:render( Vec2.new(self.pos.x+offset.x, self.pos.y+offset.y) )
end