local tableGameCodes = {
    ["AGB-BPRE"] = {["gameID"] = "BPR1", ["name"] = "FireRed"},
    ["AGB-ZBDM"] = {["gameID"] = "BPR1", ["name"] = "FireRed"},
    ["AGB-BPGE"] = {["gameID"] = "BPG1", ["name"] = "LeafGreen"},
    ["AGB-BPEE"] = {["gameID"] = "BPEE", ["name"] = "Emerald"},
    ["AGB-AXVE"] = {["gameID"] = "AXVE", ["name"] = "Ruby"},
    ["AGB-AXPE"] = {["gameID"] = "AXPE", ["name"] = "Sapphire"}
}

local mod = {}

function mod.GetGameVersion()
    GameCode = emu:getGameCode()
	if not (tableGameCodes[GameCode]) then
		ConsoleForText:print("Unknown game. Script disabled.\n\n")
		return false
	end
    ConsoleForText:print(tableGameCodes[GameCode]["name"] .. " detected. Script Enabled.\n\n")
	return true, tableGameCodes[GameCode]["gameID"]
end

return mod