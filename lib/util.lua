-- Author: Max Wiens-Evangelista 2017

util = {
	--This function copies and overites all the data from assign table 1 to table 2
	deepOverwrite = function(table1, table2)
		for key, value in pairs(table2) do
			if type(value) == 'table' then
				table1[key] = {}
				util.deepOverwrite(table1[key], table2[key])
			else
				table1[key] = value
			end
		end
		return table1
	end,

	round = function (n)
		if n < 0 then
			return math.ceil(n-.5)
		else 
			return math.floor(n+.5)
		end
	end
}