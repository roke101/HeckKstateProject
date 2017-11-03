-- Author: Max Wiens-Evangelista
require 'lib.OOP'

Layer = {

	objects = {},
	parallaxX = 0,
	parallaxY = 0,
	isTiled = false,
	doesRepeatX = nil, -- boolean 
	doesRepeatY = nil, -- boolean
	groundImage = nil, -- image

	--[[layer = Layer:new(parallaxX, parallaxY, isTiled, doesRepeatX, doesRepeatY)
		number xparalax - Horazontal paralax scroll rate
		number yparalax - Virticle paralax scroll rate
		is
	]]--
	construct = function (self, parallaxX, parallaxY, , isTiled, doesRepeatX, doesRepeatY, )
		self.xparalax = xparalax or 0
		self.yparalax = yparalax or 0
		self.isTiled = isTiled or false

		if(not isTiled) then
			self.doesRepeatX = doesRepeatX or false
			self.doesRepeatY = doesRepeatY or false
		else
			self.tileMap = {}
	end,

	load = function(self)
		
	end,

	update = function(self)
		
	end,

	draw = function(self, Cx, Cy)
		
		for _,v in ipairs(self.objects) do
			v:draw(Cx*parallaxX, Cy*parallaxY)
		end
	end,
}
setmetatable(Layer, OOP.prototypeMT)