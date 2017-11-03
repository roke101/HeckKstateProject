-- Author: Max Wiens-Evangelista 2017
images = {
	loadObjectImages = function ()
		
	end
}

function generateTileQuads(image)
	local quad  = {}
	local size = TILE_SIZE
	local height = image:getHeight()
	local width = image:getWidth()
	for i=1, h/w, 1 do
		quad[i] = love.graphics.newQuad(0, i*size-size, size, size, size, size)
	end
	return quad
end
