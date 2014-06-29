Sprite = class('Sprite')

function Sprite.new (texture, x, y, width, height)

	local instance = instance(Sprite)

	instance.texture = texture
	instance.offset = Vec2.new(x, y)
	instance.size = Vec2.new(width, height)

	return instance
end

function Sprite:render (x, y, scale)

	video.renderSprite(self.texture, self.offset.x, self.offset.y, self.size.x, self.size.y, x, y, scale)
end