require 'OOP'

Moss = {
	x = 0,
	y = 0,
	
	r = 0,
	
	sx = 1,
	sy = 1,
	
	ox = 0,
	oy = 0,

	children = {},

	load = function(self)

		self:loadChildren()
	end,
	
	update = function(self)
		self:updateChildren()
	end,

	draw = function(self)
		self:drawChildren()
	end
}
setmetatable(Moss, prototypeMT)

Rock = {
	x = 0,
	y = 0,
	
	r = 0,
	
	sx = 1,
	sy = 1,
	
	ox = 0,
	oy = 0,

	children = {},

	load = function(self)
		self:loadChildren()
	end,
	
	update = function(self)
		self:updateChildren()
	end,

	draw = function(self)
		self:drawChildren()
	end,

	getX = function (self)
		if self.body ~= nil then
			return self.body.getX()
		elseif self.x ~= nil then
			return self.x
		else
			return 0
		end
	end,

	getY = function (self)
		if self.y ~= nil then
			return self.y
		elseif self.body ~= nil then
			return self.body.getY()
		else
			return 0
		end
	end,

	setX = function (self)
		if self.body ~= nil then
			return self.body.getX()
		elseif self.x ~= nil then
			return self.x
		else
			return 0
		end
	end,

	setY = function (self)
		if self.y ~= nil then
			return self.y
		elseif self.body ~= nil then
			return self.body.getY()
		else
			return 0
		end
	end,
}
setmetatable(Rock, OOP.prototypeMT)

