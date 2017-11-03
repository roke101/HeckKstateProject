-- Author: Max Wiens-Evangelista & Justin Miller 2017

require 'lib.Input'
require 'lib.Physics'
require 'lib.Camera'

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
	objects = {}
	layers = {}

	-- Global Objects --
	input = Input:new()
	physics = Physics:new(0, 0, true, true)
	camera = Camera:new(X_RESOLUTION, Y_RESOLUTION, physics.worlds.meta, layers)
end

function love.update(dt)
	input:update()
end

function love.draw()
	love.graphics.scale(X_SCALE, Y_SCALE)
	camera:draw()
end

function love.keypressed(key, isrepeat)
	input:inputController(key)
end

function love.keyreleased(key, scancode)
	input:inputReleaseController(key)
end