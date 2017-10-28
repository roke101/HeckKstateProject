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

		self.loadChildren(self)
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
	end
}
setmetatable(Rock, prototypeMT)

