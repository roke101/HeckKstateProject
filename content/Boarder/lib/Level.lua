-- Author: Max Wiens-Evangelista
require 'lib.OOP'
require 'lib.Layer'
require 'lib.Boundry'
require 'lib.Debug'

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

			local boundaries = self:loadBoundaries()
			Debug.deepPrint(boundaries)
			--for k,v in pairs(boundaries) do
				--table.insert(
				--	LAYERS[4].objects,
				-- boundaries[k])  
			for i=1, table.getn(boundries) do
				table.insert(LAYERS[4].objects, boundries[i])
			end
				

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
		end,

		loadBoundaries = {}

		loadBoundaries = function(self)
			function IntTableToShapeTable()
			returnShapeTable = {}

				--first initialize the isDrawn to to mirror self.mapCollsion size, and all elements = false
				for i=1, table.getn(self.mapCollsion) do
					isDrawn[i] = {}
					for j=1, table.getn(self.mapCollsion[i]) do
						isDrawn[i][j] = false
					end
				end

				--now construct the outer boarder
				width = (table.getn(self.mapCollsion[1]) + 1) * TILE_SIZE
				height = (table.getn(self.mapCollsion) + 1) * TILE_SIZE
				outerShape = love.physics.newChainShape(true, 0, 0, 0, height, width, height, width, 0)

				table.insert(returnShapeTable, outerShape)

				--now we need to add all the inside boundries that are on the inside into the array
				--this will be done row by row using a function to draw a single one
				for i=table.getn(self.mapCollsion), 1, -1 do
					for j=table.getn(self.mapCollsion[1]), 1, -1 do
						
						if (self.mapCollsion[i][j]) == 1 and (isDrawn[i][j] == false) then
							table.insert(returnShapeTable, drawSingle(i, j))
						elseif (self.mapCollsion[i][j] > 1) and (isDrawn[i][j] == false) then
							table.insert(returnShapeTable, drawSpecialCase(self.mapCollsion[i][j], i, j))
						end

					end
				end

				return returnShapeTable
			end

			function drawSingle(row, col)
				width = 0

				rowScaled = row * TILE_SIZE
				colScaled = col * TILE_SIZE

				for i=col, table.getn(self.mapCollsion[row]) do
					if(self.mapCollsion[row][i] ~= 1) then
						break
					end

					width = width + 1
					isDrawn[row][i] = true
				end

				width = width * TILE_SIZE
				
				--										|		1st point   ||		2nd point		      ||			3rd point				||			4th point		 |
				return love.physics.newChainShape(true, colScaled, rowScaled, colScaled, rowScaled + TILE_SIZE, colScaled + width, rowScaled + TILE_SIZE, colScaled + width, rowScaled)
			end

			function drawSpecialCase(piece, row, col)
				rowScaled = row * TILE_SIZE
				colScaled = col * TILE_SIZE

				if piece == 2 then
					isDrawn[row][col] = true
					--										|	 1st point      ||			2nd point  		  ||				3rd point  	        |
					return love.physics.newChainShape(true, colScaled, rowScaled, colScaled, rowScaled + TILE_SIZE, colScaled + TILE_SIZE, rowScaled + TILE_SIZE)
				elseif piece == 3 then
					isDrawn[row][col] = true
					--										|			1st point      ||			2nd point  				 ||				3rd point  	   |
					return love.physics.newChainShape(true, colScaled, rowScaled + TILE_SIZE, colScaled + TILE_SIZE, rowScaled + TILE_SIZE, colScaled + TILE_SIZE, rowScaled)
				
				elseif piece == 4 then
					if self.mapCollsion[row][col + 1] == 5 then
						isDrawn[row][col] = true
						isDrawn[row][col + 1] = true
						--										|	 1st point     ||			2nd point  		 ||				3rd point  	     		  	  |
						return love.physics.newChainShape(true, colScaled, rowScaled, colScaled, rowScaled + TILE_SIZE, colScaled + (TILE_SIZE * 2), rowScaled + TILE_SIZE)
					else
						isDrawn[row][col] = true
						--										|	 1st point     ||			2nd point  		 ||				3rd point  	     		||					4th point 				|
						return love.physics.newChainShape(true, colScaled, rowScaled, colScaled, rowScaled + TILE_SIZE, colScaled + TILE_SIZE, rowScaled + TILE_SIZE,  colScaled + TILE_SIZE,  rowScaled + (TILE_SIZE / 2))
					end
				elseif piece == 5 then
					isDrawn[row][col] = true
					--										|	 1st point     				 ||			2nd point  		   ||				3rd point  	     	  |
					return love.physics.newChainShape(true, colScaled, rowScaled + (TILE_SIZE / 2), colScaled, rowScaled + TILE_SIZE, colScaled + TILE_SIZE, rowScaled + TILE_SIZE)

				elseif piece == 7 then
					if self.mapCollsion[row][col + 1] == 6 then
						isDrawn[row][col] = true
						isDrawn[row][col + 1] = true
						--										|	 	1st point  		   ||			2nd point  		 			   ||				3rd point  	     	|
						return love.physics.newChainShape(true, colScaled, rowScaled + TILE_SIZE, colScaled + (TILE_SIZE * 2), rowScaled + TILE_SIZE, colScaled + (TILE_SIZE * 2), rowScaled)
					else
						isDrawn[row][col] = true
						--										|	 	1st point          ||			2nd point  		 		 ||				3rd point  	     			  |
						return love.physics.newChainShape(true, colScaled, rowScaled + TILE_SIZE, colScaled + TILE_SIZE, rowScaled + TILE_SIZE, colScaled + TILE_SIZE, rowScaled + (TILE_SIZE / 2))
					end
				elseif piece == 6 then
					isDrawn[row][col] = true
					--										|	   1st point   				 ||			2nd point  		   ||				3rd point  	     	 ||				4th point 				   |
					return love.physics.newChainShape(true, colScaled, rowScaled + (TILE_SIZE / 2), colScaled, rowScaled + TILE_SIZE, colScaled + TILE_SIZE, rowScaled + TILE_SIZE, colScaled + TILE_SIZE, rowScaled)
				
				elseif piece == 8 then
					isDrawn[row][col] = true
					--										|	 1st point      ||			2nd point  		  ||				3rd point  	        |
					return love.physics.newChainShape(true, colScaled, rowScaled, colScaled + TILE_SIZE, rowScaled, colScaled + TILE_SIZE, rowScaled + TILE_SIZE)
				elseif piece == 9 then
					isDrawn[row][col] = true
					--										|	 1st point      ||			2nd point  		  ||	 3rd point  	        |
					return love.physics.newChainShape(true, colScaled, rowScaled, colScaled + TILE_SIZE, rowScaled, colScaled, rowScaled + TILE_SIZE)
				
				elseif piece == 11 then
					if self.mapCollsion[row][col + 1] == 10 then
						isDrawn[row][col] = true
						isDrawn[row][col + 1] = true
						--										|	 1st point     ||			2nd point  		 			   ||				3rd point  	     	|
						return love.physics.newChainShape(true, colScaled, rowScaled, colScaled + (TILE_SIZE * 2), rowScaled + TILE_SIZE, colScaled + (TILE_SIZE * 2), rowScaled)
					else
						isDrawn[row][col] = true
						--										|	 	1st point  ||			2nd point  		 ||				3rd point  	     			  |
						return love.physics.newChainShape(true, colScaled, rowScaled, colScaled + TILE_SIZE, rowScaled, colScaled + TILE_SIZE, rowScaled + (TILE_SIZE / 2))
					end
				elseif piece == 10 then
					isDrawn[row][col] = true
					--										|	   1st point   ||			2nd point  		 ||				3rd point  	     	  ||				4th point 	 		|
					return love.physics.newChainShape(true, colScaled, rowScaled, colScaled + TILE_SIZE, rowScaled, colScaled + TILE_SIZE, rowScaled + TILE_SIZE, colScaled, rowScaled + (TILE_SIZE / 2))
				
				elseif piece == 12 then
					if self.mapCollsion[row][col + 1] == 13 then
						isDrawn[row][col] = true
						isDrawn[row][col + 1] = true
						--										|	 1st point     ||			2nd point  		 ||				3rd point  	     	  |
						return love.physics.newChainShape(true, colScaled, rowScaled, colScaled, rowScaled + TILE_SIZE, colScaled + (TILE_SIZE * 2), rowScaled)
					else
						isDrawn[row][col] = true
						--										|	 1st point     ||			2nd point  		 ||				3rd point  	     			 ||					4th point 	|
						return love.physics.newChainShape(true, colScaled, rowScaled, colScaled + TILE_SIZE, rowScaled, colScaled + TILE_SIZE, rowScaled + (TILE_SIZE / 2),  colScaled,  rowScaled + TILE_SIZE)
					end
				elseif piece == 13 then
					isDrawn[row][col] = true
					--										|	 1st point     ||			2nd point  		 ||				3rd point  	    |
					return love.physics.newChainShape(true, colScaled, rowScaled, colScaled + TILE_SIZE, rowScaled, colScaled, rowScaled + (TILE_SIZE/2))
				end
			end
		
			isDrawn = {}

			shapeTable = IntTableToShapeTable()

			boundriesList = {}

			for i=1, table.getn(shapeTable) do
				boundriesList[i] = Boundry:new(shapeTable[i], PHYSICS.worlds.main)
			end

			return boundriesList
		end
	}
}

