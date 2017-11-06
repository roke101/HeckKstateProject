require 'Boarder.lib.OOP'
require 'Boarder.lib.debug'
-- Represents a shape (or boundry) in the world.
Boundry = {
	--Stores the body for the boundry.
	body = nil,
	--stores the shape of the boundry.
	shape = nil,
	--Stores the fixture of the boundry
	fixture = nil,

	--Constructor for boundry that initializes all the variables in Boundry
	--A shape and the world that the Boundry will belong to are passed in.
	construct = function (self, inShape, inWorld)
		self.body = love.physics.newBody(inWorld, 0, 0, "static")
		self.shape = inShape
		self.fixture = love.physics.newFixture(self.body, self.shape)
		self.fixture:setUserData("Boarder")
	end
	--add load, update, draw
	--draw = function (self, X, Y)
		--if(debug.drawBoundaries) then
			--love.graphics.setColor(50, 50, 50)
			--love.graphics.polygon("fill", self.body:getWorldPoints(self.shape:getPoints()))
			--love.graphics.setColo(255,255,255)
		--end
	--end
}
setmetatable(Boundry, OOP.prototypeMT)