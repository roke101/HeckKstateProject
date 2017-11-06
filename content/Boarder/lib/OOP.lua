-- Author: Max Wiens-Evangelista 2017
require 'Boarder.lib.util' 

OOP = {
	prototypeMT = {
		__index = {
			new = function(self, ...)
				local newObject = {}

				util.deepOverwrite(newObject, self)

				setmetatable(newObject, OOP.activeObjectMT)
				newObject:construct(...)
				return newObject
			end,

			newModify = function(self, arguments, ...)
				local newObject = {}
				
				util.deepOverwrite(newObject, self)
				util.deepOverwrite(newObject, arguments)
				
				setmetatable(newObject, OOP.activeObjectMT)
				newObject:construct(...)
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

				util.deepOverwrite(newObject, prototype)
				util.deepOverwrite(newObject, arguments)
				newObject.parent = self

				setmetatable(newObject, OOP.activeObjectMT)
				newObject:construct(...)
				return newObject
			end,

			newModifyChild = function(self, prototype, arguments, ...)
				newObject = {}
				arguments = arguments or {}

				util.deepOverwrite(newObject, prototype)
				util.deepOverwrite(newObject, arguments)
				newObject.parent = self

				setmetatable(newObject, OOP.activeObjectMT)
				newObject:construct(...)
				return newObject
			end,

			loadChildren = function(self)
				for key, value in pairs(self.children) do
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