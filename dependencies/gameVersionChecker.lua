local tableGameCodes = {
    ["AGB-BPRE"] = {["gameID"] = "BPR1", ["name"] = "FireRed"},
    ["AGB-ZBDM"] = {["gameID"] = "BPR1", ["name"] = "FireRed"},
    ["AGB-BPGE"] = {["gameID"] = "BPG1", ["name"] = "LeafGreen"},
    ["AGB-BPEE"] = {["gameID"] = "BPEE", ["name"] = "Emerald"},
    ["AGB-AXVE"] = {["gameID"] = "AXVE", ["name"] = "Ruby"},
    ["AGB-AXPE"] = {["gameID"] = "AXPE", ["name"] = "Sapphire"}
}
local gameVersions = {
    ["AGB-BPRE"] = {[26624] = "BPR1", [26369] = "BPR2"},
    ["AGB-ZBDM"] = {[33024] = "BPG1", [32769] = "BPG2"}
}

local mod = {}

function mod.GetGameVersion()
    local gameCode = emu:getGameCode()
	if not (tableGameCodes[gameCode]) then
		ConsoleForText:print("Unknown game. Script disabled.\n\n")
		EnableScript = false
    end
    if gameVersions[gameCode] then
        local gameVersion = emu:read16(134217916)
        if gameVersions[gameCode][gameVersion] then
            tableGameCodes[gameCode].gameID = gameVersions[gameCode][gameVersion]
        end
    end

    EnableScript = true
    GameID = tableGameCodes[gameCode].gameID
    ConsoleForText:print(tableGameCodes[gameCode]["name"] .. "[".. GameID  .."] detected. Script Enabled.\n\n")
end

return mod