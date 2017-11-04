-- Author: Max Wiens-Evangelista 2017
require 'lib.OOP'
require 'lib.physics'

Camera = {
	body = nil,
	shape = nil,
	fixture = nil,

	--[[camera = Camera:new(xResolution, yResolution, metaWorld, x, y)
		number xResolution - Horazontal resolution of the Camera
		number yResolution - Virticle resolution of the Camera
		World metaWorld - the meta world which the physics of the camera will be handdled
		tabl - table which holds each layer object in the game 
		number x (0) - sets the innitial x position of the Camera
		number y (0) - sets the innitial y position of the Camera	
	]]--
	construct = function (self, xResolution, yResolution, metaWorld, x, y)
		local x = x or 0
		local y = y or 0

		self.body = love.physics.newBody(metaWorld, x, y, 'dynamic')
	end,

	load = function(self)
		
	end,
	
	update = function(self)
		for _,layer in pairs(LAYERS) do
			layer:update(self:getX(), self:getY())
		end
	end,

	draw = function(self)
		for _,layer in pairs(LAYERS) do
			layer:draw(self:getX(), self:getY())
		end
	end,

	getX = function (self)
		return self.body:getX()
	end,

	getY = function (self)
		return self.body:getY()
	end
}
setmetatable(Camera, OOP.prototypeMT)