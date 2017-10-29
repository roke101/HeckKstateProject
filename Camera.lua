require 'OOP'
Camera = {
	x = 0,
	y = 0,
	
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
setmetatable(Camera, prototypeMT)