dofile(SRC..'star.lua')

Background = class('Background')

function Background.new ()

	local instance = instance(Background)

	instance.stars = {}

	for i = 1, 9000 do

		table.insert(instance.stars,
			Star.new( Vec2.new( math.random(app.width*3)-app.width, math.random(app.height*3)-app.height ), math.random() )
		)
	end

	return instance
end

function Background:render ()
	
	local x = spaceship.pos.x/10
	local y = spaceship.pos.y/10

	for i, star in ipairs(self.stars) do

		star:render(-x, -y)
	end
end