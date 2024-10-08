local sensorInfo = {
	name = "Filter dead",
	desc = "Filter units that died",
	author = "Zivnustka", 
	date = "2024-08-26",
	license = "none",
}

local EVAL_PERIOD_DEFAULT = -1 -- actual, no caching

function getInfo()
	return {
		period = EVAL_PERIOD_DEFAULT 
	}
end


-- get madatory module operators
VFS.Include("modules.lua") -- modules table
VFS.Include(modules.attach.data.path .. modules.attach.data.head) -- attach lib module

SpringGetUnitHealth = Spring.GetUnitHealth

-- @description filters dead units
return function(uids)

	local notFilteredUIds = {}
	local j = 1

	for i=1, #uids do

		local uid = uids[i]
		local currHealth = SpringGetUnitHealth(uid)

		if currHealth ~= nil and currHealth > 0 then
			notFilteredUIds[j] = uid
			j = j + 1
		end
	end

	return notFilteredUIds

end