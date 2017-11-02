-- Author: Max Wiens-Evangelista 2017
require 'OOP'

Physics = {
	worlds = {
		main = nil
	},

	children = {},

	--[[
		number xGravMain - sets the x Gravity property main physics world
		number yGravMain - sets the y Gravity property main physics world
		boolean allowForSleepMain - Whether the bodies in this world are allowed to sleep.
	]]--
	construct = function (self, xGravMain, yGravMain, allowForSleepMain, createMetaWorld)
		xGravMain = xGravMain or 0
		yGravMain = yGravMain or 0
		allowForSleepMain = allowForSleepMain or true
		createMetaWorld = createMetaWorld or true

		self.worlds.main = love.physics.newWorld(xGravMain, yGravMain, allowForSleepMain)

		if(createMetaWorld) then
			self.worlds.meta = love.physics.newWorld(0,0, true)
		end
	end,

	load = function (self)
		self:loadChildren()
	end,
	
	update = function (self)
		self:updateChildren()
	end,

	draw = function (self)
		self:drawChildren()
	end
}
setmetatable(Physics, OOP.prototypeMT)