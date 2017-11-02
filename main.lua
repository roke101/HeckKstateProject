require 'Debug'
require 'Rock'
require 'Input'

require 'MushroomGuy'

function love.load()
	input = Input:new({}, {})
	--physics = Physics:new()

	goomba1 = MushroomGuy:new()
	goomba2 = MushroomGuy:new({imageDir = 'otherimage.png'})
	
	print('goomba1')
	Debug.deepPrint(goomba1)
	print('\ngoomba2')
	Debug.deepPrint(goomba2)
end

function love.update(dt)
	input:update()
end

function love.draw()
	love.graphics.print('doubleTapInput: '..tostring(input.input.doubleTapInput))
	love.graphics.print('up: '..tostring(input.input.up), 0, 16)
	love.graphics.print('down: '..tostring(input.input.down), 0, 32)
	love.graphics.print('left: '..tostring(input.input.left), 0, 48)
	love.graphics.print('right: '..tostring(input.input.right), 0, 64)
	love.graphics.print('activate: '..tostring(input.input.activate), 0, 80)
	love.graphics.print('last Input: '..tostring(input.lastInput), 0, 96)
end

function love.keypressed(key, isrepeat)
	input:inputController(key)
end

function love.keyreleased(key, scancode)
	input:inputReleaseController(key)
end