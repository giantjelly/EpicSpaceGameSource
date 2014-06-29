Spaceship = inherit('Spaceship', Entity)

function Spaceship.new (x, y, side)

	local instance = instance(Spaceship, x, y)

	instance.center = Vec2.new(0, 0)
	instance.target = Vec2.new(x, y)
	instance.angle = 0
	instance.enginesOn = false
	instance.speed = 0.0
	instance.rotationSpeed = 0.0
	instance.speedMultiplier = 1
	instance.rotationSpeedMultiplier = 1
	
	instance.reloadTimer = 0
	instance.side = side
	instance.dangerZoneSize = 300

	instance.maxLife = 100
	instance.maxShield = 100
	instance.life = instance.maxLife
	instance.shield = instance.maxShield

	instance.dead = false

	return instance
end

function Spaceship:render ()
end

function Spaceship:tick ()

	self.enginesOn = false
	if self.reloadTimer > 0 then self.reloadTimer = self.reloadTimer - 1 end

	xDiff = self.target.x - (self.pos.x)
	yDiff = self.target.y - (self.pos.y)
	xDist = xDiff
	yDist = yDiff
	maxdist = 100
	dist = math.sqrt( (xDist*xDist) + (yDist*yDist) )
	angle = math.deg(math.atan2( -xDiff, yDiff )) + 180

	if dist > maxdist then
		a = 0
		if self.angle < angle then a = 1 end
		if self.angle > angle then a = -1 end
		if self.angle+180 < angle then a = -1 end
		if self.angle-180 > angle then a = 1 end
		--print(self.angle, angle)
		self.angle = self.angle + (a*(self.rotationSpeed*self.rotationSpeedMultiplier))

		if self.angle < angle + 2 and self.angle > angle - 2 then self.angle = angle end

		if self.angle >= 360 then self.angle = self.angle - 360 end
		if self.angle < 0 then self.angle = self.angle + 360 end

		self:engines()
	end

	-- if key[keyCode.left] then  self.angle = self.angle - 1 end
	-- if key[keyCode.right] then  self.angle = self.angle + 1 end
	-- if key[keyCode.up] then
	-- 		self:move()
	-- end

	-- Speed and movement
	if not self.enginesOn and self.speed > 0 then self.speed = self.speed - 0.05 end
	if not self.enginesOn and self.rotationSpeed > 0 then self.rotationSpeed = self.rotationSpeed - (0.02*self.rotationSpeedMultiplier) end
	if self.speed > 0 then self:move() end

	-- Follow orders
	if self.orders then
		if self.pos:distance(self.target) < 100 then
			self.orders.commandIndex = self.orders.commandIndex + 1
			if self.orders.commandIndex > self.orders.noOfCommands then self.orders.commandIndex = 1 end
			self.target = self.orders.commands[self.orders.commandIndex]
		end
		--self.target = self.orders.commands[1]
	end

	-- Player shoot enemies
	if not self.orders then
		
		for i, ship in ipairs(spaceships) do
			if self.side ~= ship.side and self.pos:distance(ship.pos) < 400 then
				if self.reloadTimer == 0 then self:shoot(ship.pos) end
			end
		end
	else
		if self.side ~= spaceship.side and self.pos:distance(spaceship.pos) < 400 then
			if self.reloadTimer == 0 then self:shoot(spaceship.pos) end
		end
	end

	if self.shield < self.maxShield then self.shield = self.shield + 0.1 end

	-- Bullet collisions
	for i, bullet in ipairs(bullets) do
		if bullet.tag ~= self.side and self.collider:collision(self.pos, bullet.collider, bullet.pos) then
			bullet.dead = true
			if self.shield <= 0 then self.life = self.life - 10
			else self.shield = self.shield - 10 end
			--if self.life <= 0 then self.dead = true end
		end
	end
end

function Spaceship:move ()

	self.pos.x = self.pos.x - (math.sin(math.rad(self.angle+180)) * (self.speed*self.speedMultiplier))
	self.pos.y = self.pos.y + (math.cos(math.rad(self.angle+180)) * (self.speed*self.speedMultiplier))
end

function Spaceship:engines ()

	self.enginesOn = true
	if self.speed < 3 then self.speed = self.speed + 0.05 end
	if self.rotationSpeed < 1 then self.rotationSpeed = self.rotationSpeed + (0.02*self.rotationSpeedMultiplier) end
end

function Spaceship:shoot (otherShipPosition)

	self.reloadTimer = 20
	local normal = self.pos:difference(otherShipPosition):normal()
	normal.x = normal.x + (math.random()*0.2 - 0.1)
	normal.y = normal.y + (math.random()*0.2 - 0.1)
	table.insert(bullets, Bullet.new( self.pos.x, self.pos.y, normal, 15, self.side ))
end

function Spaceship:renderDangerZone ()

	if self.side==ENEMY then
		video.enableTextures(false)
		video.color(1, 0, 0, 0.1)
		video.renderCircle(self.pos.x+offset.x, self.pos.y+offset.y, self.dangerZoneSize, 1)
	end
end