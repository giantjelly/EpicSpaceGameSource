print(_VERSION)

collectgarbage('setstepmul', 200)
collectgarbage('setpause', 105)

app = {
	width = 1280,
	height = 720,
	scale = 1,
	fullscreen = false,
	title = 'Epic Space Game',
	limitframes = true
}

SRC = 'game/'
ASSETS = 'assets/'

dofile(SRC..'game.lua')

function keyDown (keyCode)

	key[keyCode] = true
end

function keyUp (keyCode)

	key[keyCode] = false
end

function mouseDown (button)

	if button == 0 then
		spaceship.target.x = input.mousex() - offset.x
		spaceship.target.y = input.mousey() - offset.y
	end
end

function secondstep ()

	local f = jellymoon.frames()
	local t = jellymoon.ticks()
	print('f' .. f .. ' t' .. t .. '    ' .. 'memory ' .. collectgarbage('count'))
end