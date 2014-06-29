Collider = class('Collider')

function Collider.new (pos, size)

	local instance = instance(Collider)

	instance.pos = pos
	instance.size = size

	return instance
end

function Collider:collision (pos, otherCollider, otherPos)

	-- IF COLLSION RETURN TRUE
	if otherPos.x + otherCollider.pos.x < pos.x + self.pos.x + self.size.x and
		otherPos.x + otherCollider.pos.x + otherCollider.size.x > pos.x + self.pos.x and
		otherPos.y + otherCollider.pos.y < pos.y + self.pos.y + self.size.y and
		otherPos.y + otherCollider.pos.y + otherCollider.size.y > pos.y + self.pos.y then
		return true
	else
		return false
	end
end

function Collider:render (pos)

	video.enableTextures(false)
	video.color(0.2, 1, 0.5, 0.4)
	video.renderQuad(pos.x + self.pos.x, pos.y + self.pos.y, self.size.x, self.size.y)
end