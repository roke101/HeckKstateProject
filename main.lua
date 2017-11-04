-- Modified
-- Author: Max Wiens-Evangelista & Justin Miller 2017

require 'lib.Input'
require 'lib.Physics'
require 'lib.Camera'
require 'lib.Debug'

require 'level1'

function love.load()
	-- Global Variables --
	X_RESOLUTION = 256
	Y_RESOLUTION = 144
	X_SCALE = love.graphics.getWidth()/X_RESOLUTION
	Y_SCALE = love.graphics.getHeight()/Y_RESOLUTION
	TILE_SIZE = 16

	-- Graphics and Images --
	love.graphics.setDefaultFilter('nearest', 'nearest', 0)

	-- Global Tables --
	IMAGES = {}
	AUDIO = {}
	OBJECTS = {}
	LAYERS = {}
	CURRENT_LEVEL = {}

	-- Global Objects --
	INPUT = Input:new()
	PHYSICS = Physics:new(0, 0, true, true)
	CAMERA = Camera:new(X_RESOLUTION, Y_RESOLUTION, PHYSICS.worlds.meta)


	-- Loading Initial Values START --
	level1:loadLevel()
end

function love.update(dt)
	INPUT:update()
	CAMERA:update()
	if(INPUT.input.right) then
		CAMERA.body:setX(CAMERA.body:getX()-0.5,0)
	end
	if(INPUT.input.left) then
		CAMERA.body:setX(CAMERA.body:getX()+0.5,0)
	end
end

function love.draw()

	love.graphics.scale(X_SCALE, Y_SCALE)
	CAMERA:draw()

	love.graphics.print(CAMERA:getX())
end

function love.keypressed(key, isrepeat)
	INPUT:inputController(key)
end

function love.keyreleased(key, scancode)
	INPUT:inputReleaseController(key)
end