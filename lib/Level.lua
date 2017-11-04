-- Author: Max Wiens-Evangelista
require 'lib.OOP'
require 'lib.Layer'

exampleLevel = {

	objectList = {},
	layerData  = {
		[1] = {--[[parallaxX, parallaxY, imagePath, doesRepeatX, doesRepeatY ]]}, -- layer 1
		[2] = {--[[parallaxX, parallaxY, imagePath, tileMap ]]}, -- layer 2
		[4] = {--[[parallaxX, parallaxY, isTiled, doesRepeatX, doesRepeatY, ]]}  -- layer 4 (center)
	},
	
	mapCollsion = {
	--[[
		{0,0,0,0,0,0,0,0,0},
		{0,0,0,0,0,0,0,0,0},
		{0,0,0,1,1,0,0,0,0},
		{0,0,0,0,0,0,0,0,0},
		{1,1,1,1,1,1,1,1,1}
	]]--
	},

	parallaxX = 0,
	parallaxY = 0,
	isTiled = false,
	doesRepeatX = nil, -- boolean 
	doesRepeatY = nil, -- boolean
	groundImage = nil, -- image path

	load = function(self) -- load and innitalize all the objects and things in the level
		
	end
}
setmetatable(exampleLevel, levelMT)

levelMT = {
	__index = {
		loadLevel = function(self)
			-- Sets the current 
			CURRENTLEVEL = self

			LAYERS = {}
			-- creates new layers within the global layers object
			for i,v in pairs(self.layerData) do
				LAYERS[i] = Layer:new(unpack(v))
			end

			-- loads images and audio
			IMAGES = {}
			AUDIO = {}

			for k,v in pairs(self.objectList) do
				IMAGES[k] = v:getNewImages() or nil
				AUDIO[k] = v:getNewAudio() or nil
			end

			self:load()
		end

	}
}