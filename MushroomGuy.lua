require 'OOP'
require 'physics'

MushroomGuy = {
	x = 0,
	y = 0,
	
	r = 0,
	
	sx = 1,
	sy = 1,
	
	ox = 0,
	oy = 0,

	--Constructing Variables
	image = nil,
	world = nil,
	
	children = {},

	construct = function (self, world, imageDir)
		imageDir = imageDir or 'content/objects/MushroomGuy.png'
		self.world = world
		self.image = love.graphics.newImage('content/objects/MushroomGuy.png')

	end,

	load = function(self)
		--self.body = love.physics.newBody()

		self:loadChildren()
	end,
	
	update = function(self)
		self:updateChildren()
	end,

	draw = function(self)
		love.graphics.draw(self.image, self:getX(), self:getY(), self.r, self.sx, self.sy, self.ox, self.oy)
		self:drawChildren()
	end,
	
	getX = function (self)
		return self.body:getX()
	end,

	getY = function (self)
		return self.body:getY()
	end,

	setX = function (self, num)
		
	end,

	setY = function (self, num)
		
	end,
}
setmetatable(MushroomGuy, OOP.prototypeMT)

