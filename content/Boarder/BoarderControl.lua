require 'Boarder.lib.OOP'
require 'Boarder.lib.debug'
require 'Boarder.Boundry'
-- Represents a shape (or boundry) in the world.
BoarderControl = {
	
	world = nil,

	inputTable = {},

	isDrawn = {},

	size = nil,

	shapeTable = {},

	boundriesList = {},

	--Constructor for boundry that initializes all the variables in Boundry
	--A shape and the world that the Boundry will belong to are passed in.
	construct = function (self, inputTable, mainWorld, size)
		self.inputTable = inputTable
		
		self.world = mainWorld
		
		for i=1, table.getn(self.inputTable) do
			self.isDrawn[i] = {}
			for j=1, table.getn(self.inputTable[i]) do
				self.isDrawn[i][j] = false
			end
		end

		self.size = size


		self.shapeTable = self:intToShapeTable()

		for i=1, table.getn(self.shapeTable) do
			self.boundriesList[i] = Boundry:new(self.shapeTable[i], world)
		end
	end,

	getBoundriesList = function(self)
		return self.boundriesList
	end,

	--add load, update, draw -check-
	load = function (self)

	end,

	update = function (self)

	end,

	draw = function (self, X, Y)
		
	end,

	--- EVERYTHING BEYOND THIS POINT IS FUNCTIONS USED FOR GETTING THE PHYSICS OBJECTS

	intToShapeTable = function(self)
		returnShapeTable = {}

		--first initialize the self.isDrawn to to mirror self.inputTable size, and all elements = false
		for i=1, table.getn(self.inputTable) do
			self.isDrawn[i] = {}
			for j=1, table.getn(self.inputTable[i]) do
				self.isDrawn[i][j] = false
			end
		end

		--now construct the outer boarder
		width = (table.getn(self.inputTable[1]) + 1) * self.size -- change back to +1
		height = (table.getn(self.inputTable) + 1) * self.size -- change back to +1
		outerShape = love.physics.newChainShape(true, self.size, self.size, self.size, height, width, height, width, self.size)

		table.insert(returnShapeTable, outerShape)

		--now we need to add all the inside boundries that are on the inside into the array
		--this will be done row by row using a function to draw a single one
		for i=table.getn(self.inputTable), 1, -1 do
			for j=table.getn(self.inputTable[1]), 1, -1 do
			
				if (self.inputTable[i][j]) == 1 and (self.isDrawn[i][j] == false) then
					table.insert(returnShapeTable, self:drawSingle(i, j))
				elseif (self.inputTable[i][j] > 1) and (self.isDrawn[i][j] == false) then
					table.insert(returnShapeTable, self:drawSpecialCase(self.inputTable[i][j], i, j))
				end

			end
		end

		return returnShapeTable
	end,

	drawSingle = function(self, row, col)
		width = 0

		rowScaled = row * self.size
		colScaled = col * self.size

		for i=col, table.getn(self.inputTable[row]) do
			if(self.inputTable[row][i] ~= 1) then
				break
			end

			width = width + 1
			self.isDrawn[row][i] = true
		end

		width = width * self.size
	
		--										|		1st point   ||		2nd point		      ||			3rd point				||			4th point		 |
		return love.physics.newChainShape(true, colScaled, rowScaled, colScaled, rowScaled + self.size, colScaled + width, rowScaled + self.size, colScaled + width, rowScaled)
	end,

	drawSpecialCase = function(self, piece, row, col)
		rowScaled = row * self.size
		colScaled = col * self.size

		if piece == 2 then
			self.isDrawn[row][col] = true
			--										|	 1st point      ||			2nd point  		  ||				3rd point  	        |
			return love.physics.newChainShape(true, colScaled, rowScaled, colScaled, rowScaled + self.size, colScaled + self.size, rowScaled + self.size)
		elseif piece == 3 then
			self.isDrawn[row][col] = true
			--										|			1st point      ||			2nd point  				 ||				3rd point  	   |
			return love.physics.newChainShape(true, colScaled, rowScaled + self.size, colScaled + self.size, rowScaled + self.size, colScaled + self.size, rowScaled)
	
		elseif piece == 4 then
			if self.inputTable[row][col + 1] == 5 then
				self.isDrawn[row][col] = true
				self.isDrawn[row][col + 1] = true
				--										|	 1st point     ||			2nd point  		 ||				3rd point  	     		  	  |
				return love.physics.newChainShape(true, colScaled, rowScaled, colScaled, rowScaled + self.size, colScaled + (self.size * 2), rowScaled + self.size)
			else
				self.isDrawn[row][col] = true
				--										|	 1st point     ||			2nd point  		 ||				3rd point  	     		||					4th point 				|
				return love.physics.newChainShape(true, colScaled, rowScaled, colScaled, rowScaled + self.size, colScaled + self.size, rowScaled + self.size,  colScaled + self.size,  rowScaled + (self.size / 2))
			end
		elseif piece == 5 then
			self.isDrawn[row][col] = true
			--										|	 1st point     				 ||			2nd point  		   ||				3rd point  	     	  |
			return love.physics.newChainShape(true, colScaled, rowScaled + (self.size / 2), colScaled, rowScaled + self.size, colScaled + self.size, rowScaled + self.size)

		elseif piece == 7 then
			if self.inputTable[row][col + 1] == 6 then
				self.isDrawn[row][col] = true
				self.isDrawn[row][col + 1] = true
				--										|	 	1st point  		   ||			2nd point  		 			   ||				3rd point  	     	|
				return love.physics.newChainShape(true, colScaled, rowScaled + self.size, colScaled + (self.size * 2), rowScaled + self.size, colScaled + (self.size * 2), rowScaled)
			else
				self.isDrawn[row][col] = true
				--										|	 	1st point          ||			2nd point  		 		 ||				3rd point  	     			  |
				return love.physics.newChainShape(true, colScaled, rowScaled + self.size, colScaled + self.size, rowScaled + self.size, colScaled + self.size, rowScaled + (self.size / 2))
			end
		elseif piece == 6 then
			self.isDrawn[row][col] = true
			--										|	   1st point   				 ||			2nd point  		   ||				3rd point  	     	 ||				4th point 				   |
			return love.physics.newChainShape(true, colScaled, rowScaled + (self.size / 2), colScaled, rowScaled + self.size, colScaled + self.size, rowScaled + self.size, colScaled + self.size, rowScaled)
	
		elseif piece == 8 then
			self.isDrawn[row][col] = true
			--										|	 1st point      ||			2nd point  		  ||				3rd point  	        |
			return love.physics.newChainShape(true, colScaled, rowScaled, colScaled + self.size, rowScaled, colScaled + self.size, rowScaled + self.size)
		elseif piece == 9 then
			self.isDrawn[row][col] = true
			--										|	 1st point      ||			2nd point  		  ||	 3rd point  	        |
			return love.physics.newChainShape(true, colScaled, rowScaled, colScaled + self.size, rowScaled, colScaled, rowScaled + self.size)
	
		elseif piece == 11 then
			if self.inputTable[row][col + 1] == 10 then
				self.isDrawn[row][col] = true
				self.isDrawn[row][col + 1] = true
				--										|	 1st point     ||			2nd point  		 			   ||				3rd point  	     	|
				return love.physics.newChainShape(true, colScaled, rowScaled, colScaled + (self.size * 2), rowScaled + self.size, colScaled + (self.size * 2), rowScaled)
			else
				self.isDrawn[row][col] = true
				--										|	 	1st point  ||			2nd point  		 ||				3rd point  	     			  |
				return love.physics.newChainShape(true, colScaled, rowScaled, colScaled + self.size, rowScaled, colScaled + self.size, rowScaled + (self.size / 2))
			end
		elseif piece == 10 then
			self.isDrawn[row][col] = true
			--										|	   1st point   ||			2nd point  		 ||				3rd point  	     	  ||				4th point 	 		|
			return love.physics.newChainShape(true, colScaled, rowScaled, colScaled + self.size, rowScaled, colScaled + self.size, rowScaled + self.size, colScaled, rowScaled + (self.size / 2))
	
		elseif piece == 12 then
			if self.inputTable[row][col + 1] == 13 then
				self.isDrawn[row][col] = true
				self.isDrawn[row][col + 1] = true
				--										|	 1st point     ||			2nd point  		 ||				3rd point  	     	  |
				return love.physics.newChainShape(true, colScaled, rowScaled, colScaled, rowScaled + self.size, colScaled + (self.size * 2), rowScaled)
			else
				self.isDrawn[row][col] = true
				--										|	 1st point     ||			2nd point  		 ||				3rd point  	     			 ||					4th point 	|
				return love.physics.newChainShape(true, colScaled, rowScaled, colScaled + self.size, rowScaled, colScaled + self.size, rowScaled + (self.size / 2),  colScaled,  rowScaled + self.size)
			end
		elseif piece == 13 then
			self.isDrawn[row][col] = true
			--										|	 1st point     ||			2nd point  		 ||				3rd point  	    |
			return love.physics.newChainShape(true, colScaled, rowScaled, colScaled + self.size, rowScaled, colScaled, rowScaled + (self.size/2))
		end
	end
}
setmetatable(BoarderControl, OOP.prototypeMT)