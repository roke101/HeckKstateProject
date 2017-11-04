-- Author: Max Wiens-Evangelista
require 'lib.OOP'
require 'lib.image'
require 'lib.util'
Layer = {

	objects = {},
	tileMap = { -- only if isTiled ==true
	--[[
		{0,0,0,0,0,0,0,0,0},
		{0,0,0,0,0,0,0,0,0},
		{0,0,0,1,1,0,0,0,0},
		{0,0,0,0,0,0,0,0,0},
		{2,3,3,3,2,1,1,1,1}
	]]--
	},
	parallaxX = 0,
	parallaxY = 0,
	isTiled = false,
	doesRepeatX = nil, -- boolean 
	doesRepeatY = nil, -- boolean
	groundImage = nil, -- image/spritebatch
	groundImageQuads = nil, -- if isTiled table which holds all the quads for the tilesheet
	--[[
		layer = Layer:new(parallaxX, parallaxY, imagePath, tileMap) -- Tiled layer
		number parallaxX (0) - Horazontal paralax scroll rate
		number parallaxY (0) - Virticle paralax scroll rate
		string imagePath - path of the tileset
		table tileMap - map data showing what tiles go where

		layer = Layer:new(parallaxX, parallaxY, imagePath, doesRepeatX, doesRepeatY) -- Single image Layer
		number parallaxX - Horazontal paralax scroll rate
		number parallaxY - Virticle paralax scroll rate
		string imagePath - path of the tileset
		boolean doesRepeatX (false) - if the image repeats horazontally
		boolean doesRepeatY (false) - if the image repeats virtically
	]]--
	construct = function (self, parallaxX, parallaxY, imagePath, ...)
		self.parallaxX = parallaxX or 0
		self.parallaxY = parallaxY or 0
		self.isTiled = false
		local arg = {...}

		if(type(arg[1]) == 'table') then
			local tileSheet = love.graphics.newImage(imagePath)
			self.groundImageQuads = image.generateTileQuads(tileSheet)
			self.groundImage = love.graphics.newSpriteBatch(tileSheet)
			self.tileMap = arg[1]
			self.isTiled = true
		else
			self.groundImage = love.graphics.newImage(imagePath)
			self.doesRepeatX = arg[1] or false
			self.doesRepeatY = arg[2] or false
			self.isTiled = false
		end
	end,

	load = function(self)
		
	end,

	update = function(self, Cx, Cy)
		-- updates spritebatch
		if(self.isTiled) then
			self.groundImage:clear()
			for rowIndex, row in ipairs(self.tileMap) do
				for collumnIndex, tileIndicator in ipairs(row) do
					if tileIndicator ~= 0 then
						self.groundImage:add(self.groundImageQuads[tileIndicator], (collumnIndex-1)*TILE_SIZE, (rowIndex-1)*TILE_SIZE)
					end
				end
			end
			self.groundImage:flush()
		end
	end,

	draw = function(self, Cx, Cy)

		
		if(not self.isTiled and (self.doesRepeatX or self.doesRepeatY)) then
			if(self.doesRepeatX and self.doesRepeatY) then
				local width = self.groundImage:getWidth()
				local height = self.groundImage:getHeight()
				local x = util.round((Cx*self.parallaxX)%width)
				local y = util.round((Cy*self.parallaxY)%height)
				love.graphics.draw(self.groundImage, x-(width*2), y-(height*2))
				love.graphics.draw(self.groundImage, x-width, y-height)
				love.graphics.draw(self.groundImage, x, y)
			elseif(self.doesRepeatX) then
				local width = self.groundImage:getWidth()
				local x = util.round((Cx*self.parallaxX)%width)
				local y = util.round(Cy*self.parallaxY)
				love.graphics.draw(self.groundImage, x-(width*2), y)
				love.graphics.draw(self.groundImage, x-width, y)
				love.graphics.draw(self.groundImage, x, y)
			else
				local height = self.groundImage:getHeight()
				local x = util.round(Cx*self.parallaxX)
				local y = util.round((Cy*self.parallaxY)%height)
				love.graphics.draw(self.groundImage, x, y-(height*2))
				love.graphics.draw(self.groundImage, x, y-height)
				love.graphics.draw(self.groundImage, x, y)
			end
		else
			love.graphics.draw(self.groundImage, util.round(Cx*self.parallaxX), util.round(Cy*self.parallaxY))
		end

		for _,v in ipairs(self.objects) do
			v:draw(Cx*self.parallaxX, Cy*self.parallaxY)
		end
	end,
}
setmetatable(Layer, OOP.prototypeMT)