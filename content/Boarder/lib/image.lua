-- Author: Max Wiens-Evangelista 2017
image = {
	generateTileQuads = function (image)
	local quad  = {}
	local width = image:getWidth()
	local height = image:getHeight()
	print(width)
	print(height)
	for i=1, height/width, 1 do
		quad[i] = love.graphics.newQuad(0, (i-1)*width, width, width, width, height)
	end
	return quad
end
}


