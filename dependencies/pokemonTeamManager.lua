local gameAddresses = {
    ["BPR1"] = {["ally"] = 33702532, ["enemy"] = 33701932},
    ["BPG1"] = {["ally"] = 33702532, ["enemy"] = 33701932}
}

local mod = {}

function mod.GetPokemonTeam(GameID)
	local PokemonTeamAddress = gameAddresses[GameID]["ally"]
	local ReadTemp = ""

	for j = 1, 6 do
		for i = 1, 25 do
			ReadTemp = emu:read32(PokemonTeamAddress) 
			PokemonTeamAddress = PokemonTeamAddress + 4 
			ReadTemp = tonumber(ReadTemp)
			ReadTemp = ReadTemp + 1000000000
			if i == 1 then Pokemon[j] = ReadTemp
			else Pokemon[j] = Pokemon[j] .. ReadTemp
			end
		end
	end
	--	ConsoleForText:print("EnemyPokemon 1 data: " .. Pokemon[2])
end

function mod.SetEnemyPokemonTeam(EnemyPokemonNo, EnemyPokemonPos, GameID)
	local PokemonTeamAddress = gameAddresses[GameID]["enemy"]
	local ReadTemp = ""
	local String1 = 0
	local String2 = 0

		if EnemyPokemonNo == 0 then
			for j = 1, 6 do
				for i = 1, 25 do
					if i == 1 then String1 = i
					else String1 = String1 + 10
					end
					String2 = String1 + 9
					ReadTemp = string.sub(EnemyPokemon[j],String1,String2)
					ReadTemp = tonumber(ReadTemp)
					ReadTemp = ReadTemp - 1000000000
					emu:write32(PokemonTeamAddress, ReadTemp)
					PokemonTeamAddress = PokemonTeamAddress + 4
				end
			end
		else
			PokemonTeamAddress = PokemonTeamAddress + ((EnemyPokemonPos - 1) * 100)
			for i = 1, 25 do
				if i == 1 then String1 = i
				else String1 = String1 + 10
				end
				String2 = String1 + 9
				ReadTemp = string.sub(EnemyPokemon[EnemyPokemonNo],String1,String2)
				ReadTemp = tonumber(ReadTemp)
				ReadTemp = ReadTemp - 1000000000
				emu:write32(PokemonTeamAddress, ReadTemp)
				PokemonTeamAddress = PokemonTeamAddress + 4
			end
		end
end

return mod