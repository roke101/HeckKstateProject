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
				self.children[key].load()
			end
		end,

		updateChildren = function(self)
			for key, value in pairs(self.children) do
				self.children[key].update()
			end
		end,

		drawChildren = function(self)
			for key, value in pairs(self.children) do
				self.children[key].draw()
			end
		end
	}
}