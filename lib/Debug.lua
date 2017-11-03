Debug = {
	deepPrint = function(table, count)
		count = count or -1
		count = count + 1
		for key, value in pairs(table) do
			if key == 'parent' then
				for i=1,count do
						io.write('-')
				end
				print(key..'         \t'..tostring(value))
			else
				if type(value) == 'table' then
					for i=1,count do
						io.write('-')
					end
					print(key..'         \t'..tostring(value))
					Debug.deepPrint(value, count)
				else
					for i=1,count do
						io.write('-')
					end
					print(key..'         \t'..tostring(value))
				end
			end
		end
	end,

	ideepPrint = function(table, count)
		count = count or -1
		count = count + 1
		for key, value in ipairs(table) do
			if key == 'parent' then
				for i=1,count do
						io.write('-')
				end
				print(key..'         \t'..tostring(value))
			else
				if type(value) == 'table' then
					for i=1,count do
						io.write('-')
					end
					print(key..'         \t'..tostring(value))
					Debug.deepPrint(value, count)
				else
					for i=1,count do
						io.write('-')
					end
					print(key..'         \t'..tostring(value))
				end
			end
		end
	end
}