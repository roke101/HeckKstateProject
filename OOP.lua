require 'Util'

OOP = {
	prototypeMT = {
		__index = {
			new = function(self, ...)
				newObject = {}

				deepOverwrite(newObject, self)

				setmetatable(newObject, OOP.activeObjectMT)
				newObject:construct(arg)
				return newObject
			end,

			newModify = function(self, arguments, ...)
				newObject = {}

				deepOverwrite(newObject, self)
				deepOverwrite(newObject, arguments)
				
				setmetatable(newObject, OOP.activeObjectMT)
				newObject:construct(arg)
				newObject:load()
				return newObject
			end
		}
	},

	activeObjectMT = {
		__index = {
			--children.child = self:newChild(prototype, arguments)
			newChild = function(self, prototype, ...)
				newObject = {}
				arguments = arguments or {}

				deepOverwrite(newObject, prototype)
				deepOverwrite(newObject, arguments)
				newObject.parent = self

				setmetatable(newObject, OOP.activeObjectMT)
				newObject:construct(arg)
				return newObject
			end,

			newModifyChild = function(self, prototype, arguments)
				newObject = {}
				arguments = arguments or {}

				deepOverwrite(newObject, prototype)
				deepOverwrite(newObject, arguments)
				newObject.parent = self

				setmetatable(newObject, OOP.activeObjectMT)
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
}