Vec2 = class('Vec2')

function Vec2.new (x, y)

	local instance = instance(Vec2)

	instance.x = x
	instance.y = y

	return instance
end

function Vec2:len ()

	return math.sqrt(self.x^2 + self.y^2)
end

function Vec2:distance (vec)

	return math.sqrt( (vec.x-self.x)^2 + (vec.y-self.y)^2 )
end

function Vec2:print ()

	print( 'x : '..self.x, 'y : '..self.y )
end

function Vec2:add (vec)

	self.x = self.x + vec.x
	self.y = self.y + vec.y
end

-- RETURNS NEW VECTOR

function Vec2:difference (vec)

	return Vec2.new(vec.x-self.x, vec.y-self.y)
end

function Vec2:normal ()

	return Vec2.new(self.x/self:len(), self.y/self:len())
end

function Vec2:multipied (mult)

	return Vec2.new(self.x*mult, self.y*mult)
end