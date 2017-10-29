prototypeMT = {
	__index = {
		new = function(self, arguments)
			newObject = {}
			arguments = arguments or {}

			--This function copies and overites all the data from assign table 1 to table 2
			deepOverwrite = function(table1, table2)
				for key, value in pairs(table2) do
					if type(value) == 'table' then
						table1[key] = {}
						deepOverwrite(table1[key], table2[key])
					else
						table1[key] = value
					end
				end
			end

			deepOverwrite(newObject, self)
			deepOverwrite(newObject, arguments)

			setmetatable(newObject, activeObjectMT)
			return newObject
		end
	}
}

activeObjectMT = {
	__index = {
		r = 0,
		sx = 1,
		sy = 1,
		ox = 0,
		oy = 0,
		getX = function (self)
			if self.x ~= nil then
				return self.x
			elseif self.body ~= nil then
				return self.body.getX()
			else
				return 0
			end
		end,

		getY = function (self)
			if self.y ~= nil then
				return self.y
			elseif self.body ~= nil then
				return self.body.getY()
			else
				return 0
			end
		end,

		--children.child = self:newChild(prototype, arguments)
		newChild = function(self, prototype, arguments)
			newObject = {}
			arguments = arguments or {}
			
			--This function copies and overites all the data from assign table 1 to table 2
			deepOverwrite = function(table1, table2)
				for key, value in pairs(table2) do
					if type(value) == 'table' then
						table1[key] = {}
						deepOverwrite(table1[key], table2[key])
					else
						table1[key] = value
					end
				end
			end

			deepOverwrite(newObject, prototype)
			deepOverwrite(newObject, arguments)
			newObject.parent = self

			setmetatable(newObject, activeObjectMT)
			return newObject
		end,

		loadChildren = function(self)
			for key, value in pairs(self.children) do
				print('loading '..key)
				self.children[key]:load()
			end
		end,

		updateChildren = function(self)
			for key, value in pairs(self.children) do
				self.children[key]:update()
			end
		end,

		drawChildren = function(self)
			for key, value in pairs(self.children) do
				self.children[key]:draw()
			end
		end
	}
}