dofile('game/lib/sys.lua')
dofile('game/lib/class.lua')
dofile('game/lib/epic.lua')

dofile(SRC..'enums.lua')
dofile(SRC..'vec2.lua')
dofile(SRC..'sprite.lua')
dofile(SRC..'collider.lua')
dofile(SRC..'entity.lua')
dofile(SRC..'spaceship.lua')
dofile(SRC..'usf119.lua')
dofile(SRC..'usf102.lua')
dofile(SRC..'orders.lua')
dofile(SRC..'bullet.lua')
dofile(SRC..'particle.lua')
dofile(SRC..'background.lua')

math.randomseed(os.time())

textures = {
	usf119 = video.loadTexture(ASSETS..'usf119.png'),
	usf119engine = video.loadTexture(ASSETS..'usf119engine.png'),
	usf102 = video.loadTexture(ASSETS..'usf102.png'),
	usf102engine = video.loadTexture(ASSETS..'usf102engine.png'),
}

sprites = {
	usf119 = Sprite.new(textures.usf119, 0, 0, 64, 64),
	usf119engine = Sprite.new(textures.usf119engine, 0, 0, 64, 64),

	usf102 = Sprite.new(textures.usf102, 0, 0, 64, 64),
	usf102engine = Sprite.new(textures.usf102engine, 0, 0, 64, 64),
}

offset = Vec2.new(0, 0)
entity = Entity.new(-200, -200)

background = Background.new()
spaceship = Usf119.new(0, 0, PLAYER)
bullets = {}
bulletCount = 0
particles = {}
particleCount = 0

spaceships = {
	Usf102.new(200, 0, ENEMY),
	Usf102.new(-200, 0, ENEMY)
}

spaceships[1].orders = Orders.new({
	Vec2.new(-1000, -400),
	Vec2.new(1000, 400)
})

spaceships[2].orders = Orders.new({
	Vec2.new(-1000, -400),
	Vec2.new(1000, 400)
})

function render () 

	video.clear()

	background:render()

	--video.enableTextures(false)
	--video.color(0.0, 1.0, 1.0, 1)
	--video.renderQuad(10, 10, 100, 100)

	video.enableTextures(false)
	video.color(0.0, 1.0, 1.0, 1)
	video.renderQuad(spaceship.target.x+offset.x, spaceship.target.y+offset.y, 2, 2)

	--video.color(1, 1, 1, 1)
	--video.renderSprite(usf102, 200+offset.x, 0+offset.y, 128, 128)

	entity:render()
	Entity.new(-1000-32, -400-32):render()
	Entity.new(1000-32, 400-32):render()

	if not spaceship.dead then spaceship:render() end
	
	for i, ship in ipairs(spaceships) do
		ship:render()
	end
	for i, bullet in ipairs(bullets) do
		bullet:render()
	end
	for i, particle in ipairs(particles) do
		particle:render()
	end

	-- video.enableTextures(false)
	-- video.color(0.0, 1.0, 1.0, 1)
	-- video.renderQuad(spaceship.x+xOriginOffset+spaceship.xCenter, spaceship.y+yOriginOffset+spaceship.yCenter, 2, 2)

	-- Life and shield bars
	video.enableTextures(false)

	video.color(1.0, 0, 0, 1.0)
	if spaceship.life >= spaceship.maxLife/4 then video.color(1.0, 0.7, 0.0, 1.0) end
	if spaceship.life >= spaceship.maxLife/2 then video.color(0.0, 1.0, 0.3, 1.0) end

	for i = 1, (spaceship.life/spaceship.maxLife)*100 do
		video.renderQuad(10+(i*3), 10, 1, 16)
	end

	video.color(1.0, 0, 0, 1.0)
	if spaceship.shield >= spaceship.maxShield/4 then video.color(1.0, 0.7, 0.0, 1.0) end
	if spaceship.shield >= spaceship.maxShield/2 then video.color(0.0, 0.7, 1.0, 1.0) end

	for i = 1, (spaceship.shield/spaceship.maxShield)*100 do
		video.renderQuad(10+(i*3), 36, 1, 16)
	end
end

function tick ()

	-- frames = frames + 1
	-- if(sys.time() - time > 1000) then
	-- 	print(frames, 'bullets '..bulletCount)
	-- 	--printClass(bullets)
	-- 	time = sys.time()
	-- 	frames = 0
	-- 	collectgarbage()
	-- end

	offset.x = -( (spaceship.pos.x+spaceship.center.x)-(app.width/2) )
	offset.y = -( (spaceship.pos.y+spaceship.center.y)-(app.height/2) )

	if not spaceship.dead then spaceship:tick() end
	if not spaceship.dead and spaceship.life <= 0 then
		for i = 1, 100 do
			table.insert(particles, Particle.new(Vec2.new(spaceship.pos.x, spaceship.pos.y)));
		end
		spaceship.dead = true
	end
	
	for i, ship in ipairs(spaceships) do
		ship:tick()
		if ship.life <= 0 then
			for i = 1, 100 do
				table.insert(particles, Particle.new(Vec2.new(ship.pos.x, ship.pos.y)));
			end
			table.remove(spaceships, i)
		end
	end

	bulletCount = 0
	for i, bullet in ipairs(bullets) do
		bullet:tick()
		bulletCount = bulletCount + 1
		if bullet.dead then table.remove(bullets, i) end
	end

	particleCount = 0
	for i, particle in ipairs(particles) do
		particle:tick()
		particleCount = particleCount + 1
	end
end