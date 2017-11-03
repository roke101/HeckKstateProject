-- Author: Max Wiens-Evangelista 2017
require 'lib.OOP'
require 'lib.physics'

Camera = {
	
	layers = nil,
	body = nil,
	shape = nil,
	fixture = nil,

	--[[camera = Camera:new(xResolution, yResolution, metaWorld, layers, x, y)
		number xResolution - Horazontal resolution of the Camera
		number yResolution - Virticle resolution of the Camera
		World metaWorld - the meta world which the physics of the camera will be handdled
		table layers - table which holds each layer object in the game 
		number x (0) - sets the innitial x position of the Camera
		number y (0) - sets the innitial y position of the Camera	
	]]--
	construct = function (self, xResolution, yResolution, metaWorld, layers, x, y)
		local x = x or 0
		local y = y or 0
		self.layers = layers

		self.body = love.physics.newBody(metaWorld, x, y, 'dynamic')
	end,

	load = function(self)
		
	end,
	
	update = function(self)

	end,

	draw = function(self)
		for _,layer in ipairs(self.layers) do
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