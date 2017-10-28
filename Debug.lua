Debug = {
	deepPrint = function(table, count)
		count = count or -1
		count = count + 1
		for key, value in pairs(table) do
			if key == 'parent' then
				for i=1,count do
						io.write('-')
				end
				print('key: '..key..'         \tvalue: '..tostring(value))
			else
				if type(value) == 'table' then
					for i=1,count do
						io.write('-')
					end
					print('key: '..key..'         \tvalue: '..tostring(value))
					Debug.deepPrint(value, count)
				else
					for i=1,count do
						io.write('-')
					end
					print('key: '..key..'         \tvalue: '..tostring(value))
				end
			end
		end
	end
}