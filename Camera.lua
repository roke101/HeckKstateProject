require 'OOP'
require 'physics'

Camera = {
	ox = 0,
	oy = 0,

	children = {},

	load = function(self)
		self.body = love.physics.newBody()
		self.fixture = love.physics.newFixture(self.body)
		
		self.children
		self:loadChildren()
	end,
	
	update = function(self)
		self:updateChildren()
	end,

	draw = function(self)
		self:drawChildren()
	end
}
setmetatable(Camera, prototypeMT)


Layer = {


	load = function(self)
		
		self:loadChildren()
	end,

	update = function(self)
	
		self:updateChildren()
	end,

	draw = function(self)
	
		self:drawChildren()
	end,
}
setmetatable(Layer, prototypeMT)