Entity = class('Entity')

function Entity.new (x, y)

	local instance = instance(Entity)

	instance.pos = Vec2.new(x, y)

	return instance
end

function Entity:render ()

	video.enableTextures(false)
	video.color(0.0, 1.0, 1.0, 1)
	video.renderQuad(self.pos.x+offset.x, self.pos.y+offset.y, 64, 64)
end