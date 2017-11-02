--make an index table with functions that are called to check the current input stuff and decide what input is down
--based on that and these are userinput from a newTrigger() or a newcontrol() method

Input = {
	inputMap = { --move to input file
		a = 'left', 
		d = 'right',
		s = 'down',
		w = 'up',
		space = 'activate'
	},
	input = {
		up 			= false,
		down 		= false,
		left 		= false,
		right 		= false,
		activate	= false,
		isdoubleTap = false, --boolean stating if a doubletap has been performed
		doubleTapInput	= nil --String pointing to what input has been double tapped (from self.input)
	},
	lastInput 		= nil, --String that says the last input (from self.input)
	doubleTapTimer 	= 0,
	startDoubleTapTimer = false,
	DOUBLE_INPUT_DELAY = 0.3,

	--[[input = Input:new(inputMap, inputs, doubleTapInputDelay)
		number doubleTapInputDelay - sets the 
		table inputMap {key = 'action'} - creates the innitial input 
	]]--
	construct = function(self, inputMap, inputs, doubleTapInputDelay)
		self.DOUBLE_INPUT_DELAY = doubleTapInputDelay or 0.3
		inputMap = inputMap or {}
		inputs = inputs or {}

		for key, action in pairs(inputMap) do
			if(key ~= 'doubleTap') then
				self.inputMap[key] = action
				self.input[action] = false
			end
		end
	end,

	--[[
		Creates or Modifies a 
		string action - Action whose assigned key would be modified.
		string key - Key on keyboard that the action will be updated to.
	]]--
	newMappedInput = function (self, action, key)
		self.inputMap[key] = action
		self.input[action] = false
	end,

	-- newInput = function (self, action)
	-- 	self.input[action] = false
	-- end,

	-- --[[
	-- 	function rule - function which 
	-- 	function(self, newInput)
	-- 		if newInput == 'up' and self.input then
	-- 		end
	-- 	end
	-- ]]--
	-- newRule = function (self, rule)
	-- 	self.rules[#rules+1] = rule
	-- end,

	inputController = function(self, key)
		newInput = self.inputMap[key]

		
		--Checks if Double Tap
		if self.lastInput == newInput and self.doubleTapTimer > 0 and self.doubleTapTimer <= self.DOUBLE_INPUT_DELAY then
			self.input.isdoubleTap = true
			self.input.doubleTapInput = newInput
			self.lastInput = newInput
			self.startDoubleTapTimer = true
		else
			--Rules
			if (newInput == 'up' and self.input.down == true) or (newInput == 'down' and self.input.up == true) then
			elseif (newInput == 'left' and self.input.right == true) or (newInput == 'right' and self.input.left == true) then
			elseif newInput ~= nil and self.input[newInput] == false then
				self.input[newInput] = true
				self.lastInput = newInput
				self.startDoubleTapTimer = true
			end
		end
	end,

	inputReleaseController = function(self, key)
		if self.inputMap[key] ~= nil and self.input[self.inputMap[key]] == true then
			self.input[self.inputMap[key]] = false
		end
	end,

	update = function(self)
		
		self.input.isdoubleTap = false
		
		if self.startDoubleTapTimer == true then
			self.doubleTapTimer = self.doubleTapTimer + love.timer.getDelta()
		end
		if self.doubleTapTimer > self.DOUBLE_INPUT_DELAY then
			self.startDoubleTapTimer = false
			self.doubleTapTimer = 0
		end
	end
}
setmetatable(Input, OOP.prototypeMT)