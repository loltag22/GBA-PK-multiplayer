local IPAddress, Port = "127.0.0.1", 4096
local MaxPlayers = 4
local Nickname = ""

--for testing porpuse I will use absulute path
--package.path = "./scripts/dependencies/?.lua;" .. package.path
package.path = "C:/Users/domin/Documents/Projects/3-gen-MP/GBA-PK-multiplayer/dependencies/?.lua;" .. package.path

local SpriteGenerator = require "spriteGenerator"
local GameChecker = require "gameVersionChecker"
local PokemonTeamManager = require "pokemonTeamManager"
local MVars = require "multiplayerVars"
local PVars = require "playerVars"
local ScriptLoader = require "scriptLoader"


GameID = ""
local ConfirmPackett = 0
EnableScript = false
local ClientConnection


--Map ID
local u32 MapAddress = 0
local u32 MapAddress2 = 0
local PlayerID = 1
local PlayerID2 = 1001
local ScriptTime = 0
local ScriptTimePrev = 0
local initialized = 0
local ScriptTimeFrame = 4


--Internet Play
--local tcp = assert(socket.tcp())
local SocketMain = socket:tcp()
local Packett = ""
local MasterClient = "a"
--timout = every connection attempt
local timeoutmax = 600
local ReturnConnectionType = ""
local FramesPS = 0


--Animation frames
local PlayerAnimationFrame = {0,0,0,0,0,0,0,0}
local PlayerAnimationFrame2 = {0,0,0,0,0,0,0,0}
local PlayerAnimationFrameMax = {0,0,0,0,0,0,0,0}
local PreviousPlayerAnimation = {0,0,0,0,0,0,0,0}



--Addresses
local u32 PlayerAddress = {0,0,0,0,0,0,0,0}


local FFTimer = 0
local FFTimer2 = 0
local ScreenData = 0

local Pokemon = {"","","","","",""}

local EnemyPokemon = {"","","","","",""}

ConsoleForText = nil
local Keypressholding = 0
local LockFromScript = 0
local HideSeek = 0
local HideSeekTimer = 0
local ROMCARD
if not (emu == nil) then ROMCARD = emu.memory.cart0 end
local BufferString = "None"
local PrevExtraAdr = 0
local SendTimer = 0
local Var8000 = {}
local u32 Var8000Adr = {}
local Startvaraddress = 0
local TextSpeedWait = 0
local OtherPlayerHasCancelled = 0
local TradeVars = {0,0,0,0,"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF"}
local EnemyTradeVars = {0,0,0,0,0}
local BattleVars = {0,0,0,0,0,0,0,0,0,0,0}
local EnemyBattleVars = {0,0,0,0,0,0,0,0,0,0,0}
local BufferVars = {0,0,0}
TradeVars[5] = "FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF"


--Decryption for positioning/small packetts
local ReceiveDataSmall = {}
					
--Debug time is how long in frames each message should show. once every 300 frames, or 5 seconds, should be plenty
local DebugTime = 300
local DebugTime2 = 30
local DebugTime3 = 1
local TempVar1 = 0
local TempVar2 = 0
local TempVar3 = 0

function ClearAllVar()
	local MultFlags = 0
	LockFromScript = 0
	
	 GameID = ""
--	 Nickname = ""
	 ConfirmPackett = 0
	 EnableScript = false
	 
	 ScriptTime = 0
	 initialized = 0

--Server Switches

--If 0 then don't render players
	ScreenData = 0
	MVars.MultiplayerConsoleFlags[1] = 0
	
	for i = 1, MaxPlayers do
		MultFlags = i + 1
		 MVars.PlayerVis[i] = 0
		 MVars.MultiplayerConsoleFlags[MultFlags] = 0
		 MVars.HasErasedPlayer[i] = false
		if i ~= PlayerID and MVars.PlayerIDNick[i] ~= "None" then
			RemovePlayerFromConsole(i)
		end
	end

end


function FixAddress()
	local MultichoiceAdr = 0
		if GameID == "BPR1" then
			MultichoiceAdr = 138282176
		elseif GameID == "BPR2" then
			MultichoiceAdr = 138282288
		elseif GameID == "BPG1" then
			MultichoiceAdr = 138281724
		elseif GameID == "BPG2" then
			MultichoiceAdr = 138281836
		end
	if PrevExtraAdr ~= 0 then
		emu:write32(MultichoiceAdr, PrevExtraAdr)
	end
end


function ApplyMovement(MovementType)
	local u32 ScriptAddress = 50335400
	local u32 ScriptAddress2 = 145227776
	local ScriptAddressTemp = 0
	local ScriptAddressTemp1 = 0
	ScriptAddressTemp = ScriptAddress2
	ScriptAddressTemp1 = 16732010
	ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
	ScriptAddressTemp = ScriptAddressTemp + 4
	ScriptAddressTemp1 = 145227790
	ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
	ScriptAddressTemp = ScriptAddressTemp + 4
	ScriptAddressTemp1 = 1811939409
	ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
	ScriptAddressTemp = ScriptAddressTemp + 4
	ScriptAddressTemp1 = 65282
	ROMCARD:write16(ScriptAddressTemp, ScriptAddressTemp1)
	if MovementType == 0 then
		ScriptAddressTemp = ScriptAddressTemp + 2
		ScriptAddressTemp1 = 65024
		ROMCARD:write16(ScriptAddressTemp, ScriptAddressTemp1)
		LoadScriptIntoMemory()
	elseif MovementType == 1 then
		ScriptAddressTemp = ScriptAddressTemp + 2
		ScriptAddressTemp1 = 65025
		ROMCARD:write16(ScriptAddressTemp, ScriptAddressTemp1)
		LoadScriptIntoMemory()
	elseif MovementType == 2 then
		ScriptAddressTemp = ScriptAddressTemp + 2
		ScriptAddressTemp1 = 65026
		ROMCARD:write16(ScriptAddressTemp, ScriptAddressTemp1)
		LoadScriptIntoMemory()
	elseif MovementType == 3 then
		ScriptAddressTemp = ScriptAddressTemp + 2
		ScriptAddressTemp1 = 65027
		ROMCARD:write16(ScriptAddressTemp, ScriptAddressTemp1)
		LoadScriptIntoMemory()
	end
end

function LoadScriptIntoMemory()
--This puts the script at ScriptAddress into the memory, forcing it to load

	local u32 ScriptAddress = 50335400
	local u32 ScriptAddress2 = 145227776
	local ScriptAddressTemp = 0
	local ScriptAddressTemp1 = 0
				ScriptAddressTemp = ScriptAddress
				ScriptAddressTemp1 = 0
				emu:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 0
				emu:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				--Either use 66048, 512, or 513.
				ScriptAddressTemp1 = 513
				emu:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4
				--134654353 and 145293312 freezes the game
				ScriptAddressTemp1 = 0
				emu:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = ScriptAddress2 + 1
				emu:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 0
				emu:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 0
				emu:write32(ScriptAddressTemp, ScriptAddressTemp1)
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 0
				emu:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 0
				emu:write32(ScriptAddressTemp, ScriptAddressTemp1)
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 0
				emu:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 0
				emu:write32(ScriptAddressTemp, ScriptAddressTemp1)
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 0
				emu:write32(ScriptAddressTemp, ScriptAddressTemp1)
				--END Block
end

function SendMultiplayerPackets(Offset, size, Socket)
	local Packet = ""
	local ModifiedSize = 0
	local ModifiedLoop = 0
	local ModifiedLoop2 = 0
	local PacketAmount = 0
	--Using RAM 0263DE00 for packets, as it seems free. If not, will modify later
	if offset == 0 then offset = 40099328 end
	local ModifiedRead = ""
	if size > 0 then
		CreatePackettSpecial("SLNK",Socket,size)
		for i = 1, size do
			--Inverse of i, size remaining. 1 = last. Also size represents hex bytes, which goes up to 255 in decimal, so we triple it.
			ModifiedSize = size - i + 1
			if ModifiedSize > 20 and ModifiedLoop == 0 then
				PacketAmount = PacketAmount + 1
				ModifiedLoop = 20
				ModifiedLoop2 = 0
			--	ConsoleForText:print("Packet number: " .. PacketAmount)
			elseif ModifiedSize <= 20 and ModifiedLoop == 0 then
				PacketAmount = PacketAmount + 1
				ModifiedLoop = ModifiedSize
				ModifiedLoop2 = 0
			--	ConsoleForText:print("Last packet. Number: " .. PacketAmount)
			end
			if ModifiedLoop ~= 0 then
				ModifiedLoop2 = ModifiedLoop2 + 1
				ModifiedRead = emu:read8(Offset)
				ModifiedRead = tonumber(ModifiedRead)
				ModifiedRead = ModifiedRead + 100
				if Packet == "" then Packet = ModifiedRead
				else Packet = Packet .. ModifiedRead
				end
				if ModifiedLoop == 1 then
					Socket:send(Packet)
			--		ConsoleForText:print("Packet sent! Packet " .. Packet .. " end. Amount of loops: " .. ModifiedLoop2 .. " " .. Offset)
					Packet = ""
					ModifiedLoop = 0
				else
					ModifiedLoop = ModifiedLoop - 1
				end
			end
			offset = Offset + 1
		end
	end
end

function ReceiveMultiplayerPackets(size, Socket)
	local Packet = ""
	local ModifiedSize = 0
	local ModifiedLoop = 0
	local ModifiedLoop2 = 0
	local PacketAmount = 0
	local ModifiedRead
	local ModifiedLoop3 = 0
	local SizeMod = 0
	--Using RAM 0263D000-0263DDFF for received data, as it seems free. If not, will modify later
	local MultiplayerPacketSpace = 40095744
	--ConsoleForText:print("TEST 1")
	for i = 1, size do
		--Inverse of i, size remaining. 1 = last. Also size represents hex bytes, which goes up to 255 in decimal
		ModifiedSize = size - i + 1
		if ModifiedSize > 20 and ModifiedLoop == 0 then
			PacketAmount = PacketAmount + 1
			Packet = Socket:receive(60)
			ModifiedLoop = 20
			ModifiedLoop2 = 0
	--		ConsoleForText:print("Packet number: " .. PacketAmount)
		elseif ModifiedSize <= 20 and ModifiedLoop == 0 then
			PacketAmount = PacketAmount + 1
			SizeMod = ModifiedSize * 3
			Packet = Socket:receive(SizeMod)
			ModifiedLoop = ModifiedSize
			ModifiedLoop2 = 0
	--		ConsoleForText:print("Last packet. Number: " .. PacketAmount)
		end
		if ModifiedLoop ~= 0 then
			ModifiedLoop3 = ModifiedLoop2 * 3 + 1
			ModifiedLoop2 = ModifiedLoop2 + 1
			SizeMod = ModifiedLoop3 + 2
			ModifiedRead = string.sub(Packet, ModifiedLoop3, SizeMod)
			ModifiedRead = tonumber(ModifiedRead)
			ModifiedRead = ModifiedRead - 100
			emu:write8(MultiplayerPacketSpace, ModifiedRead)
	--		ConsoleForText:print("Num: " .. ModifiedRead)
	--		ConsoleForText:print("NUM: " .. ModifiedRead)
			if ModifiedLoop == 1 then
		--		ConsoleForText:print("Packet " .. PacketAmount .. " end. Amount of loops: " .. ModifiedLoop2 .. " " .. MultiplayerPacketSpace)
				Packet = ""
				ModifiedLoop = 0
			else
				ModifiedLoop = ModifiedLoop - 1
			end
		end
		MultiplayerPacketSpace = MultiplayerPacketSpace + 1
	end
end

function Battlescript()


end

function BattlescriptClassic()
	--Cursor
	
	BattleVars[2] = emu:read8(33701880)
	--Battle finished. 1 = yes, 0 = is still ongoing
	BattleVars[3] = emu:read8(33701514)
	--Phase. 4 = finished moves.
	BattleVars[4] = emu:read8(33701506)
	--Speed. 256 = You move first. 1 = You move last
	BattleVars[5] = emu:read16(33700830)
	if BattleVars[5] > 10 then BattleVars[5] = 1
	else BattleVars[5] = 0
	end
		
	--Initialize battle
	if BattleVars[1] == 0 then
		BattleVars[1] = 1
		BattleVars[11] = 1
		
		ScriptLoader.Loadscript(22)
		--Trainerbattleoutro
		local Buffer1 = 33785528
		local Buffer2 = 145227780
		--Outro for battle. "Thanks for the great battle."
		local Bufferloc = "1145227780"
		local Bufferstring = "48056665104657492447489237321946742660764906329062490632806439167372565294967295"
	
		--514 = Player red ID, 515 = Leaf aka female
		emu:write16(33785518, 514)
		--Cursor. Set to 0
		emu:write8(33701880, 0)
		--Set win to 0
		emu:write8(33701514, 0)
		--Set speeds to 0
		emu:write16(33700830, 0)
		--Set turn to 0
		emu:write8(33700834, 0)
				
		WriteBuffers(Buffer1, Bufferloc, 1)
		WriteRom(Buffer2, Bufferstring, 8)
		
	--Wait 150 frames for other vars to load
	elseif BattleVars[1] == 1 and BattleVars[11] < 150 then
		BattleVars[11] = BattleVars[11] + 1
			--514 = Player red ID, 515 = Leaf aka female
			emu:write16(33785518, 514)
			--Cursor. Set to 0
			emu:write8(33701880, 0)
			--Set win to 0
			emu:write8(33701514, 0)
			--Set speeds to 0
			emu:write16(33700830, 0)
			--Set turn to 0
			emu:write8(33700834, 0)
			if BattleVars[11] >= 150 then
				--Set enemy team
				PokemonTeamManager.SetEnemyPokemonTeam(0,1)
				BattleVars[1] = 2
			end
		
	--Battle loop
	elseif BattleVars[1] == 2 then
		BattleVars[12] = emu:read8(33700808)
		BufferVars[20] = ""
		
		--If both players have not gone
		if BattleVars[6] == 0 then
			--You have not decided on a move
			if BattleVars[4] >= 1 and EnemyBattleVars[4] ~= 4 then
				--Pause until other player has made a move
				if BattleVars[12] < 32 then
					BattleVars[12] = BattleVars[12] + 32
					emu:write8(33700808, BattleVars[12])
				end
			elseif BattleVars[4] >= 4 and EnemyBattleVars[4] >= 4 then
				if MasterClient == "h" then
					if BattleVars[5] == 1 then
						BattleVars[6] = 1
					else
						BattleVars[6] = 2
					end
				else
					if EnemyBattleVars[5] == 1 then
						BattleVars[6] = 2
					else
						BattleVars[6] = 1
					end
				end
			end
		--You go first
		elseif BattleVars[6] == 1 then
			local TurnTime = emu:read8(33700834)
			--Write speed to 256
			emu:write16(33700830, 256)
			if BattleVars[7] == 0 then
				BattleVars[7] = 1
			--	BattleVars[13] = ReadBuffers()
			--	ConsoleForText:print("First")
			-- SEND DATA
				CreatePackettSpecial("BAT2", MVars.Players[MVars.PlayerTalkingID])
				
			--Animate
			elseif BattleVars[7] == 1 and EnemyBattleVars[7] == 1 and TurnTime == 0 then
				if BattleVars[12] >= 32 then
					BattleVars[12] = BattleVars[12] - 32
					emu:write8(33700808, BattleVars[12])
				end
				
			--Other player's turn. Pause.
			elseif BattleVars[7] == 1 and TurnTime == 1 then
				if BattleVars[12] < 32 then
					BattleVars[12] = BattleVars[12] + 32
					emu:write8(33700808, BattleVars[12])
				end
				BattleVars[7] = 2
			--Once received then set 7 to 3.
			elseif BattleVars[7] == 2 and string.len(BattleVars[20]) == 280 and string.len(BattleVars[21]) == 244 then
				BattleVars[7] = 3
			--Animate
			elseif BattleVars[7] == 3 and EnemyBattleVars[7] == 3 then
				if BattleVars[12] >= 32 then
					BattleVars[12] = BattleVars[12] - 32
					emu:write8(33700808, BattleVars[12])
				end
				BattleVars[7] = 4
			--Lock after animations while waiting for other player
			elseif BattleVars[7] == 4 and TurnTime == 2 then
				if BattleVars[12] < 32 then
					BattleVars[12] = BattleVars[12] + 32
					emu:write8(33700808, BattleVars[12])
				end
			--Unlock if both players finish animations
			elseif BattleVars[7] == 4 and TurnTime == 2 then
				if BattleVars[12] < 32 then
					BattleVars[12] = BattleVars[12] + 32
					emu:write8(33700808, BattleVars[12])
				end
				BattleVars[7] = 4
			end
		--You go second
		elseif BattleVars[6] == 2 then
		local TurnTime = emu:read8(33700834)
			--Write speed to 1
			emu:write16(33700830, 1)
			if BattleVars[7] == 0 and string.len(BattleVars[20]) == 280 and string.len(BattleVars[21]) == 244 then
				BattleVars[7] = 1
			--	BattleVars[13] = ReadBuffers()
			-- RECEIVEDATA
			--	ConsoleForText:print("Second")
			elseif BattleVars[7] == 1 and EnemyBattleVars[7] == 1 then
				if BattleVars[12] >= 32 then
					BattleVars[12] = BattleVars[12] - 32
					emu:write8(33700808, BattleVars[12])
				end
			end
		end
	end
	
	--Prevent item use
	if BattleVars[1] >= 2 and BattleVars[2] == 1 then emu:write8(33696589, 1)
	else emu:write8(33696589, 0)
	end
	
	--Unlock once battle ends
	if BattleVars[1] >= 2 and BattleVars[3] == 1 then LockFromScript = 0 end
	
	
	if SendTimer == 0 then CreatePackettSpecial("BATT", MVars.Players[MVars.PlayerTalkingID]) end
end

function WriteBuffers(BufferOffset, BufferVar, Length)
	local BufferOffset2 = BufferOffset
	local BufferVarSeperate
	local String1 = 0
	local String2 = 0
	for i = 1, Length do
		if i == 1 then String1 = 1
		else String1 = String1 + 10
		end
		String2 = String1 + 9
		BufferVarSeperate = string.sub(BufferVar, String1, String2)
		BufferVarSeperate = tonumber(BufferVarSeperate)
		BufferVarSeperate = BufferVarSeperate - 1000000000
		emu:write32(BufferOffset2, BufferVarSeperate)
		BufferOffset2 = BufferOffset2 + 4
	end
end
function WriteRom(RomOffset, RomVar, Length)
	local RomOffset2 = RomOffset
	local RomVarSeperate
	local String1 = 0
	local String2 = 0
	for i = 1, Length do
		if i == 1 then String1 = 1
		else String1 = String1 + 10
		end
		String2 = String1 + 9
		RomVarSeperate = string.sub(RomVar, String1, String2)
		RomVarSeperate = tonumber(RomVarSeperate)
		RomVarSeperate = RomVarSeperate - 1000000000
		ROMCARD:write32(RomOffset2, RomVarSeperate)
		RomOffset2 = RomOffset2 + 4
	end
end
function ReadBuffers(BufferOffset, Length)
	local BufferOffset2 = BufferOffset
	local BufferVar
	local BufferVarSeperate
	for i = 1, Length do
		BufferVarSeperate = emu:read32(BufferOffset2)
		BufferVarSeperate = tonumber(BufferVarSeperate)
		BufferVarSeperate = BufferVarSeperate + 1000000000
		if i == 1 then BufferVar = BufferVarSeperate
		else BufferVar = BufferVar .. BufferVarSeperate
		end
		BufferOffset2 = BufferOffset2 + 4
	end
	return BufferVar
end
function Tradescript()
	--Buffer 1 is enemy pokemon, 2 is our pokemon
	local Buffer1 = 33692880
	local Buffer2 = 33692912
	local Buffer3 = 33692932
	
	
	
	if TradeVars[1] == 0 and TradeVars[4] == 0 and TradeVars[3] == 0 and EnemyTradeVars[3] == 0 then
		OtherPlayerHasCancelled = 0
		TradeVars[3] = 1
		ScriptLoader.Loadscript(4)
	elseif TradeVars[1] == 0 and TradeVars[4] == 0 and TradeVars[3] == 0 and EnemyTradeVars[3] > 0 then
		TradeVars[3] = 1
		TradeVars[4] = 1
		ScriptLoader.Loadscript(14)
	elseif TradeVars[1] == 0 and TradeVars[4] == 0 and EnemyTradeVars[3] > 0 and TradeVars[3] > 0 then
		TradeVars[4] = 1
		ScriptLoader.Loadscript(14)

--	if TempVar2 == 0 then ConsoleForText:print("1: " .. TradeVars[1] .. " 8001: " .. Var8000[2] .. " OtherPlayerHasCancelled: " .. OtherPlayerHasCancelled .. " EnemyTradeVars[1]: " .. EnemyTradeVars[1]) end

	--Text is finished before trade
	elseif Var8000[2] ~= 0 and TradeVars[4] == 1 and TradeVars[1] == 0 then
		TradeVars[1] = 1
		TradeVars[2] = 0
		TradeVars[3] = 0
		TradeVars[4] = 0
		Var8000[1] = 0
		Var8000[2] = 0
		ScriptLoader.Loadscript(12)
	
	--You have canceled or have not selected a valid pokemon slot
	elseif Var8000[2] == 1 and TradeVars[1] == 1 then
		ScriptLoader.Loadscript(16)
		SendData("CTRA",MVars.Players[MVars.PlayerTalkingID])
		LockFromScript = 0
		TradeVars[1] = 0
		TradeVars[2] = 0
		TradeVars[3] = 0
	--The other player has canceled
	elseif Var8000[2] == 2 and TradeVars[1] == 1 and OtherPlayerHasCancelled ~= 0 then
		OtherPlayerHasCancelled = 0
		ScriptLoader.Loadscript(19)
		LockFromScript = 7
		TradeVars[1] = 0
		TradeVars[2] = 0
		TradeVars[3] = 0
	
	--You have finished your selection
	elseif Var8000[2] == 2 and TradeVars[1] == 1 and OtherPlayerHasCancelled == 0 then
		--You just finished. Display waiting
		TradeVars[3] = Var8000[5]
		TradeVars[5] = ReadBuffers(Buffer2, 4)
	--	TradeVars[6] = TradeVars[5] .. 5294967295
	--	WriteBuffers(Buffer1, TradeVars[6], 5)
		if EnemyTradeVars[1] == 2 then
			EnemyTradeVars[6] = EnemyTradeVars[5] .. 5294967295
			WriteBuffers(Buffer1, EnemyTradeVars[6], 5)
			TradeVars[1] = 3
			ScriptLoader.Loadscript(8)
		else
			ScriptLoader.Loadscript(4)
			TradeVars[1] = 2
		end
	elseif TradeVars[1] == 2 then
		--Wait for other player
		if Var8000[2] ~= 0 then TradeVars[2] = 1 end
		--If they cancel
		if Var8000[2] ~= 0 and OtherPlayerHasCancelled ~= 0 then
			OtherPlayerHasCancelled = 0
			ScriptLoader.Loadscript(19)
			LockFromScript = 7
			TradeVars[1] = 0
			TradeVars[2] = 0
			TradeVars[3] = 0
			
		--If other player has finished selecting
		elseif Var8000[2] ~= 0 and ((EnemyTradeVars[2] == 1 and EnemyTradeVars[1] == 2) or EnemyTradeVars[1] == 3) then
			EnemyTradeVars[6] = EnemyTradeVars[5] .. 5294967295
			WriteBuffers(Buffer1, EnemyTradeVars[6], 5)
			TradeVars[1] = 3
			TradeVars[2] = 0
			ScriptLoader.Loadscript(8)
			
		end
	elseif TradeVars[1] == 3 then
		--If you decline
		if Var8000[2] == 1 then
			SendData("ROFF", MVars.Players[MVars.PlayerTalkingID])
			ScriptLoader.Loadscript(16)
			LockFromScript = 7
			TradeVars[1] = 0
			TradeVars[2] = 0
			TradeVars[3] = 0
			
		--If you accept and they deny
		elseif Var8000[2] == 2 and OtherPlayerHasCancelled ~= 0 then
			OtherPlayerHasCancelled = 0
			ScriptLoader.Loadscript(9)
			LockFromScript = 7
			TradeVars[1] = 0
			TradeVars[2] = 0
			TradeVars[3] = 0
	
		--If you accept and there is no denial
		elseif Var8000[2] == 2 and OtherPlayerHasCancelled == 0 then
			--If other player isn't finished selecting, wait. Otherwise, go straight into trade.
			if EnemyTradeVars[1] == 4 and EnemyTradeVars[2] == 2 then
				TradeVars[1] = 5
				TradeVars[2] = 2
				local TeamPos = EnemyTradeVars[3] + 1
				PokemonTeamManager.SetEnemyPokemonTeam(TeamPos, 1)
				ScriptLoader.Loadscript(17)
			else
				ScriptLoader.Loadscript(4)
				TradeVars[1] = 4
				TradeVars[2] = 0
			end
	end
	elseif TradeVars[1] == 4 then
		--Wait for other player
		if Var8000[2] ~= 0 then TradeVars[2] = 2 end
		--If they cancel
		if Var8000[2] ~= 0 and OtherPlayerHasCancelled ~= 0 then
			OtherPlayerHasCancelled = 0
			ScriptLoader.Loadscript(19)
			LockFromScript = 7
			TradeVars[1] = 0
			TradeVars[2] = 0
			TradeVars[3] = 0
			
		--If other player has finished selecting
		elseif Var8000[2] ~= 0 and (EnemyTradeVars[2] == 2 or EnemyTradeVars[1] == 5) then
			TradeVars[2] = 2
			TradeVars[1] = 5
			local TeamPos = EnemyTradeVars[3] + 1
			PokemonTeamManager.SetEnemyPokemonTeam(TeamPos, 1)
			ScriptLoader.Loadscript(17)
		else
	--		console:log("VARS: " .. Var8000[2] .. " " .. EnemyTradeVars[2] .. " " .. EnemyTradeVars[1])
		end
	elseif TradeVars[1] == 5 then
		--Text for trade
		if Var8000[2] == 0 then
			ScriptLoader.Loadscript(23)
		--After trade
		elseif Var8000[2] ~= 0 then
			TradeVars[1] = 0
			TradeVars[2] = 0
			TradeVars[3] = 0
			TradeVars[4] = 0
			TradeVars[5] = 0
			EnemyTradeVars[1] = 0
			EnemyTradeVars[2] = 0
			EnemyTradeVars[3] = 0
			EnemyTradeVars[5] = 0
			LockFromScript = 0
		end
	end
	
	if SendTimer == 0 then CreatePackettSpecial("TRAD", MVars.Players[MVars.PlayerTalkingID]) end
end
		--	if Var8000[2] ~= 0 then
		--		ScriptLoader.Loadscript(16)
		--		SendData("CTRA", Player2)
		--		LockFromScript = 7
		--		TradeVars[1] = 0
		--		TradeVars[2] = 0
		--		TradeVars[3] = 0

function RenderPlayersOnDifferentMap()
	--if MVars.MapChange[1] ~= 0 then console:log("MAP CHANGE PLAYER 1") MVars.MapChange[1] = 0 end
	--if MVars.MapChange[2] ~= 0 then console:log("MAP CHANGE PLAYER 2") MVars.MapChange[2] = 0 end
	for i = 1, MaxPlayers do
		if PlayerID ~= i and MVars.PlayerIDNick[i] ~= "None" then
			if PVars.PlayerMapID == MVars.CurrentMapID[i] then
				MVars.PlayerVis[i] = 1
				MVars.DifferentMapX[i] = 0
				MVars.DifferentMapY[i] = 0
				MVars.MapChange[i] = 0
			elseif (PVars.PlayerMapIDPrev == MVars.CurrentMapID[i] or PVars.PlayerMapID == MVars.PreviousMapID[i]) and MVars.MapEntranceType[i] == 0 then
				MVars.PlayerVis[i] = 1
				if MVars.MapChange[i] == 1 then
					MVars.DifferentMapX[i] = ((MVars.PreviousX[i] - MVars.StartX[i]) * 16)
					MVars.DifferentMapY[i] = ((MVars.PreviousY[i] - MVars.StartY[i]) * 16)
				end
			else
				MVars.PlayerVis[i] = 0
				MVars.DifferentMapX[i] = 0
				MVars.DifferentMapY[i] = 0
				MVars.MapChange[i] = 0
			end
		end
	end
end

function GetPosition()
	local u32 BikeAddress = 0
	local u32 MapAddress = 0
	local u32 PrevMapIDAddress = 0
	local u32 ConnectionTypeAddress = 0
	local u32 PlayerXAddress = 0
	local u32 PlayerYAddress = 0
	local u32 PlayerFaceAddress = 0
	local Bike = 0
	if GameID == "BPR1" or GameID == "BPR2" then
		--Addresses for Firered
		PlayerXAddress = 33779272
		PlayerYAddress = 33779274
		PlayerFaceAddress = 33779284
		MapAddress = 33813416
		BikeAddress = 33687112
		PrevMapIDAddress = 33813418
		ConnectionTypeAddress = 33785351
		Bike = emu:read16(BikeAddress)
		if Bike > 3000 then Bike = Bike - 3352 end
	elseif GameID == "BPG1" or GameID == "BPG2" then
		--Addresses for Leafgreen
		PlayerXAddress = 33779272
		PlayerYAddress = 33779274
		PlayerFaceAddress = 33779284
		MapAddress = 33813416
		BikeAddress = 33687112
		PrevMapIDAddress = 33813418
		ConnectionTypeAddress = 33785351
		Bike = emu:read16(BikeAddress)
		if Bike > 3000 then Bike = Bike - 3320 end
	end
	PVars.PlayerFacing = emu:read8(PlayerFaceAddress)
	MVars.Facing2[PlayerID] = PVars.PlayerFacing + 100
	--Prev map
	PVars.PlayerMapIDPrev = emu:read16(PrevMapIDAddress)
	PVars.PlayerMapIDPrev = PVars.PlayerMapIDPrev + 100000
	if PVars.PlayerMapIDPrev == PVars.PlayerMapID then
		MVars.PreviousX[PlayerID] = MVars.CurrentX[PlayerID]
		MVars.PreviousY[PlayerID] = MVars.CurrentY[PlayerID]
		PVars.PlayerMapEntranceType = emu:read8(ConnectionTypeAddress)
		if PVars.PlayerMapEntranceType > 10 then PVars.PlayerMapEntranceType = 9 end
		PVars.PlayerMapChange = 1
		MVars.MapChange[PlayerID] = 1
	end
	PVars.PlayerMapID = emu:read16(MapAddress)
	PVars.PlayerMapID = PVars.PlayerMapID + 100000
	PlayerMapX = emu:read16(PlayerXAddress)
	PlayerMapY = emu:read16(PlayerYAddress)
	PlayerMapX = PlayerMapX + 2000
	PlayerMapY = PlayerMapY + 2000
		
	MVars.CurrentX[PlayerID] = PlayerMapX
	MVars.CurrentY[PlayerID] = PlayerMapY
--	console:log("X: " .. MVars.CurrentX[PlayerID])
	--Male Firered Sprite from 1.0, 1.1, and leafgreen
	if ((Bike == 160 or Bike == 272) or (Bike == 128 or Bike == 240)) then
		MVars.PlayerExtra2[PlayerID] = 0
		MVars.PlayerExtra3[PlayerID] = 0
	--	if TempVar2 == 0 then ConsoleForText:print("Male on Foot") end
	--Male Firered Biking Sprite
	elseif (Bike == 320 or Bike == 432 or Bike == 288 or Bike == 400) then
		MVars.PlayerExtra2[PlayerID] = 0
		MVars.PlayerExtra3[PlayerID] = 1
	--	if TempVar2 == 0 then ConsoleForText:print("Male on Bike") end
	--Male Firered Surfing Sprite
	elseif (Bike == 624 or Bike == 736 or Bike == 592 or Bike == 704) then
		MVars.PlayerExtra2[PlayerID] = 0
		MVars.PlayerExtra3[PlayerID] = 2
	--Female sprite
	elseif ((Bike == 392 or Bike == 504) or (Bike == 360 or Bike == 472)) then
		MVars.PlayerExtra2[PlayerID] = 1
		MVars.PlayerExtra3[PlayerID] = 0
	--	if TempVar2 == 0 then ConsoleForText:print("Female on Foot") end
	--Female Biking sprite
	elseif ((Bike == 552 or Bike == 664) or (Bike == 520 or Bike == 632)) then
		MVars.PlayerExtra2[PlayerID] = 1
		MVars.PlayerExtra3[PlayerID] = 1
	--	if TempVar2 == 0 then ConsoleForText:print("Female on Bike") end
	--Female Firered Surfing Sprite
	elseif (Bike == 720 or Bike == 832 or Bike == 688 or Bike == 800) then
		MVars.PlayerExtra2[PlayerID] = 1
		MVars.PlayerExtra3[PlayerID] = 2
	else
	--If in bag when connecting will automatically be firered male
	--	if TempVar2 == 0 then ConsoleForText:print("Bag/Unknown") end
	end
	if MVars.PlayerExtra1[PlayerID] ~= 0 then MVars.PlayerExtra1[PlayerID] = MVars.PlayerExtra1[PlayerID] - 100
	else MVars.PlayerExtra1[PlayerID] = 0
	end
	if MVars.PlayerExtra3[PlayerID] == 2 then
		PVars.PreviousPlayerDirection = PVars.PlayerDirection
		--Facing
		if PVars.PlayerFacing == 0 then MVars.PlayerExtra1[PlayerID] = 33 PVars.PlayerDirection = 4 end
		if PVars.PlayerFacing == 1 then MVars.PlayerExtra1[PlayerID] = 34 PVars.PlayerDirection = 3 end
		if PVars.PlayerFacing == 2 then MVars.PlayerExtra1[PlayerID] = 35 PVars.PlayerDirection = 1 end
		if PVars.PlayerFacing == 3 then MVars.PlayerExtra1[PlayerID] = 36 PVars.PlayerDirection = 2 end
		--Surfing
		if PVars.PlayerFacing == 29 then MVars.PlayerExtra1[PlayerID] = 37 PVars.PlayerDirection = 4 end
		if PVars.PlayerFacing == 30 then MVars.PlayerExtra1[PlayerID] = 38 PVars.PlayerDirection = 3 end
		if PVars.PlayerFacing == 31 then MVars.PlayerExtra1[PlayerID] = 39 PVars.PlayerDirection = 1 end
		if PVars.PlayerFacing == 32 then MVars.PlayerExtra1[PlayerID] = 40 PVars.PlayerDirection = 2 end
		--Turning
		if PVars.PlayerFacing == 41 then MVars.PlayerExtra1[PlayerID] = 33 PVars.PlayerDirection = 4 end
		if PVars.PlayerFacing == 42 then MVars.PlayerExtra1[PlayerID] = 34 PVars.PlayerDirection = 3 end
		if PVars.PlayerFacing == 43 then MVars.PlayerExtra1[PlayerID] = 35 PVars.PlayerDirection = 1 end
		if PVars.PlayerFacing == 44 then MVars.PlayerExtra1[PlayerID] = 36 PVars.PlayerDirection = 2 end
		--hitting a wall
		if PVars.PlayerFacing == 33 then MVars.PlayerExtra1[PlayerID] = 33 PVars.PlayerDirection = 4 end
		if PVars.PlayerFacing == 34 then MVars.PlayerExtra1[PlayerID] = 34 PVars.PlayerDirection = 3 end
		if PVars.PlayerFacing == 35 then MVars.PlayerExtra1[PlayerID] = 35 PVars.PlayerDirection = 1 end
		if PVars.PlayerFacing == 36 then MVars.PlayerExtra1[PlayerID] = 36 PVars.PlayerDirection = 2 end
		--getting on pokemon
		if PVars.PlayerFacing == 70 then MVars.PlayerExtra1[PlayerID] = 37 PVars.PlayerDirection = 4 end
		if PVars.PlayerFacing == 71 then MVars.PlayerExtra1[PlayerID] = 38 PVars.PlayerDirection = 3 end
		if PVars.PlayerFacing == 72 then MVars.PlayerExtra1[PlayerID] = 39 PVars.PlayerDirection = 1 end
		if PVars.PlayerFacing == 73 then MVars.PlayerExtra1[PlayerID] = 40 PVars.PlayerDirection = 2 end
		--getting off pokemon
		if PVars.PlayerFacing == 166 then MVars.PlayerExtra1[PlayerID] = 5 PVars.PlayerDirection = 4 end
		if PVars.PlayerFacing == 167 then MVars.PlayerExtra1[PlayerID] = 6 PVars.PlayerDirection = 3 end
		if PVars.PlayerFacing == 168 then MVars.PlayerExtra1[PlayerID] = 7 PVars.PlayerDirection = 1 end
		if PVars.PlayerFacing == 169 then MVars.PlayerExtra1[PlayerID] = 8 PVars.PlayerDirection = 2 end
		--calling pokemon out
		if PVars.PlayerFacing == 69 then MVars.PlayerExtra1[PlayerID] = 33 PVars.PlayerDirection = 4 end
		
		if ScreenData == 0 then
			if PVars.PlayerDirection == 4 then MVars.PlayerExtra1[PlayerID] = 33 PVars.PlayerFacing = 0 end
			if PVars.PlayerDirection == 3 then MVars.PlayerExtra1[PlayerID] = 34 PVars.PlayerFacing = 1 end
			if PVars.PlayerDirection == 1 then MVars.PlayerExtra1[PlayerID] = 35 PVars.PlayerFacing = 2 end
			if PVars.PlayerDirection == 2 then MVars.PlayerExtra1[PlayerID] = 36 PVars.PlayerFacing = 3 end
		end
	elseif MVars.PlayerExtra3[PlayerID] == 1 then
		if PVars.PlayerFacing == 0 then MVars.PlayerExtra1[PlayerID] = 17 PVars.PlayerDirection = 4 end
		if PVars.PlayerFacing == 1 then MVars.PlayerExtra1[PlayerID] = 18 PVars.PlayerDirection = 3 end
		if PVars.PlayerFacing == 2 then MVars.PlayerExtra1[PlayerID] = 19 PVars.PlayerDirection = 1 end
		if PVars.PlayerFacing == 3 then MVars.PlayerExtra1[PlayerID] = 20 PVars.PlayerDirection = 2 end
		--Standard speed
		if PVars.PlayerFacing == 49 then MVars.PlayerExtra1[PlayerID] = 21 PVars.PlayerDirection = 4 end
		if PVars.PlayerFacing == 50 then MVars.PlayerExtra1[PlayerID] = 22 PVars.PlayerDirection = 3 end
		if PVars.PlayerFacing == 51 then MVars.PlayerExtra1[PlayerID] = 23 PVars.PlayerDirection = 1 end
		if PVars.PlayerFacing == 52 then MVars.PlayerExtra1[PlayerID] = 24 PVars.PlayerDirection = 2 end
		--In case you use a fast bike
		if PVars.PlayerFacing == 61 then MVars.PlayerExtra1[PlayerID] = 25 PVars.PlayerDirection = 4 end
		if PVars.PlayerFacing == 62 then MVars.PlayerExtra1[PlayerID] = 26 PVars.PlayerDirection = 3 end
		if PVars.PlayerFacing == 63 then MVars.PlayerExtra1[PlayerID] = 27 PVars.PlayerDirection = 1 end
		if PVars.PlayerFacing == 64 then MVars.PlayerExtra1[PlayerID] = 28 PVars.PlayerDirection = 2 end
		--hitting a wall
		if PVars.PlayerFacing == 37 then MVars.PlayerExtra1[PlayerID] = 29 PVars.PlayerDirection = 4 end
		if PVars.PlayerFacing == 38 then MVars.PlayerExtra1[PlayerID] = 30 PVars.PlayerDirection = 3 end
		if PVars.PlayerFacing == 39 then MVars.PlayerExtra1[PlayerID] = 31 PVars.PlayerDirection = 1 end
		if PVars.PlayerFacing == 40 then MVars.PlayerExtra1[PlayerID] = 32 PVars.PlayerDirection = 2 end
		
		--calling pokemon out
		if PVars.PlayerFacing == 69 then MVars.PlayerExtra1[PlayerID] = 1 PVars.PlayerDirection = 4 end
		
		if ScreenData == 0 then
			if PVars.PlayerDirection == 4 then MVars.PlayerExtra1[PlayerID] = 17 PVars.PlayerFacing = 0 end
			if PVars.PlayerDirection == 3 then MVars.PlayerExtra1[PlayerID] = 18 PVars.PlayerFacing = 1 end
			if PVars.PlayerDirection == 1 then MVars.PlayerExtra1[PlayerID] = 19 PVars.PlayerFacing = 2 end
			if PVars.PlayerDirection == 2 then MVars.PlayerExtra1[PlayerID] = 20 PVars.PlayerFacing = 3 end
		end
	else
		--Standing still
		if PVars.PlayerFacing == 0 then MVars.PlayerExtra1[PlayerID] = 1 PVars.PlayerDirection = 4 end
		if PVars.PlayerFacing == 1 then MVars.PlayerExtra1[PlayerID] = 2 PVars.PlayerDirection = 3 end
		if PVars.PlayerFacing == 2 then MVars.PlayerExtra1[PlayerID] = 3 PVars.PlayerDirection = 1 end
		if PVars.PlayerFacing == 3 then MVars.PlayerExtra1[PlayerID] = 4 PVars.PlayerDirection = 2 end
		
		--Hitting stuff
		if PVars.PlayerFacing == 33 then MVars.PlayerExtra1[PlayerID] = 1 PVars.PlayerDirection = 4 end
		if PVars.PlayerFacing == 34 then MVars.PlayerExtra1[PlayerID] = 2 PVars.PlayerDirection = 3 end
		if PVars.PlayerFacing == 35 then MVars.PlayerExtra1[PlayerID] = 3 PVars.PlayerDirection = 1 end
		if PVars.PlayerFacing == 36 then MVars.PlayerExtra1[PlayerID] = 4 PVars.PlayerDirection = 2 end
		
		if PVars.PlayerFacing == 37 then MVars.PlayerExtra1[PlayerID] = 1 PVars.PlayerDirection = 4 end
		if PVars.PlayerFacing == 38 then MVars.PlayerExtra1[PlayerID] = 2 PVars.PlayerDirection = 3 end
		if PVars.PlayerFacing == 39 then MVars.PlayerExtra1[PlayerID] = 3 PVars.PlayerDirection = 1 end
		if PVars.PlayerFacing == 40 then MVars.PlayerExtra1[PlayerID] = 4 PVars.PlayerDirection = 2 end
		
		--Walking
		if PVars.PlayerFacing == 16 then MVars.PlayerExtra1[PlayerID] = 5 PVars.PlayerDirection = 4 end
		if PVars.PlayerFacing == 17 then MVars.PlayerExtra1[PlayerID] = 6 PVars.PlayerDirection = 3 end
		if PVars.PlayerFacing == 18 then MVars.PlayerExtra1[PlayerID] = 7 PVars.PlayerDirection = 1 end
		if PVars.PlayerFacing == 19 then MVars.PlayerExtra1[PlayerID] = 8 PVars.PlayerDirection = 2 end
		
		--Jumping over route
		if PVars.PlayerFacing == 20 then MVars.PlayerExtra1[PlayerID] = 13 PVars.PlayerDirection = 4 end
		if PVars.PlayerFacing == 21 then MVars.PlayerExtra1[PlayerID] = 14 PVars.PlayerDirection = 3 end
		if PVars.PlayerFacing == 22 then MVars.PlayerExtra1[PlayerID] = 15 PVars.PlayerDirection = 1 end
		if PVars.PlayerFacing == 23 then MVars.PlayerExtra1[PlayerID] = 16 PVars.PlayerDirection = 2 end
		--Turning
		if PVars.PlayerFacing == 41 then MVars.PlayerExtra1[PlayerID] = 9 PVars.PlayerDirection = 4 end
		if PVars.PlayerFacing == 42 then MVars.PlayerExtra1[PlayerID] = 10 PVars.PlayerDirection = 3 end
		if PVars.PlayerFacing == 43 then MVars.PlayerExtra1[PlayerID] = 11 PVars.PlayerDirection = 1 end
		if PVars.PlayerFacing == 44 then MVars.PlayerExtra1[PlayerID] = 12 PVars.PlayerDirection = 2 end
		--Running
		if PVars.PlayerFacing == 61 then MVars.PlayerExtra1[PlayerID] = 13 PVars.PlayerDirection = 4 end
		if PVars.PlayerFacing == 62 then MVars.PlayerExtra1[PlayerID] = 14 PVars.PlayerDirection = 3 end
		if PVars.PlayerFacing == 63 then MVars.PlayerExtra1[PlayerID] = 15 PVars.PlayerDirection = 1 end
		if PVars.PlayerFacing == 64 then MVars.PlayerExtra1[PlayerID] = 16 PVars.PlayerDirection = 2 end
		
		--calling pokemon out
		if PVars.PlayerFacing == 69 then MVars.PlayerExtra1[PlayerID] = 1 PVars.PlayerDirection = 4 end
		
		if ScreenData == 0 then
			if PVars.PlayerDirection == 4 then MVars.PlayerExtra1[PlayerID] = 1 PVars.PlayerFacing = 0 end
			if PVars.PlayerDirection == 3 then MVars.PlayerExtra1[PlayerID] = 2 PVars.PlayerFacing = 1 end
			if PVars.PlayerDirection == 1 then MVars.PlayerExtra1[PlayerID] = 3 PVars.PlayerFacing = 2 end
			if PVars.PlayerDirection == 2 then MVars.PlayerExtra1[PlayerID] = 4 PVars.PlayerFacing = 3 end
		end
		--	if Facing == 255 then MVars.PlayerExtra1 = 0 end
	end
	MVars.PlayerExtra1[PlayerID] = MVars.PlayerExtra1[PlayerID] + 100
	MVars.CurrentFacingDirection[PlayerID] = PVars.PlayerDirection
end

function NoPlayersIfScreen()
	local ScreenData1 = 0
	local ScreenData3 = 0
	local ScreenData4 = 0
	local u32 ScreenDataAddress1 = 0
	local u32 ScreenDataAddress3 = 0
	local u32 ScreenDataAddress4 = 0
	if GameID == "BPR1" or GameID == "BPR2" then
		--Address for Firered
		ScreenDataAddress1 = 33691280
		--For intro
		ScreenDataAddress3 = 33686716
		--Check for battle
		ScreenDataAddress4 = 33685514
	elseif GameID == "BPG1" or GameID == "BPG2" then
		--Address for Leafgreen
		ScreenDataAddress1 = 33691280
		--For intro
		ScreenDataAddress3 = 33686716
		--Check for battle
		ScreenDataAddress4 = 33685514
	end
		ScreenData1 = emu:read32(ScreenDataAddress1)
		ScreenData3 = emu:read8(ScreenDataAddress3)
		ScreenData4 = emu:read8(ScreenDataAddress4)
		
	--	if TempVar2 == 0 then ConsoleForText:print("ScreenData: " .. ScreenData1 .. " " .. ScreenData2 .. " " .. ScreenData3) end
		--If screen data are these then hide players
		if (ScreenData3 ~= 80 or (ScreenData1 > 0)) and (LockFromScript == 0 or LockFromScript == 8 or LockFromScript == 9) then
			ScreenData = 0
		--	console:log("SCREENDATA OFF: " .. LockFromScript)
		else
			ScreenData = 1
		--	console:log("SCREENDATA ON")
		end
		if ScreenData4 == 1 then
			MVars.PlayerExtra4[PlayerID] = 1
		else
			MVars.PlayerExtra4[PlayerID] = 0
		end
end



function AnimatePlayerMovement(PlayerNo, AnimateID)
	--This is for updating the previous coords with new ones, without looking janky
	--AnimateID List
	--0 = Standing Still
	--1 = Walking Down
	--2 = Walking Up
	--3 = Walking Left/Right
	--4 = Running Down
	--5 = Running Up
	--6 = Running Left/Right
	--7 = Bike Down
	--8 = Bike Up
	--9 = Bike left/right
	--10 = Face down
	--11 = Face up
	--12 = Face left/right
	
if MVars.CurrentX[PlayerNo] == 0 then MVars.CurrentX[PlayerNo] = MVars.FutureX[PlayerNo] end
if MVars.CurrentY[PlayerNo] == 0 then MVars.CurrentY[PlayerNo] = MVars.FutureY[PlayerNo] end
local AnimationMovementX = MVars.FutureX[PlayerNo] - MVars.CurrentX[PlayerNo]
local AnimationMovementY = MVars.FutureY[PlayerNo] - MVars.CurrentY[PlayerNo]
local Charpic = PlayerNo - 1
local SpriteNumber = MVars.PlayerExtra2[PlayerNo]
		
if PlayerAnimationFrame[PlayerNo] < 0 then PlayerAnimationFrame[PlayerNo] = 0 end
PlayerAnimationFrame[PlayerNo] = PlayerAnimationFrame[PlayerNo] + 1

--Animate left movement
if AnimationMovementX < 0 then

		--Walk
	if AnimateID == 3 then
		PlayerAnimationFrameMax[PlayerNo] = 14
		MVars.AnimationX[PlayerNo] = MVars.AnimationX[PlayerNo] - 1
		if PlayerAnimationFrame[PlayerNo] == 5 then MVars.AnimationX[PlayerNo] = MVars.AnimationX[PlayerNo] - 1 end
		if PlayerAnimationFrame[PlayerNo] == 9 then MVars.AnimationX[PlayerNo] = MVars.AnimationX[PlayerNo] - 1 end
		if PlayerAnimationFrame[PlayerNo] >= 3 and PlayerAnimationFrame[PlayerNo] <= 11 then
			if PlayerAnimationFrame2[PlayerNo] == 0 then
				SpriteGenerator.createChars(Charpic, "walkL1", SpriteNumber, ScreenData)
			else
				SpriteGenerator.createChars(Charpic, "walkL2", SpriteNumber, ScreenData)
			end
		else
			SpriteGenerator.createChars(Charpic, "sideLR", SpriteNumber, ScreenData)
		end
	--Run
	elseif AnimateID == 6 then
		PlayerAnimationFrameMax[PlayerNo] = 9
		MVars.AnimationX[PlayerNo] = MVars.AnimationX[PlayerNo] - 4
	--	ConsoleForText:print("Frame: " .. PlayerAnimationFrame)
		if PlayerAnimationFrame[PlayerNo] > 5 then
			if PlayerAnimationFrame2[PlayerNo] == 0 then
				SpriteGenerator.createChars(Charpic,"runSideLCicle1",SpriteNumber, ScreenData)
			else
				SpriteGenerator.createChars(Charpic,"runSideLCicle2",SpriteNumber, ScreenData)
			end
		else
			SpriteGenerator.createChars(Charpic,"runSideLIdle",SpriteNumber, ScreenData)
		end
	--Bike
	elseif AnimateID == 9 then
		PlayerAnimationFrameMax[PlayerNo] = 6
		MVars.AnimationX[PlayerNo] = MVars.AnimationX[PlayerNo] + ((AnimationMovementX*16)/3)
		if PlayerAnimationFrame[PlayerNo] >= 1 and PlayerAnimationFrame[PlayerNo] < 5 then
			if PlayerAnimationFrame2[PlayerNo] == 0 then
				SpriteGenerator.createChars(Charpic,"cicleBikeL1",SpriteNumber,ScreenData)
			else
				SpriteGenerator.createChars(Charpic,"cicleBikeL2",SpriteNumber,ScreenData)
			end
		else
			SpriteGenerator.createChars(Charpic,"sideBikeL",SpriteNumber,ScreenData)
		end
	--Surf
	elseif AnimateID == 23 then
		PlayerAnimationFrameMax[PlayerNo] = 4
		MVars.AnimationX[PlayerNo] = MVars.AnimationX[PlayerNo] - 4
		SpriteGenerator.createChars(Charpic,"surfSideLIdle1",SpriteNumber,ScreenData)
		SpriteGenerator.createChars(Charpic,"surfSitSide",SpriteNumber,ScreenData)
	else
	
	end
	
	--Animate right movement
	elseif AnimationMovementX > 0 then
	if AnimateID == 13 then
		PlayerAnimationFrameMax[PlayerNo] = 14
		MVars.AnimationX[PlayerNo] = MVars.AnimationX[PlayerNo] + 1
		if PlayerAnimationFrame[PlayerNo] == 5 then MVars.AnimationX[PlayerNo] = MVars.AnimationX[PlayerNo] + 1 end
		if PlayerAnimationFrame[PlayerNo] == 9 then MVars.AnimationX[PlayerNo] = MVars.AnimationX[PlayerNo] + 1 end
		if PlayerAnimationFrame[PlayerNo] >= 3 and PlayerAnimationFrame[PlayerNo] <= 11 then
			if PlayerAnimationFrame2[PlayerNo] == 0 then
				SpriteGenerator.createChars(Charpic,"walkL1",SpriteNumber,ScreenData)
			else
				SpriteGenerator.createChars(Charpic,"walkL2",SpriteNumber,ScreenData)
			end
		else
			SpriteGenerator.createChars(Charpic,"sideLR",SpriteNumber,ScreenData)
		end
	elseif AnimateID == 14 then
	--	console:log("RUNNING RIGHT. FRAME: " .. PlayerAnimationFrame .. " FRAME2: " .. PlayerAnimationFrame2)
	--	ConsoleForText:print("Running")
		PlayerAnimationFrameMax[PlayerNo] = 9
		MVars.AnimationX[PlayerNo] = MVars.AnimationX[PlayerNo] + 4
		if PlayerAnimationFrame[PlayerNo] > 5 then
			if PlayerAnimationFrame2[PlayerNo] == 0 then
				SpriteGenerator.createChars(Charpic,"runSideLCicle1",SpriteNumber, ScreenData)
			else
				SpriteGenerator.createChars(Charpic,"runSideLCicle2",SpriteNumber, ScreenData)
			end
		else
			SpriteGenerator.createChars(Charpic,"runSideLIdle",SpriteNumber, ScreenData)
		end
	elseif AnimateID == 15 then
	--	ConsoleForText:print("Bike")
		PlayerAnimationFrameMax[PlayerNo] = 6
		MVars.AnimationX[PlayerNo] = MVars.AnimationX[PlayerNo] + ((AnimationMovementX*16)/3)
		if PlayerAnimationFrame[PlayerNo] >= 1 and PlayerAnimationFrame[PlayerNo] < 5 then
			if PlayerAnimationFrame2[PlayerNo] == 0 then
				SpriteGenerator.createChars(Charpic,"cicleBikeL1",SpriteNumber,ScreenData)
			else
				SpriteGenerator.createChars(Charpic,"cicleBikeL2",SpriteNumber,ScreenData)
			end
		else
			SpriteGenerator.createChars(Charpic,"sideBikeL",SpriteNumber,ScreenData)
		end
	--Surf
	elseif AnimateID == 24 then
		PlayerAnimationFrameMax[PlayerNo] = 4
		MVars.AnimationX[PlayerNo] = MVars.AnimationX[PlayerNo] + 4
		SpriteGenerator.createChars(Charpic,"surfSideLIdle1",SpriteNumber,ScreenData)
		SpriteGenerator.createChars(Charpic,"surfSitSide",SpriteNumber,ScreenData)
	else
	
	end
	else
	MVars.AnimationX[PlayerNo] = 0
	MVars.CurrentX[PlayerNo] = MVars.FutureX[PlayerNo]
	--Turn player left/right
	if AnimateID == 12 then
		PlayerAnimationFrameMax[PlayerNo] = 8
		if PlayerAnimationFrame[PlayerNo] > 1 and PlayerAnimationFrame[PlayerNo] < 6 then
			if PlayerAnimationFrame2[PlayerNo] == 0 then
				SpriteGenerator.createChars(Charpic,"walkL1",SpriteNumber,ScreenData)
			else
				SpriteGenerator.createChars(Charpic,"walkL2",SpriteNumber,ScreenData)
			end
		else
			SpriteGenerator.createChars(Charpic,"sideLR",SpriteNumber,ScreenData)
		end
	--If they are now equal
	end
	--Surfing animation
	if AnimateID == 19 or AnimateID == 20 then
		SpriteGenerator.createChars(Charpic,"surfSitSide",SpriteNumber,ScreenData)
		if PreviousPlayerAnimation[PlayerNo] ~= 19 and PreviousPlayerAnimation[PlayerNo] ~= 20 then
			 PlayerAnimationFrame2[PlayerNo] = 0 PlayerAnimationFrame[PlayerNo] = 24 
		end
		PlayerAnimationFrameMax[PlayerNo] = 48
		if PlayerAnimationFrame2[PlayerNo] == 0 then 
			SpriteGenerator.createChars(Charpic,"surfSideLIdle1",SpriteNumber,ScreenData)
		elseif PlayerAnimationFrame2[PlayerNo] == 1 then 
			SpriteGenerator.createChars(Charpic,"surfSitSide",SpriteNumber,ScreenData)
		end
	end
	
	
	--Animate up movement
	if AnimationMovementY < 0 then
	if AnimateID == 2 then
		PlayerAnimationFrameMax[PlayerNo] = 14
		MVars.AnimationY[PlayerNo] = MVars.AnimationY[PlayerNo] - 1
		if PlayerAnimationFrame[PlayerNo] == 5 then MVars.AnimationY[PlayerNo] = MVars.AnimationY[PlayerNo] - 1 end
		if PlayerAnimationFrame[PlayerNo] == 9 then MVars.AnimationY[PlayerNo] = MVars.AnimationY[PlayerNo] - 1 end
		if PlayerAnimationFrame[PlayerNo] >= 3 and PlayerAnimationFrame[PlayerNo] <= 11 then
			if PlayerAnimationFrame2[PlayerNo] == 0 then
				SpriteGenerator.createChars(Charpic,"walkUp1",SpriteNumber,ScreenData)
			else
				SpriteGenerator.createChars(Charpic,"walkUp2",SpriteNumber,ScreenData)
			end	
		else
			SpriteGenerator.createChars(Charpic,"sideUp",SpriteNumber,ScreenData)
		end
	elseif AnimateID == 5 then
		PlayerAnimationFrameMax[PlayerNo] = 9
		MVars.AnimationY[PlayerNo] = MVars.AnimationY[PlayerNo] - 4
		if PlayerAnimationFrame[PlayerNo] > 5 then
			if PlayerAnimationFrame2[PlayerNo] == 0 then
				SpriteGenerator.createChars(Charpic,"runSideUpCicle1",SpriteNumber,ScreenData)
			else
				SpriteGenerator.createChars(Charpic,"runSideUpCicle2",SpriteNumber,ScreenData)
			end
		else
			SpriteGenerator.createChars(Charpic,"runSideUpIdle",SpriteNumber,ScreenData)
		end
	elseif AnimateID == 8 then
		PlayerAnimationFrameMax[PlayerNo] = 6
		MVars.AnimationY[PlayerNo] = MVars.AnimationY[PlayerNo] + ((AnimationMovementY*16)/3)
		if PlayerAnimationFrame[PlayerNo] >= 1 and PlayerAnimationFrame[PlayerNo] < 5 then
			if PlayerAnimationFrame2[PlayerNo] == 0 then
				SpriteGenerator.createChars(Charpic,"cicleBikeUp1",SpriteNumber,ScreenData)
			else
				SpriteGenerator.createChars(Charpic,"cicleBikeUp2",SpriteNumber,ScreenData)
			end
		else
			SpriteGenerator.createChars(Charpic,"sideBikeUp",SpriteNumber,ScreenData)
		end
	--Surf
	elseif AnimateID == 22 then
		PlayerAnimationFrameMax[PlayerNo] = 4
		MVars.AnimationY[PlayerNo] = MVars.AnimationY[PlayerNo] - 4
		SpriteGenerator.createChars(Charpic,"surfSideUpIdle",SpriteNumber,ScreenData)
		SpriteGenerator.createChars(Charpic,"surfSitUp",SpriteNumber,ScreenData)
	end
		
	--Animate down movement
	elseif AnimationMovementY > 0 then
	if AnimateID == 1 then
		PlayerAnimationFrameMax[PlayerNo] = 14
		MVars.AnimationY[PlayerNo] = MVars.AnimationY[PlayerNo] + 1
		if PlayerAnimationFrame[PlayerNo] == 5 then MVars.AnimationY[PlayerNo] = MVars.AnimationY[PlayerNo] + 1 end
		if PlayerAnimationFrame[PlayerNo] == 9 then MVars.AnimationY[PlayerNo] = MVars.AnimationY[PlayerNo] + 1 end
		if PlayerAnimationFrame[PlayerNo] >= 3 and PlayerAnimationFrame[PlayerNo] <= 11 then
			if PlayerAnimationFrame2[PlayerNo] == 0 then
				SpriteGenerator.createChars(Charpic,"walkDown1",SpriteNumber,ScreenData)
			else
				SpriteGenerator.createChars(Charpic,"walkDown2",SpriteNumber,ScreenData)
			end
		else
			SpriteGenerator.createChars(Charpic,"sideDown",SpriteNumber,ScreenData)
		end
	elseif AnimateID == 4 then
		PlayerAnimationFrameMax[PlayerNo] = 9
		MVars.AnimationY[PlayerNo] = MVars.AnimationY[PlayerNo] + 4
		if PlayerAnimationFrame[PlayerNo] > 5 then
			if PlayerAnimationFrame2[PlayerNo] == 0 then
				SpriteGenerator.createChars(Charpic,"runSideDownCicle1",SpriteNumber,ScreenData)
			else
				SpriteGenerator.createChars(Charpic,"runSideDownCicle1",SpriteNumber,ScreenData)
			end
		else
			SpriteGenerator.createChars(Charpic,"runSideDownIdle",SpriteNumber,ScreenData)
		end
	elseif AnimateID == 7 then
		PlayerAnimationFrameMax[PlayerNo] = 6
		MVars.AnimationY[PlayerNo] = MVars.AnimationY[PlayerNo] + ((AnimationMovementY*16)/3)
		if PlayerAnimationFrame[PlayerNo] >= 1 and PlayerAnimationFrame[PlayerNo] < 5 then
			if PlayerAnimationFrame2[PlayerNo] == 0 then
				SpriteGenerator.createChars(Charpic,"cicleBikeDown1",SpriteNumber,ScreenData)
			else
				SpriteGenerator.createChars(Charpic,"cicleBikeDown2",SpriteNumber,ScreenData)
			end
		else
			SpriteGenerator.createChars(Charpic,"sideBikeDown",SpriteNumber,ScreenData)
		end
	--Surf
	elseif AnimateID == 21 then
		PlayerAnimationFrameMax[PlayerNo] = 4
		MVars.AnimationY[PlayerNo] = MVars.AnimationY[PlayerNo] + 4
		SpriteGenerator.createChars(Charpic,"surfSideDownIdle",SpriteNumber,ScreenData)
		SpriteGenerator.createChars(Charpic,"surfSitDown",SpriteNumber,ScreenData)
	--If they are now equal
	end
	else
	MVars.AnimationY[PlayerNo] = 0
	MVars.CurrentY[PlayerNo] = MVars.FutureY[PlayerNo]
	--Turn player down
	if AnimateID == 10 then
		PlayerAnimationFrameMax[PlayerNo] = 8
		if PlayerAnimationFrame[PlayerNo] > 1 and PlayerAnimationFrame[PlayerNo] < 6 then
			if PlayerAnimationFrame2[PlayerNo] == 0 then
				SpriteGenerator.createChars(Charpic,"walkDown1",SpriteNumber,ScreenData)
			else
				SpriteGenerator.createChars(Charpic,"walkDown2",SpriteNumber,ScreenData)
			end
		else
			SpriteGenerator.createChars(Charpic,"sideDown",SpriteNumber,ScreenData)
		end
	--Turn player up
	
	elseif AnimateID == 11 then
		PlayerAnimationFrameMax[PlayerNo] = 8
		if PlayerAnimationFrame[PlayerNo] > 1 and PlayerAnimationFrame[PlayerNo] < 6 then
			if PlayerAnimationFrame2[PlayerNo] == 0 then
				SpriteGenerator.createChars(Charpic,"walkUp1",SpriteNumber,ScreenData)
			else
				SpriteGenerator.createChars(Charpic,"walkUp2",SpriteNumber,ScreenData)
			end
		else
			SpriteGenerator.createChars(Charpic,"sideUp",SpriteNumber,ScreenData)
		end
	else
	--		SpriteGenerator.createChars(Charpic,3,SpriteNumber,ScreenData)
	end
	
	--Surfing animation
	if AnimateID == 17 then
		SpriteGenerator.createChars(Charpic,"surfSitDown",SpriteNumber,ScreenData)
		if PreviousPlayerAnimation[PlayerNo] ~= 17 then
			PlayerAnimationFrame2[PlayerNo] = 0
			PlayerAnimationFrame[PlayerNo] = 24
		end
		PlayerAnimationFrameMax[PlayerNo] = 48
		if PlayerAnimationFrame2[PlayerNo] == 0 then
			SpriteGenerator.createChars(Charpic,"surfSideDownIdle",SpriteNumber,ScreenData)
		elseif PlayerAnimationFrame2[PlayerNo] == 1 then
			SpriteGenerator.createChars(Charpic,"surfSideDownIdle2",SpriteNumber,ScreenData)
		end
	elseif AnimateID == 18 then
		SpriteGenerator.createChars(Charpic,"surfSitUp",SpriteNumber,ScreenData)
		if PreviousPlayerAnimation[PlayerNo] ~= 18 then
			PlayerAnimationFrame2[PlayerNo] = 0
			PlayerAnimationFrame[PlayerNo] = 24
		end
		PlayerAnimationFrameMax[PlayerNo] = 48
		if PlayerAnimationFrame2[PlayerNo] == 0 then
			SpriteGenerator.createChars(Charpic,"surfSideUpIdle",SpriteNumber,ScreenData)
		elseif PlayerAnimationFrame2[PlayerNo] == 1 then
			SpriteGenerator.createChars(Charpic,"surfSideDownIdle2",SpriteNumber,ScreenData)
		end
	--If they are now equal
	end
end
end
		
	if AnimateID == 251 then
		PlayerAnimationFrame[PlayerNo] = 0
		MVars.AnimationX[PlayerNo] = 0
		MVars.AnimationY[PlayerNo] = 0
		MVars.CurrentX[PlayerNo] = MVars.FutureX[PlayerNo]
		MVars.CurrentY[PlayerNo] = MVars.FutureY[PlayerNo]
	elseif AnimateID == 252 then
		PlayerAnimationFrame[PlayerNo] = 0
		MVars.AnimationX[PlayerNo] = 0
		MVars.AnimationY[PlayerNo] = 0
		MVars.CurrentX[PlayerNo] = MVars.FutureX[PlayerNo]
		MVars.CurrentY[PlayerNo] = MVars.FutureY[PlayerNo]
	elseif AnimateID == 253 then
		PlayerAnimationFrame[PlayerNo] = 0
		MVars.AnimationX[PlayerNo] = 0
		MVars.AnimationY[PlayerNo] = 0
		MVars.CurrentX[PlayerNo] = MVars.FutureX[PlayerNo]
		MVars.CurrentY[PlayerNo] = MVars.FutureY[PlayerNo]
	elseif AnimateID == 254 then
		PlayerAnimationFrame[PlayerNo] = 0
		MVars.AnimationX[PlayerNo] = 0
		MVars.AnimationY[PlayerNo] = 0
		MVars.CurrentX[PlayerNo] = MVars.FutureX[PlayerNo]
		MVars.CurrentY[PlayerNo] = MVars.FutureY[PlayerNo]
	elseif AnimateID == 255 then
		MVars.CurrentX[PlayerNo] = MVars.FutureX[PlayerNo]
		MVars.CurrentY[PlayerNo] = MVars.FutureY[PlayerNo]
	end
		
	if PlayerAnimationFrameMax[PlayerNo] <= PlayerAnimationFrame[PlayerNo] then
		PlayerAnimationFrame[PlayerNo] = 0
		if PlayerAnimationFrame2[PlayerNo] == 0 then
			PlayerAnimationFrame2[PlayerNo] = 1
		else
			PlayerAnimationFrame2[PlayerNo] = 0
		end
	end
	if MVars.AnimationX[PlayerNo] > 15 or MVars.AnimationX[PlayerNo] < -15 then
		MVars.CurrentX[PlayerNo] = MVars.FutureX[PlayerNo]
		MVars.AnimationX[PlayerNo] = 0
	end
	if MVars.AnimationY[PlayerNo] > 15 or MVars.AnimationY[PlayerNo] < -15 then
		MVars.CurrentY[PlayerNo] = MVars.FutureY[PlayerNo]
		MVars.AnimationY[PlayerNo] = 0
	end
	PreviousPlayerAnimation[PlayerNo] = AnimateID
end



function HandleSprites()
	--Because handling images every time would become a hassle, this will automatically set the image of every player
	
	
	--PlayerExtra 1 = Down Face
	--PlayerExtra 2 = Up Face
	--PlayerExtra 3 or 4 = Left/Right Face
	--PlayerExtra 5 = Down Walk
	--PlayerExtra 6 = Up Walk
	--PlayerExtra 7 or 8 = Left/Right Walk
	--PlayerExtra 9 = Down Turn
	--PlayerExtra 10 = Up Turn
	--PlayerExtra 11 or 12 = Left/Right Turn
	--PlayerExtra 13 = Down Run
	--PlayerExtra 14 = Up Run
	--PlayerExtra 15 or 16 = Left/Right Run
	--PlayerExtra 17 = Down Bike
	--PlayerExtra 18 = Up Bike
	--PlayerExtra 19 or 20 = Left/Right Bike
	local PlayerChar = 0
	for i = 1, MaxPlayers do
		PlayerChar = i - 1
		if PlayerID ~= i and MVars.PlayerIDNick[i] ~= "None" then
			--Facing down
			if MVars.PlayerExtra1[i] == 1 then SpriteGenerator.createChars(PlayerChar,"sideDown",MVars.PlayerExtra2[i],ScreenData) MVars.CurrentFacingDirection[i] = 4 MVars.Facing2[i] = 0 AnimatePlayerMovement(i, 251)
			
			--Facing up
			elseif MVars.PlayerExtra1[i] == 2 then SpriteGenerator.createChars(PlayerChar,"sideUp",MVars.PlayerExtra2[i],ScreenData) MVars.CurrentFacingDirection[i] = 3 MVars.Facing2[i] = 0 AnimatePlayerMovement(i, 252)
			
			--Facing left
			elseif MVars.PlayerExtra1[i] == 3 then SpriteGenerator.createChars(PlayerChar,"sideLR",MVars.PlayerExtra2[i],ScreenData) MVars.CurrentFacingDirection[i] = 1 MVars.Facing2[i] = 0 AnimatePlayerMovement(i, 253)
			
			--Facing right
			elseif MVars.PlayerExtra1[i] == 4 then SpriteGenerator.createChars(PlayerChar,"sideLR",MVars.PlayerExtra2[i],ScreenData) MVars.CurrentFacingDirection[i] = 2 MVars.Facing2[i] = 1 AnimatePlayerMovement(i, 254)
			
			--walk down
			elseif MVars.PlayerExtra1[i] == 5 then MVars.Facing2[i] = 0 MVars.CurrentFacingDirection[i] = 4 AnimatePlayerMovement(i, 1)
			
			--walk up
			elseif MVars.PlayerExtra1[i] == 6 then MVars.Facing2[i] = 0 MVars.CurrentFacingDirection[i] = 3 AnimatePlayerMovement(i, 2)
			
			--walk left
			elseif MVars.PlayerExtra1[i] == 7 then MVars.Facing2[i] = 0 MVars.CurrentFacingDirection[i] = 1 AnimatePlayerMovement(i, 3)
			
			--walk right
			elseif MVars.PlayerExtra1[i] == 8 then MVars.Facing2[i] = 1 MVars.CurrentFacingDirection[i] = 2 AnimatePlayerMovement(i, 13)
			
			--turn down
			elseif MVars.PlayerExtra1[i] == 9 then MVars.Facing2[i] = 0 MVars.CurrentFacingDirection[i] = 4 AnimatePlayerMovement(i, 10)
			
			--turn up
			elseif MVars.PlayerExtra1[i] == 10 then MVars.Facing2[i] = 0 MVars.CurrentFacingDirection[i] = 3 AnimatePlayerMovement(i, 11)
			
			--turn left
			elseif MVars.PlayerExtra1[i] == 11 then MVars.Facing2[i] = 0 MVars.CurrentFacingDirection[i] = 1 AnimatePlayerMovement(i, 12)
			
			--turn right
			elseif MVars.PlayerExtra1[i] == 12 then MVars.Facing2[i] = 1 MVars.CurrentFacingDirection[i] = 2 AnimatePlayerMovement(i, 12)
			
			--run down
			elseif MVars.PlayerExtra1[i] == 13 then MVars.Facing2[i] = 0 MVars.CurrentFacingDirection[i] = 4 AnimatePlayerMovement(i, 4)
			
			--run up
			elseif MVars.PlayerExtra1[i] == 14 then MVars.Facing2[i] = 0 MVars.CurrentFacingDirection[i] = 3 AnimatePlayerMovement(i, 5)
			
			--run left
			elseif MVars.PlayerExtra1[i] == 15 then MVars.Facing2[i] = 0 MVars.CurrentFacingDirection[i] = 1 AnimatePlayerMovement(i, 6)
			
			--run right
			elseif MVars.PlayerExtra1[i] == 16 then MVars.Facing2[i] = 1 MVars.CurrentFacingDirection[i] = 2 AnimatePlayerMovement(i, 14)
			
			--bike face down
			elseif MVars.PlayerExtra1[i] == 17 then SpriteGenerator.createChars(PlayerChar,"sideBikeDown",MVars.PlayerExtra2[i],ScreenData) MVars.CurrentFacingDirection[i] = 4 MVars.Facing2[i] = 0 AnimatePlayerMovement(i, 251)
			
			--bike face up
			elseif MVars.PlayerExtra1[i] == 18 then SpriteGenerator.createChars(PlayerChar,"sideBikeUp",MVars.PlayerExtra2[i],ScreenData) MVars.CurrentFacingDirection[i] = 3 MVars.Facing2[i] = 0 AnimatePlayerMovement(i, 252)
			
			--bike face left
			elseif MVars.PlayerExtra1[i] == 19 then SpriteGenerator.createChars(PlayerChar,"sideBikeL",MVars.PlayerExtra2[i],ScreenData) MVars.CurrentFacingDirection[i] = 1 MVars.Facing2[i] = 0 AnimatePlayerMovement(i, 253)
			
			--bike face right
			elseif MVars.PlayerExtra1[i] == 20 then SpriteGenerator.createChars(PlayerChar,"sideBikeL",MVars.PlayerExtra2[i],ScreenData) MVars.CurrentFacingDirection[i] = 2 MVars.Facing2[i] = 1 AnimatePlayerMovement(i, 254)
			
			--bike move down
			elseif MVars.PlayerExtra1[i] == 21 then MVars.Facing2[i] = 0 MVars.CurrentFacingDirection[i] = 4 AnimatePlayerMovement(i, 7)
			
			--bike move up
			elseif MVars.PlayerExtra1[i] == 22 then MVars.Facing2[i] = 0 MVars.CurrentFacingDirection[i] = 3 AnimatePlayerMovement(i, 8)
			
			--bike move left
			elseif MVars.PlayerExtra1[i] == 23 then MVars.Facing2[i] = 0 MVars.CurrentFacingDirection[i] = 1 AnimatePlayerMovement(i, 9)
			
			--bike move right
			elseif MVars.PlayerExtra1[i] == 24 then MVars.Facing2[i] = 1 MVars.CurrentFacingDirection[i] = 2 AnimatePlayerMovement(i, 15)
			
			--bike fast move down
			elseif MVars.PlayerExtra1[i] == 25 then MVars.Facing2[i] = 0 MVars.CurrentFacingDirection[i] = 4 AnimatePlayerMovement(i, 7)
			
			--bike fast move up
			elseif MVars.PlayerExtra1[i] == 26 then MVars.Facing2[i] = 0 MVars.CurrentFacingDirection[i] = 3 AnimatePlayerMovement(i, 8)
			
			--bike fast move left
			elseif MVars.PlayerExtra1[i] == 27 then MVars.Facing2[i] = 0 MVars.CurrentFacingDirection[i] = 1 AnimatePlayerMovement(i, 9)
			
			--bike fast move right
			elseif MVars.PlayerExtra1[i] == 28 then MVars.Facing2[i] = 1 MVars.CurrentFacingDirection[i] = 2 AnimatePlayerMovement(i, 15)
			
			--bike hit wall down
			elseif MVars.PlayerExtra1[i] == 29 then SpriteGenerator.createChars(PlayerChar,"sideBikeDown",MVars.PlayerExtra2[i],ScreenData) MVars.CurrentFacingDirection[i] = 4 MVars.Facing2[i] = 0 AnimatePlayerMovement(i, 251)
			
			--bike hit wall up
			elseif MVars.PlayerExtra1[i] == 30 then SpriteGenerator.createChars(PlayerChar,"sideBikeUp",MVars.PlayerExtra2[i],ScreenData) MVars.CurrentFacingDirection[i] = 3 MVars.Facing2[i] = 0 AnimatePlayerMovement(i, 252)
			
			--bike hit wall left
			elseif MVars.PlayerExtra1[i] == 31 then SpriteGenerator.createChars(PlayerChar,"sideBikeL",MVars.PlayerExtra2[i],ScreenData) MVars.CurrentFacingDirection[i] = 1 MVars.Facing2[i] = 0 AnimatePlayerMovement(i, 253)
			
			--bike hit wall right
			elseif MVars.PlayerExtra1[i] == 32 then SpriteGenerator.createChars(PlayerChar,"sideBikeL",MVars.PlayerExtra2[i],ScreenData) MVars.CurrentFacingDirection[i] = 2 MVars.Facing2[i] = 1 AnimatePlayerMovement(i, 254)
			
			--Surfing
			
			--Facing down
			elseif MVars.PlayerExtra1[i] == 33 then MVars.CurrentFacingDirection[i] = 4 MVars.Facing2[i] = 0 AnimatePlayerMovement(i, 17)
			
			--Facing up
			elseif MVars.PlayerExtra1[i] == 34 then MVars.CurrentFacingDirection[i] = 3 MVars.Facing2[i] = 0 AnimatePlayerMovement(i, 18)
			
			--Facing left
			elseif MVars.PlayerExtra1[i] == 35 then MVars.CurrentFacingDirection[i] = 1 MVars.Facing2[i] = 0 AnimatePlayerMovement(i, 19)
			
			--Facing right
			elseif MVars.PlayerExtra1[i] == 36 then MVars.CurrentFacingDirection[i] = 2 MVars.Facing2[i] = 1 AnimatePlayerMovement(i, 20)
			
			--surf down
			elseif MVars.PlayerExtra1[i] == 37 then MVars.Facing2[i] = 0 MVars.CurrentFacingDirection[i] = 4 AnimatePlayerMovement(i, 21)
			
			--surf up
			elseif MVars.PlayerExtra1[i] == 38 then MVars.Facing2[i] = 0 MVars.CurrentFacingDirection[i] = 3 AnimatePlayerMovement(i, 22)
			
			--surf left
			elseif MVars.PlayerExtra1[i] == 39 then MVars.Facing2[i] = 0 MVars.CurrentFacingDirection[i] = 1 AnimatePlayerMovement(i, 23)
			
			--surf right
			elseif MVars.PlayerExtra1[i] == 40 then MVars.Facing2[i] = 1 MVars.CurrentFacingDirection[i] = 2 AnimatePlayerMovement(i, 24)
			
			
			--default position
			elseif MVars.PlayerExtra1[i] == 0 then MVars.Facing2[i] = 0 AnimatePlayerMovement(i, 255)
			
			end
		end
	end
end

function CalculateCamera()
	--	ConsoleForText:print("Player X camera: " .. PlayerMapXMove .. "Player Y camera: " .. PlayerMapYMove)
	--	ConsoleForText:print("PlayerMapXMove: " .. PlayerMapXMove .. "PlayerMapYMove: " .. PlayerMapYMove .. "PlayerMapXMovePREV: " .. PVars.PlayerMapXMovePrev .. "PVars.PlayerMapYMovePrev: " .. PVars.PlayerMapYMovePrev)
		
		local PlayerMapXMoveTemp = 0
		local PlayerMapYMoveTemp = 0
		
		if GameID == "BPR1" or GameID == "BPR2" then
			--Addresses for Firered
			PlayerMapXMoveAddress = 33687132
			PlayerMapYMoveAddress = 33687134
		elseif GameID == "BPG1" or GameID == "BPG2"  then
			--Addresses for Leafgreen
			PlayerMapXMoveAddress = 33687132
			PlayerMapYMoveAddress = 33687134
		end
		--if PVars.PlayerMapChange == 1 then
			--Update first if map change
			PVars.PlayerMapXMovePrev = emu:read16(PlayerMapXMoveAddress) - 8
			PVars.PlayerMapYMovePrev = emu:read16(PlayerMapYMoveAddress)
			PlayerMapXMoveTemp = PVars.PlayerMapXMovePrev % 16
			PlayerMapYMoveTemp = PVars.PlayerMapYMovePrev % 16
			
			if PVars.PlayerDirection == 1 then
				PVars.CameraX = PlayerMapXMoveTemp * -1
			--	console:log("XTEMP: " .. PlayerMapXMoveTemp)
			elseif PVars.PlayerDirection == 2 then
				if PlayerMapXMoveTemp > 0 then
					PVars.CameraX = 16 - PlayerMapXMoveTemp
				else
					PVars.CameraX = 0
				end
				--console:log("XTEMP: " .. PlayerMapXMoveTemp)
			elseif PVars.PlayerDirection == 3 then
				PVars.CameraY = PlayerMapYMoveTemp * -1
				--console:log("YTEMP: " .. PlayerMapYMoveTemp)
			elseif PVars.PlayerDirection == 4 then
				--console:log("YTEMP: " .. PlayerMapYMoveTemp)
				if PlayerMapYMoveTemp > 0 then
					PVars.CameraY = 16 - PlayerMapYMoveTemp
				else
					PVars.CameraY = 0
				end
			end
			
			--Calculations for X and Y of new map
			if PVars.PlayerMapChange == 1 and (PVars.CameraX == 0 and PVars.CameraY == 0) then
				PVars.PlayerMapChange = 0
				MVars.StartX[PlayerID] = PlayerMapX
				MVars.StartY[PlayerID] = PlayerMapY
				PVars.DifferentMapXPlayer = (MVars.StartX[PlayerID] - MVars.PreviousX[PlayerID]) * 16
				PVars.DifferentMapYPlayer = (MVars.StartY[PlayerID] - MVars.PreviousY[PlayerID]) * 16
				if PVars.PlayerDirection == 1 then
					MVars.StartX[PlayerID] = MVars.StartX[PlayerID] + 1
				elseif PVars.PlayerDirection == 2 then
					MVars.StartX[PlayerID] = MVars.StartX[PlayerID] - 1
				elseif PVars.PlayerDirection == 3 then
					MVars.StartY[PlayerID] = MVars.StartY[PlayerID] + 1
				elseif PVars.PlayerDirection == 4 then
					MVars.StartY[PlayerID] = MVars.StartY[PlayerID] - 1
				end
			--	console:log("YOU HAVE MOVED MAPS")
				--For New Positions if player moves
			--	console:log("X: " .. MVars.DifferentMapX[i] .. " Y: " .. MVars.DifferentMapY[i])
				--if PVars.PlayerDirection == 4 then
				--	MVars.DifferentMapY[i] = MVars.DifferentMapY[i] + 16
				--end
			end
end

function CalculateRelativePositions()
	local TempX = 0
	local TempY = 0
	local TempX2 = 0
	local TempY2 = 0
	for i = 1, MaxPlayers do
		TempX = ((MVars.CurrentX[i] - PlayerMapX) * 16) + MVars.DifferentMapX[i]
		TempY = ((MVars.CurrentY[i] - PlayerMapY) * 16) + MVars.DifferentMapY[i]
		if PlayerID ~= i and MVars.PlayerIDNick[i] ~= "None" then
			if PVars.PlayerMapEntranceType == 0 and (PVars.PlayerMapIDPrev == MVars.CurrentMapID[i] or PVars.PlayerMapID == MVars.PreviousMapID[i]) and MVars.MapChange[i] == 0 then
				MVars.PlayerVis[i] = 1
				TempX2 = TempX + PVars.DifferentMapXPlayer
				TempY2 = TempY + PVars.DifferentMapYPlayer
			else
				TempX2 = TempX
				TempY2 = TempY
			end
			--MVars.AnimationX is -16 - 16 and is purely to animate sprites
			--PVars.CameraX can be between -16 and 16 and is to get the camera movement while moving
			--Current X is the X the current sprite has
			--Player X is the X the player sprite has
			MVars.RelativeX[i] = MVars.AnimationX[i] + PVars.CameraX + TempX2
			MVars.RelativeY[i] = MVars.AnimationY[i] + PVars.CameraY + TempY2
			--console:log("X: " .. MVars.RelativeX[i] .. " " .. MVars.CurrentX[i] .. " " .. PlayerMapX .. " " .. MVars.DifferentMapX[i])
			--console:log("Y: " .. MVars.RelativeY[i] .. " " .. MVars.AnimationY[i] .. " " .. PVars.CameraY .. " " .. TempY)
		end
	end
end


function DrawChars()
	if EnableScript == true then
		NoPlayersIfScreen()
				--Make sure the sprites are loaded
			
		HandleSprites()
		CalculateCamera()
		RenderPlayersOnDifferentMap()
		CalculateRelativePositions()
		if ScreenData == 1 then
			for i = 1, MaxPlayers do
				if MVars.HasErasedPlayer[i] == false then
					MVars.HasErasedPlayer[i] = true
					ErasePlayer(i)
				end
				if PlayerID ~= i and MVars.PlayerIDNick[i] ~= "None" then
					DrawPlayer(i)
				end
			end
		else
			for i = 1, MaxPlayers do
				MVars.HasErasedPlayer[i] = false
			end
		end
	end
end


function DrawPlayer(PlayerNo)
		local u32 PlayerYAddress = 0
		local u32 PlayerXAddress = 0
		local u32 PlayerFaceAddress = 0
		local u32 PlayerSpriteAddress = 0
		local u32 PlayerExtra1Address = 0
		local u32 PlayerExtra2Address = 0
		local u32 PlayerExtra3Address = 0
		local u32 PlayerExtra4Address = 0
		local SpriteNo1 = 2608 - ((PlayerNo - 1) * 40)
		local SpriteNo2 = SpriteNo1 + 18
		--For extra char if not biking
		local SpriteNo3 = SpriteNo1 + 8
		--For extra char if biking
		local SpriteNo4 = SpriteNo1 + 16
		if GameID == "BPR1" or GameID == "BPR2" then
			--Addresses for Firered
			Player1Address = 50345200 - ((PlayerNo - 1) * 24)
			PlayerYAddress = Player1Address
			PlayerXAddress = PlayerYAddress + 2
			PlayerFaceAddress = PlayerYAddress + 3
			PlayerSpriteAddress = PlayerYAddress + 1
			PlayerExtra1Address = PlayerYAddress + 4
			PlayerExtra2Address = PlayerYAddress + 5
			PlayerExtra3Address = PlayerYAddress + 6
			PlayerExtra4Address = PlayerYAddress + 7
		elseif GameID == "BPG1" or GameID == "BPG2" then
			--Addresses for Leafgreen
			Player1Address = 50345200 - ((PlayerNo - 1) * 24)
			PlayerYAddress = Player1Address
			PlayerXAddress = PlayerYAddress + 2
			PlayerFaceAddress = PlayerYAddress + 3
			PlayerSpriteAddress = PlayerYAddress + 1
			PlayerExtra1Address = PlayerYAddress + 4
			PlayerExtra2Address = PlayerYAddress + 5
			PlayerExtra3Address = PlayerYAddress + 6
			PlayerExtra4Address = PlayerYAddress + 7
		end
		
		--Screen size (take into account movement)
		local MinX = -16
		local MaxX = 240
		local MinY = -32
		local MaxY = 144
		--This is for the bike + surf
		if MVars.PlayerExtra1[PlayerNo] >= 17 and MVars.PlayerExtra1[PlayerNo] <= 40 then MinX = -8 end
		if MVars.PlayerExtra1[PlayerNo] >= 33 and MVars.PlayerExtra1[PlayerNo] <= 40 then MinX = 8 end
		
		--112 and 56 = middle of screen
		local FinalMapX = MVars.RelativeX[PlayerNo] + 112
		local FinalMapY = MVars.RelativeY[PlayerNo] + 56
		
		--Flip sprite if facing right
		local FacingTemp = 128
		if MVars.Facing2[PlayerNo] == 1 then FacingTemp = 144
		else FacingTemp = 128
		end
		
		if not ((FinalMapX > MaxX or FinalMapX < MinX) or (FinalMapY > MaxY or FinalMapY < MinY)) then 
			
			if MVars.PlayerVis[PlayerNo] == 1 then
				--Bikes need different vars
				if MVars.PlayerExtra1[PlayerNo] >= 17 and MVars.PlayerExtra1[PlayerNo] <= 32 then
				FinalMapX = FinalMapX - 8
				emu:write8(PlayerXAddress, FinalMapX)
				emu:write8(PlayerYAddress, FinalMapY)
				emu:write8(PlayerFaceAddress, FacingTemp)
				emu:write8(PlayerSpriteAddress, 0)
				emu:write16(PlayerExtra1Address, SpriteNo1)
				emu:write8(PlayerExtra3Address, 0)
				emu:write8(PlayerExtra4Address, 0)
				--Surfing char erase
				PlayerYAddress = Player1Address + 8
				PlayerXAddress = PlayerYAddress + 2
				PlayerFaceAddress = PlayerYAddress + 3
				PlayerSpriteAddress = PlayerYAddress + 1
				PlayerExtra1Address = PlayerYAddress + 4
				PlayerExtra2Address = PlayerYAddress + 5
				PlayerExtra3Address = PlayerYAddress + 6
				PlayerExtra4Address = PlayerYAddress + 7
				emu:write8(PlayerYAddress, 160)
				emu:write8(PlayerXAddress, 48)
				emu:write8(PlayerFaceAddress, 1)
				emu:write8(PlayerSpriteAddress, 0)
				emu:write16(PlayerExtra1Address, 12)
				emu:write8(PlayerExtra3Address, 0)
				emu:write8(PlayerExtra4Address, 1)
				--Add fighting symbol if in battle
					if MVars.PlayerExtra4[PlayerNo] == 1 then
						local SymbolY = FinalMapY - 8
						local SymbolX = FinalMapX + 8
						local Charpic = PlayerNo - 1
						--Create battle symbol
						SpriteGenerator.createChars(Charpic, "battleIcon", 2, ScreenData, 1)
						--Extra Char
						PlayerYAddress = Player1Address + 16
						PlayerXAddress = PlayerYAddress + 2
						PlayerFaceAddress = PlayerYAddress + 3
						PlayerSpriteAddress = PlayerYAddress + 1
						PlayerExtra1Address = PlayerYAddress + 4
						PlayerExtra2Address = PlayerYAddress + 5
						PlayerExtra3Address = PlayerYAddress + 6
						PlayerExtra4Address = PlayerYAddress + 7
						emu:write8(PlayerYAddress, SymbolY)
						emu:write8(PlayerXAddress, SymbolX)
						emu:write8(PlayerFaceAddress, 64)
						emu:write8(PlayerSpriteAddress, 0)
						emu:write16(PlayerExtra1Address, SpriteNo4)
						emu:write8(PlayerExtra3Address, 0)
						emu:write8(PlayerExtra4Address, 1)
					else
						PlayerYAddress = Player1Address + 16
						PlayerXAddress = PlayerYAddress + 2
						PlayerFaceAddress = PlayerYAddress + 3
						PlayerSpriteAddress = PlayerYAddress + 1
						PlayerExtra1Address = PlayerYAddress + 4
						PlayerExtra2Address = PlayerYAddress + 5
						PlayerExtra3Address = PlayerYAddress + 6
						PlayerExtra4Address = PlayerYAddress + 7
						emu:write8(PlayerYAddress, 160)
						emu:write8(PlayerXAddress, 48)
						emu:write8(PlayerFaceAddress, 1)
						emu:write8(PlayerSpriteAddress, 0)
						emu:write16(PlayerExtra1Address, 12)
						emu:write8(PlayerExtra3Address, 0)
						emu:write8(PlayerExtra4Address, 1)
					end
				--Same with surf
				elseif MVars.PlayerExtra1[PlayerNo] >= 33 and MVars.PlayerExtra1[PlayerNo] <= 40 then
				if PlayerAnimationFrame2[PlayerNo] == 1 and MVars.PlayerExtra1[PlayerNo] <= 36 then FinalMapY = FinalMapY + 1 end
				--Sitting char
				emu:write8(PlayerXAddress, FinalMapX)
				emu:write8(PlayerYAddress, FinalMapY)
				emu:write8(PlayerFaceAddress, FacingTemp)
				emu:write8(PlayerSpriteAddress, 128)
				emu:write16(PlayerExtra1Address, SpriteNo1)
				emu:write8(PlayerExtra3Address, 0)
				emu:write8(PlayerExtra4Address, 0)
				--Add fighting symbol if in battle
				if MVars.PlayerExtra4[PlayerNo] == 1 then
					local SymbolY = FinalMapY - 8
					local SymbolX = FinalMapX
					local Charpic = PlayerNo - 1
					--Create battle symbol
					SpriteGenerator.createChars(Charpic, "battleIcon", 2, ScreenData, 0)
					--Extra Char
					PlayerYAddress = Player1Address + 16
					PlayerXAddress = PlayerYAddress + 2
					PlayerFaceAddress = PlayerYAddress + 3
					PlayerSpriteAddress = PlayerYAddress + 1
					PlayerExtra1Address = PlayerYAddress + 4
					PlayerExtra2Address = PlayerYAddress + 5
					PlayerExtra3Address = PlayerYAddress + 6
					PlayerExtra4Address = PlayerYAddress + 7
					emu:write8(PlayerYAddress, SymbolY)
					emu:write8(PlayerXAddress, SymbolX)
					emu:write8(PlayerFaceAddress, 64)
					emu:write8(PlayerSpriteAddress, 0)
					emu:write16(PlayerExtra1Address, SpriteNo3)
					emu:write8(PlayerExtra3Address, 0)
					emu:write8(PlayerExtra4Address, 1)
				else
					PlayerYAddress = Player1Address + 16
					PlayerXAddress = PlayerYAddress + 2
					PlayerFaceAddress = PlayerYAddress + 3
					PlayerSpriteAddress = PlayerYAddress + 1
					PlayerExtra1Address = PlayerYAddress + 4
					PlayerExtra2Address = PlayerYAddress + 5
					PlayerExtra3Address = PlayerYAddress + 6
					PlayerExtra4Address = PlayerYAddress + 7
					emu:write8(PlayerYAddress, 160)
					emu:write8(PlayerXAddress, 48)
					emu:write8(PlayerFaceAddress, 1)
					emu:write8(PlayerSpriteAddress, 0)
					emu:write16(PlayerExtra1Address, 12)
					emu:write8(PlayerExtra3Address, 0)
					emu:write8(PlayerExtra4Address, 1)
				end
				--Surfing char
				if PlayerAnimationFrame2[PlayerNo] == 1 and MVars.PlayerExtra1[PlayerNo] <= 36 then FinalMapY = FinalMapY - 1 end
				FinalMapX = FinalMapX - 8
				FinalMapY = FinalMapY + 8
				PlayerYAddress = Player1Address + 8
				PlayerXAddress = PlayerYAddress + 2
				PlayerFaceAddress = PlayerYAddress + 3
				PlayerSpriteAddress = PlayerYAddress + 1
				PlayerExtra1Address = PlayerYAddress + 4
				PlayerExtra2Address = PlayerYAddress + 5
				PlayerExtra3Address = PlayerYAddress + 6
				PlayerExtra4Address = PlayerYAddress + 7
				emu:write8(PlayerXAddress, FinalMapX)
				emu:write8(PlayerYAddress, FinalMapY)
				emu:write8(PlayerFaceAddress, FacingTemp)
				emu:write8(PlayerSpriteAddress, 0)
				emu:write16(PlayerExtra1Address, SpriteNo2)
				emu:write8(PlayerExtra3Address, 0)
				emu:write8(PlayerExtra4Address, 0)
				else
				emu:write8(PlayerXAddress, FinalMapX)
				emu:write8(PlayerYAddress, FinalMapY)
				emu:write8(PlayerFaceAddress, FacingTemp)
				emu:write8(PlayerSpriteAddress, 128)
				emu:write16(PlayerExtra1Address, SpriteNo1)
				emu:write8(PlayerExtra3Address, 0)
				emu:write8(PlayerExtra4Address, 0)
				--Surfing char
				PlayerYAddress = Player1Address + 8
				PlayerXAddress = PlayerYAddress + 2
				PlayerFaceAddress = PlayerYAddress + 3
				PlayerSpriteAddress = PlayerYAddress + 1
				PlayerExtra1Address = PlayerYAddress + 4
				PlayerExtra2Address = PlayerYAddress + 5
				PlayerExtra3Address = PlayerYAddress + 6
				PlayerExtra4Address = PlayerYAddress + 7
				emu:write8(PlayerYAddress, 160)
				emu:write8(PlayerXAddress, 48)
				emu:write8(PlayerFaceAddress, 1)
				emu:write8(PlayerSpriteAddress, 0)
				emu:write16(PlayerExtra1Address, 12)
				emu:write8(PlayerExtra3Address, 0)
				emu:write8(PlayerExtra4Address, 1)
				--Add fighting symbol if in battle
					if MVars.PlayerExtra4[PlayerNo] == 1 then
						local SymbolY = FinalMapY - 8
						local SymbolX = FinalMapX
						local Charpic = PlayerNo - 1
						--Create battle symbol
						SpriteGenerator.createChars(Charpic, "battleIcon", 2, ScreenData, 0)
						--Extra Char
						PlayerYAddress = Player1Address + 16
						PlayerXAddress = PlayerYAddress + 2
						PlayerFaceAddress = PlayerYAddress + 3
						PlayerSpriteAddress = PlayerYAddress + 1
						PlayerExtra1Address = PlayerYAddress + 4
						PlayerExtra2Address = PlayerYAddress + 5
						PlayerExtra3Address = PlayerYAddress + 6
						PlayerExtra4Address = PlayerYAddress + 7
						emu:write8(PlayerYAddress, SymbolY)
						emu:write8(PlayerXAddress, SymbolX)
						emu:write8(PlayerFaceAddress, 64)
						emu:write8(PlayerSpriteAddress, 0)
						emu:write16(PlayerExtra1Address, SpriteNo3)
						emu:write8(PlayerExtra3Address, 0)
						emu:write8(PlayerExtra4Address, 1)
					else
						PlayerYAddress = Player1Address + 16
						PlayerXAddress = PlayerYAddress + 2
						PlayerFaceAddress = PlayerYAddress + 3
						PlayerSpriteAddress = PlayerYAddress + 1
						PlayerExtra1Address = PlayerYAddress + 4
						PlayerExtra2Address = PlayerYAddress + 5
						PlayerExtra3Address = PlayerYAddress + 6
						PlayerExtra4Address = PlayerYAddress + 7
						emu:write8(PlayerYAddress, 160)
						emu:write8(PlayerXAddress, 48)
						emu:write8(PlayerFaceAddress, 1)
						emu:write8(PlayerSpriteAddress, 0)
						emu:write16(PlayerExtra1Address, 12)
						emu:write8(PlayerExtra3Address, 0)
						emu:write8(PlayerExtra4Address, 1)
					end
				end
			--Remove sprite
			else
					emu:write8(PlayerYAddress, 160)
					emu:write8(PlayerXAddress, 48)
					emu:write8(PlayerFaceAddress, 1)
					emu:write8(PlayerSpriteAddress, 0)
					emu:write16(PlayerExtra1Address, 12)
					emu:write8(PlayerExtra3Address, 0)
					emu:write8(PlayerExtra4Address, 1)
					--Surfing char
					PlayerYAddress = Player1Address + 8
					PlayerXAddress = PlayerYAddress + 2
					PlayerFaceAddress = PlayerYAddress + 3
					PlayerSpriteAddress = PlayerYAddress + 1
					PlayerExtra1Address = PlayerYAddress + 4
					PlayerExtra2Address = PlayerYAddress + 5
					PlayerExtra3Address = PlayerYAddress + 6
					PlayerExtra4Address = PlayerYAddress + 7
					emu:write8(PlayerYAddress, 160)
					emu:write8(PlayerXAddress, 48)
					emu:write8(PlayerFaceAddress, 1)
					emu:write8(PlayerSpriteAddress, 0)
					emu:write16(PlayerExtra1Address, 12)
					emu:write8(PlayerExtra3Address, 0)
					emu:write8(PlayerExtra4Address, 1)
					--Extra Char
					PlayerYAddress = Player1Address + 16
					PlayerXAddress = PlayerYAddress + 2
					PlayerFaceAddress = PlayerYAddress + 3
					PlayerSpriteAddress = PlayerYAddress + 1
					PlayerExtra1Address = PlayerYAddress + 4
					PlayerExtra2Address = PlayerYAddress + 5
					PlayerExtra3Address = PlayerYAddress + 6
					PlayerExtra4Address = PlayerYAddress + 7
					emu:write8(PlayerYAddress, 160)
					emu:write8(PlayerXAddress, 48)
					emu:write8(PlayerFaceAddress, 1)
					emu:write8(PlayerSpriteAddress, 0)
					emu:write16(PlayerExtra1Address, 12)
					emu:write8(PlayerExtra3Address, 0)
					emu:write8(PlayerExtra4Address, 1)
			end
		--Remove sprite
		else
				emu:write8(PlayerYAddress, 160)
				emu:write8(PlayerXAddress, 48)
				emu:write8(PlayerFaceAddress, 1)
				emu:write8(PlayerSpriteAddress, 0)
				emu:write16(PlayerExtra1Address, 12)
				emu:write8(PlayerExtra3Address, 0)
				emu:write8(PlayerExtra4Address, 1)
					--Surfing char
					PlayerYAddress = Player1Address + 8
					PlayerXAddress = PlayerYAddress + 2
					PlayerFaceAddress = PlayerYAddress + 3
					PlayerSpriteAddress = PlayerYAddress + 1
					PlayerExtra1Address = PlayerYAddress + 4
					PlayerExtra2Address = PlayerYAddress + 5
					PlayerExtra3Address = PlayerYAddress + 6
					PlayerExtra4Address = PlayerYAddress + 7
					emu:write8(PlayerYAddress, 160)
					emu:write8(PlayerXAddress, 48)
					emu:write8(PlayerFaceAddress, 1)
					emu:write8(PlayerSpriteAddress, 0)
					emu:write16(PlayerExtra1Address, 12)
					emu:write8(PlayerExtra3Address, 0)
					emu:write8(PlayerExtra4Address, 1)
					--Extra Char
					PlayerYAddress = Player1Address + 16
					PlayerXAddress = PlayerYAddress + 2
					PlayerFaceAddress = PlayerYAddress + 3
					PlayerSpriteAddress = PlayerYAddress + 1
					PlayerExtra1Address = PlayerYAddress + 4
					PlayerExtra2Address = PlayerYAddress + 5
					PlayerExtra3Address = PlayerYAddress + 6
					PlayerExtra4Address = PlayerYAddress + 7
					emu:write8(PlayerYAddress, 160)
					emu:write8(PlayerXAddress, 48)
					emu:write8(PlayerFaceAddress, 1)
					emu:write8(PlayerSpriteAddress, 0)
					emu:write16(PlayerExtra1Address, 12)
					emu:write8(PlayerExtra3Address, 0)
					emu:write8(PlayerExtra4Address, 1)
		end
end
function ErasePlayer(PlayerNo)
		local u32 PlayerYAddress = 0
		local u32 PlayerXAddress = 0
		local u32 PlayerFaceAddress = 0
		local u32 PlayerSpriteAddress = 0
		local u32 PlayerExtra1Address = 0
		local u32 PlayerExtra2Address = 0
		local u32 PlayerExtra3Address = 0
		local u32 PlayerExtra4Address = 0
		if GameID == "BPR1" or GameID == "BPR2" then
			--Addresses for Firered
			Player1Address = 50345200 - ((PlayerNo - 1) * 24)
			PlayerYAddress = Player1Address
			PlayerXAddress = PlayerYAddress + 2
			PlayerFaceAddress = PlayerYAddress + 3
			PlayerSpriteAddress = PlayerYAddress + 1
			PlayerExtra1Address = PlayerYAddress + 4
			PlayerExtra2Address = PlayerYAddress + 5
			PlayerExtra3Address = PlayerYAddress + 6
			PlayerExtra4Address = PlayerYAddress + 7
		elseif GameID == "BPG1" or GameID == "BPG2" then
			--Addresses for Leafgreen
			Player1Address = 50345200 - ((PlayerNo - 1) * 24)
			PlayerYAddress = Player1Address
			PlayerXAddress = PlayerYAddress + 2
			PlayerFaceAddress = PlayerYAddress + 3
			PlayerSpriteAddress = PlayerYAddress + 1
			PlayerExtra1Address = PlayerYAddress + 4
			PlayerExtra2Address = PlayerYAddress + 5
			PlayerExtra3Address = PlayerYAddress + 6
			PlayerExtra4Address = PlayerYAddress + 7
		end
				emu:write8(PlayerYAddress, 160)
				emu:write8(PlayerXAddress, 48)
				emu:write8(PlayerFaceAddress, 1)
				emu:write8(PlayerSpriteAddress, 0)
				emu:write16(PlayerExtra1Address, 12)
				emu:write8(PlayerExtra3Address, 0)
				emu:write8(PlayerExtra4Address, 1)
					--Surfing char
					PlayerYAddress = Player1Address + 8
					PlayerXAddress = PlayerYAddress + 2
					PlayerFaceAddress = PlayerYAddress + 3
					PlayerSpriteAddress = PlayerYAddress + 1
					PlayerExtra1Address = PlayerYAddress + 4
					PlayerExtra2Address = PlayerYAddress + 5
					PlayerExtra3Address = PlayerYAddress + 6
					PlayerExtra4Address = PlayerYAddress + 7
					emu:write8(PlayerYAddress, 160)
					emu:write8(PlayerXAddress, 48)
					emu:write8(PlayerFaceAddress, 1)
					emu:write8(PlayerSpriteAddress, 0)
					emu:write16(PlayerExtra1Address, 12)
					emu:write8(PlayerExtra3Address, 0)
					emu:write8(PlayerExtra4Address, 1)
					--Extra Char
					PlayerYAddress = Player1Address + 16
					PlayerXAddress = PlayerYAddress + 2
					PlayerFaceAddress = PlayerYAddress + 3
					PlayerSpriteAddress = PlayerYAddress + 1
					PlayerExtra1Address = PlayerYAddress + 4
					PlayerExtra2Address = PlayerYAddress + 5
					PlayerExtra3Address = PlayerYAddress + 6
					PlayerExtra4Address = PlayerYAddress + 7
					emu:write8(PlayerYAddress, 160)
					emu:write8(PlayerXAddress, 48)
					emu:write8(PlayerFaceAddress, 1)
					emu:write8(PlayerSpriteAddress, 0)
					emu:write16(PlayerExtra1Address, 12)
					emu:write8(PlayerExtra3Address, 0)
					emu:write8(PlayerExtra4Address, 1)
end

--Unique for server

function AddPlayerToConsole(PlayerNumber)
	local MultiplayerPlayerNumber = PlayerNumber + 1
	local ConsoleLine = PlayerNumber + 8
	if MVars.MultiplayerConsoleFlags[MultiplayerPlayerNumber] == 0 and MVars.PlayerIDNick[PlayerNumber] ~= "None" then
		ConsoleForText:moveCursor(0,4)
		MVars.MultiplayerConsoleFlags[1] = MVars.MultiplayerConsoleFlags[1] + 1
		ConsoleForText:print("MVars.Players found!                                                  ")
			
			
		MVars.MultiplayerConsoleFlags[MultiplayerPlayerNumber] = 1
		ConsoleForText:moveCursor(0,ConsoleLine)
		ConsoleForText:print("Player " .. PlayerNumber .. ": " .. MVars.PlayerIDNick[PlayerNumber]  .. "                            ")
		
	end
end

function RemovePlayerFromConsole(PlayerNumber)
	local MultiplayerPlayerNumber = PlayerNumber + 1
	local ConsoleLine = PlayerNumber + 8
	if MVars.MultiplayerConsoleFlags[MultiplayerPlayerNumber] == 1 then
		MVars.MultiplayerConsoleFlags[1] = MVars.MultiplayerConsoleFlags[1] - 1
		if MVars.MultiplayerConsoleFlags[1] <= 0 then
			MVars.MultiplayerConsoleFlags[1] = 0
			ConsoleForText:moveCursor(0,4)
			ConsoleForText:print("Searching for player...                                                ")
		end
		MVars.MultiplayerConsoleFlags[MultiplayerPlayerNumber] = 0
		ConsoleForText:moveCursor(0,ConsoleLine)
		ConsoleForText:print("                                                                     ")
		
	end
end



function GetNewGame()
    ClearAllVar()
	if ConsoleForText == nil then
		ConsoleForText = console:createBuffer("GBA-PK SERVER")
	end
	ConsoleForText:clear()
	ConsoleForText:moveCursor(0,0)
	ConsoleForText:print("A new game has started")
	ConsoleForText:moveCursor(0,1)
	FFTimer2 = os.time()
	GameChecker.GetGameVersion()
end

function shutdownGame()
    ClearAllVar()
	ConsoleForText:clear()
	ConsoleForText:moveCursor(0,0)
	ConsoleForText:print("The game was shutdown")
end

--Begin Networking

--Create Server

function CreateNetwork()
	if MasterClient ~= "h" then
		SocketMain:bind(nil, Port)
		SocketMain:listen()
		MasterClient = "h"
		ConsoleForText:moveCursor(0,3)
		ConsoleForText:print("Hosting game. Port forwarding may be required.")
		ConsoleForText:moveCursor(0,4)
		ConsoleForText:print("Searching for player...                                                ")
	end
end
function SetPokemonData(PokeData)
	if string.len(EnemyPokemon[1]) < 250 then EnemyPokemon[1] = EnemyPokemon[1] .. PokeData
	elseif string.len(EnemyPokemon[2]) < 250 then EnemyPokemon[2] = EnemyPokemon[2] .. PokeData
	elseif string.len(EnemyPokemon[3]) < 250 then EnemyPokemon[3] = EnemyPokemon[3] .. PokeData
	elseif string.len(EnemyPokemon[4]) < 250 then EnemyPokemon[4] = EnemyPokemon[4] .. PokeData
	elseif string.len(EnemyPokemon[5]) < 250 then EnemyPokemon[5] = EnemyPokemon[5] .. PokeData
	elseif string.len(EnemyPokemon[6]) < 250 then EnemyPokemon[6] = EnemyPokemon[6] .. PokeData
	end
end
function ReceiveData(Clientell)
			local RECEIVEDID = 0
			local RECEIVEDID2 = 0
			if EnableScript == true then
			--Check if anybody wants to connect
				if (Clientell:hasdata()) then
				local ReadData = Clientell:receive(64)
			--	local StringLen = 0
					
				if ReadData ~= nil then
				--	console:log("READDATA: " .. ReadData)
					--Encryption key
					ReceiveDataSmall[17] = "A"
					ReceiveDataSmall[1] = string.sub(ReadData,1,4)
					ReceiveDataSmall[2] = string.sub(ReadData,5,8)
					ReceiveDataSmall[3] = tonumber(string.sub(ReadData,9,12))
					RECEIVEDID = ReceiveDataSmall[3] - 1000
					ReceiveDataSmall[4] = tonumber(string.sub(ReadData,13,16))
					RECEIVEDID2 = ReceiveDataSmall[4] - 1000
					ReceiveDataSmall[5] = string.sub(ReadData,17,20)
					ReceiveDataSmall[17] = string.sub(ReadData,64,64)
				--	if ReceiveDataSmall[4] == "BATT" then ConsoleForText:print("Valid package! Contents: " .. ReadData) end
				--	ConsoleForText:print("Type: " .. ReceiveDataSmall[4])
				--	if ReceiveDataSmall[5] == "POKE" then console:log("Player " .. ReceiveDataSmall[4] .. " is being sent pokemon by " .. ReceiveDataSmall[3]) end
					if ReceiveDataSmall[17] == "U" and ReceiveDataSmall[4] > PlayerID2 then
						if MVars.PlayerIDNick[RECEIVEDID2] ~= "None" then
							MVars.Players[RECEIVEDID2]:send(ReadData)
						end
					elseif ReceiveDataSmall[17] == "U" and ReceiveDataSmall[5] == "SLNK" then
							MVars.timeout[RECEIVEDID] = timeoutmax
							ReceiveDataSmall[6] = string.sub(ReadData,21,30)
							ReceiveDataSmall[6] = tonumber(ReceiveDataSmall[6])
							if ReceiveDataSmall[6] ~= 0 then
								ReceiveDataSmall[6] = ReceiveDataSmall[6] - 1000000000
								ReceiveMultiplayerPackets(ReceiveDataSmall[6])
							end
					elseif ReceiveDataSmall[17] == "U" and ReceiveDataSmall[5] == "POKE" then
							MVars.timeout[RECEIVEDID] = timeoutmax
							local PokeTemp2 = string.sub(ReadData,21,45)
							SetPokemonData(PokeTemp2)
							
					elseif ReceiveDataSmall[17] == "U" and ReceiveDataSmall[5] == "TRAD" then
						MVars.timeout[RECEIVEDID] = timeoutmax
						EnemyTradeVars[1] = string.sub(ReadData,21,21)
						EnemyTradeVars[2] = string.sub(ReadData,22,22)
						EnemyTradeVars[3] = string.sub(ReadData,23,23)
						EnemyTradeVars[5] = string.sub(ReadData,24,63)
						EnemyTradeVars[1] = tonumber(EnemyTradeVars[1])
						EnemyTradeVars[2] = tonumber(EnemyTradeVars[2])
						EnemyTradeVars[3] = tonumber(EnemyTradeVars[3])
					elseif ReceiveDataSmall[17] == "U" and ReceiveDataSmall[5] == "BATT" then
						MVars.timeout[RECEIVEDID] = timeoutmax
						EnemyBattleVars[1] = string.sub(ReadData,21,21)
						EnemyBattleVars[2] = string.sub(ReadData,22,22)
						EnemyBattleVars[3] = string.sub(ReadData,23,23)
						EnemyBattleVars[4] = string.sub(ReadData,24,24)
						EnemyBattleVars[5] = string.sub(ReadData,25,25)
						EnemyBattleVars[6] = string.sub(ReadData,26,26)
						EnemyBattleVars[7] = string.sub(ReadData,27,27)
						EnemyBattleVars[8] = string.sub(ReadData,28,28)
						EnemyBattleVars[9] = string.sub(ReadData,29,29)
						EnemyBattleVars[10] = string.sub(ReadData,30,30)
						EnemyBattleVars[1] = tonumber(EnemyBattleVars[1])
						EnemyBattleVars[2] = tonumber(EnemyBattleVars[2])
						EnemyBattleVars[3] = tonumber(EnemyBattleVars[3])
						EnemyBattleVars[4] = tonumber(EnemyBattleVars[4])
						EnemyBattleVars[5] = tonumber(EnemyBattleVars[5])
						EnemyBattleVars[6] = tonumber(EnemyBattleVars[6])
						EnemyBattleVars[7] = tonumber(EnemyBattleVars[7])
						EnemyBattleVars[8] = tonumber(EnemyBattleVars[8])
						EnemyBattleVars[9] = tonumber(EnemyBattleVars[9])
						EnemyBattleVars[10] = tonumber(EnemyBattleVars[10])
					
					elseif ReceiveDataSmall[17] == "U" then
							--Decryption for packet
							--Extra bytes connected to sent request
							ReceiveDataSmall[6] = string.sub(ReadData,21,24)
							ReceiveDataSmall[6] = tonumber(ReceiveDataSmall[6])
							--X
							ReceiveDataSmall[7] = string.sub(ReadData,25,28)
							ReceiveDataSmall[7] = tonumber(ReceiveDataSmall[7])
							--Y
							ReceiveDataSmall[8] = string.sub(ReadData,29,32)
							ReceiveDataSmall[8] = tonumber(ReceiveDataSmall[8])
							--Facing (used during comparing for extra1)
							ReceiveDataSmall[9] = string.sub(ReadData,33,35)
							ReceiveDataSmall[9] = tonumber(ReceiveDataSmall[9])
							--Extra 1
							ReceiveDataSmall[10] = string.sub(ReadData,36,38)
							ReceiveDataSmall[10] = tonumber(ReceiveDataSmall[10])
							ReceiveDataSmall[10] = ReceiveDataSmall[10] - 100
							--Extra 2
							ReceiveDataSmall[11] = string.sub(ReadData,39,39)
							ReceiveDataSmall[11] = tonumber(ReceiveDataSmall[11])
							--Extra 3
							ReceiveDataSmall[12] = string.sub(ReadData,40,40)
							ReceiveDataSmall[12] = tonumber(ReceiveDataSmall[12])
							--Extra 4
							ReceiveDataSmall[13] = string.sub(ReadData,41,41)
							ReceiveDataSmall[13] = tonumber(ReceiveDataSmall[13])
							--MVars.MapID
							ReceiveDataSmall[14] = string.sub(ReadData,42,47)
							ReceiveDataSmall[14] = tonumber(ReceiveDataSmall[14])
							--MVars.PreviousMapID
							ReceiveDataSmall[15] = string.sub(ReadData,48,53)
							ReceiveDataSmall[15] = tonumber(ReceiveDataSmall[15])
							--MapConnectionType
							ReceiveDataSmall[16] = string.sub(ReadData,54,54)
							ReceiveDataSmall[16] = tonumber(ReceiveDataSmall[16])
							--MVars.StartX
							ReceiveDataSmall[18] = string.sub(ReadData,55,58)
							ReceiveDataSmall[18] = tonumber(ReceiveDataSmall[18])
							--MVars.StartY
							ReceiveDataSmall[19] = string.sub(ReadData,59,62)
							ReceiveDataSmall[19] = tonumber(ReceiveDataSmall[19])
							--63 is a filler byte.
						
						--Set connection type to var
							ReturnConnectionType = ReceiveDataSmall[5]
							MVars.timeout[RECEIVEDID] = timeoutmax
						
					--	ConsoleForText:print("Valid package! Contents: " .. ReadData)
				--	if ReceiveDataSmall[5] == "DTRA" then ConsoleForText:print("Locktype: " .. LockFromScript) end
						
						if ReceiveDataSmall[5] == "RPOK" and ReceiveDataSmall[3] ~= PlayerID2 then
							CreatePackettSpecial("POKE",MVars.Players[RECEIVEDID])
						end
						
						--If a player requests for a battle
						if ReceiveDataSmall[5] == "RBAT" and ReceiveDataSmall[3] ~= PlayerID2 then
							local TooBusyByte = emu:read8(50335644)
							if (TooBusyByte ~= 0 or LockFromScript ~= 0) then
								SendData("TBUS", MVars.Players[RECEIVEDID])
							else
								MVars.PlayerTalkingID = ReceiveDataSmall[3] - 1000
								MVars.PlayerTalkingID2 = ReceiveDataSmall[3]
								OtherPlayerHasCancelled = 0
								LockFromScript = 12
								ScriptLoader.Loadscript(10)
							end
						end
						
						--If player 2 requests for a trade
						if ReceiveDataSmall[5] == "RTRA" and ReceiveDataSmall[3] ~= PlayerID2 then
							local TooBusyByte = emu:read8(50335644)
							if (TooBusyByte ~= 0 or LockFromScript ~= 0) then
								SendData("TBUS", MVars.Players[RECEIVEDID])
							else
								MVars.PlayerTalkingID = ReceiveDataSmall[3] - 1000
								MVars.PlayerTalkingID2 = ReceiveDataSmall[3]
								OtherPlayerHasCancelled = 0
								LockFromScript = 13
								ScriptLoader.Loadscript(6)
							end
						end
						
						--The player is too busy to battle
						if ReceiveDataSmall[5] == "TBUS" and ReceiveDataSmall[3] == MVars.PlayerTalkingID2 and LockFromScript == 4 then
						--	ConsoleForText:print("Other player is too busy to battle.")
							if Var8000[2] ~= 0 then
								LockFromScript = 7
								ScriptLoader.Loadscript(20)
							else
								TextSpeedWait = 5
							end
						--The player is too busy to trade
						elseif ReceiveDataSmall[5] == "TBUS" and ReceiveDataSmall[3] == MVars.PlayerTalkingID2 and LockFromScript == 5 then
						--	ConsoleForText:print("Other player is too busy to trade.")
							if Var8000[2] ~= 0 then
								LockFromScript = 7
								ScriptLoader.Loadscript(21)
							else
								TextSpeedWait = 6
							end
						end
						
						--If the other player cancels battle
						if ReceiveDataSmall[5] == "CBAT" and ReceiveDataSmall[3] == MVars.PlayerTalkingID2 then
					--		ConsoleForText:print("Other player has canceled battle.")
							OtherPlayerHasCancelled = 1
						end
						--If the other player cancels trade
						if ReceiveDataSmall[5] == "CTRA" and ReceiveDataSmall[3] == MVars.PlayerTalkingID2 then
					--		ConsoleForText:print("Other player has canceled trade.")
							OtherPlayerHasCancelled = 2
						end
						
						--If the other player accepts your battle request
						if ReceiveDataSmall[5] == "SBAT" and ReceiveDataSmall[3] == MVars.PlayerTalkingID2 and LockFromScript == 4 then
							SendData("RPOK", MVars.Players[RECEIVEDID])
							if Var8000[2] ~= 0 then
								LockFromScript = 8
								ScriptLoader.Loadscript(13)
							else
								TextSpeedWait = 1
							end
						end
						--If the other player accepts your trade request
						if ReceiveDataSmall[5] == "STRA" and ReceiveDataSmall[3] == MVars.PlayerTalkingID2 and LockFromScript == 5 then
							SendData("RPOK", MVars.Players[RECEIVEDID])
							if Var8000[2] ~= 0 then
								LockFromScript = 9
							else
								TextSpeedWait = 2
							end
						end
						
						--If the other player denies your battle request
						if ReceiveDataSmall[5] == "DBAT" and ReceiveDataSmall[3] == MVars.PlayerTalkingID2 and LockFromScript == 4 then
							if Var8000[2] ~= 0 then
								LockFromScript = 7
								ScriptLoader.Loadscript(11)
							else
								TextSpeedWait = 3
							end
						end
						--If the other player denies your trade request
						if ReceiveDataSmall[5] == "DTRA" then console:log("RD: " .. ReceiveDataSmall[3] .. " PTID: " .. MVars.PlayerTalkingID .. " LFS: " .. LockFromScript) end
						if ReceiveDataSmall[5] == "DTRA" and ReceiveDataSmall[3] == MVars.PlayerTalkingID2 and LockFromScript == 5 then
							if Var8000[2] ~= 0 then
								LockFromScript = 7
								ScriptLoader.Loadscript(7)
							else
								TextSpeedWait = 4
							end
						end
						
						--If the other player refuses trade offer
						if ReceiveDataSmall[5] == "ROFF" and ReceiveDataSmall[3] == MVars.PlayerTalkingID2 and LockFromScript == 9 then
							OtherPlayerHasCancelled = 3
						end
						
						
						--SPOS
						if ReceiveDataSmall[5] == "SPOS" and ReceiveDataSmall[3] ~= PlayerID2 then
								MVars.PlayerIDNick[RECEIVEDID] = ReceiveDataSmall[2]
								if MVars.CurrentMapID[RECEIVEDID] ~= ReceiveDataSmall[14] then
									PlayerAnimationFrame[RECEIVEDID] = 0
									PlayerAnimationFrame2[RECEIVEDID] = 0
									PlayerAnimationFrameMax[RECEIVEDID] = 0
									MVars.CurrentMapID[RECEIVEDID] = ReceiveDataSmall[14]
									MVars.PreviousMapID[RECEIVEDID] = ReceiveDataSmall[15]
									MVars.MapEntranceType[RECEIVEDID] = ReceiveDataSmall[16]
									MVars.MapChange[RECEIVEDID] = 1
									MVars.PreviousX[RECEIVEDID] = MVars.CurrentX[RECEIVEDID]
									MVars.PreviousY[RECEIVEDID] = MVars.CurrentY[RECEIVEDID]
									MVars.CurrentX[RECEIVEDID] = ReceiveDataSmall[7]
									MVars.CurrentY[RECEIVEDID] = ReceiveDataSmall[8]
								end
								MVars.FutureX[RECEIVEDID] = ReceiveDataSmall[7]
								MVars.FutureY[RECEIVEDID] = ReceiveDataSmall[8]
								MVars.PlayerExtra1[RECEIVEDID] = ReceiveDataSmall[10]
								MVars.PlayerExtra2[RECEIVEDID] = ReceiveDataSmall[11]
								MVars.PlayerExtra3[RECEIVEDID] = ReceiveDataSmall[12]
								MVars.PlayerExtra4[RECEIVEDID] = ReceiveDataSmall[13]
								MVars.StartX[RECEIVEDID] = ReceiveDataSmall[18]
								MVars.StartY[RECEIVEDID] = ReceiveDataSmall[19]
						end
						--TIME
			--			if ReceiveDataSmall[5] == "TIME" then
			--				if PlayerTempVar1 == 2 then
			--					timeout1 = 5
			--				elseif PlayerTempVar1 == 3 then
			--					timeout2 = 5
			--				elseif PlayerTempVar1 == 4 then
			--					timeout3 = 5
			--				end
			--			end
						
						
						--If nickname doesn't already exist on server and request to join
						if ReceiveDataSmall[5] == "JOIN" then
						--	if (ReceiveDataSmall[2] ~= None) then if (ReceiveDataSmall[2] ~= MVars.PlayerIDNick[2] and ReceiveDataSmall[2] ~= Player3ID  and ReceiveDataSmall[2] ~= Player4ID) then
							if (ReceiveDataSmall[2] ~= "None") then
								local n = 1
								for i = 1, MaxPlayers do
									if n > 0 then
										if PlayerID ~= i and MVars.PlayerIDNick[i] == "None" then
											for i = 1, MaxPlayers do
												if (ReceiveDataSmall[2] == MVars.PlayerIDNick[i]) then
													ConsoleForText:moveCursor(0,4)
													ConsoleForText:print("A player that is already in the game is trying to join!                ")
													n = 0
												end
											end
											if n > 0 then
												if Connected == 0 then Connected = 1 end
												MVars.PlayerIDNick[i] = ReceiveDataSmall[2]
												console:log("Player " .. MVars.PlayerIDNick[i] .. " has successfully connected")
												AddPlayerToConsole(i)
												MVars.Players[i] = Clientell
											--	MVars.Players[i]:add("received",ReceiveData(MVars.Players[i]))
												MVars.PlayerVis[i] = 1
												PlayerAnimationFrame[i] = 0
												PlayerAnimationFrame2[i] = 0
												PlayerAnimationFrameMax[i] = 0
												MVars.CurrentX[i] = ReceiveDataSmall[7]
												MVars.CurrentY[i] = ReceiveDataSmall[8]
												MVars.MapChange[i] = 0
												MVars.MapID[i] = ReceiveDataSmall[14]
												MVars.PrevMapID[i] = ReceiveDataSmall[15]
												local NewPlayerID = i + 1000
												SendData("NewPlayer", MVars.Players[i], NewPlayerID)
												MVars.timeout[i] = timeoutmax
												n = 0
											end
										else
											if n > 0 then
												n = n + 1
											end
										end
										if n >= 1 and i == MaxPlayers then	
											ConsoleForText:moveCursor(0,4)
											ConsoleForText:print("A player is unable to join due to capacity limit.                ")
										--	console:log("Player " .. ReceiveDataSmall[2] .. " was unable to connect")
										end
									end
								end
							end
						end
				end
			end
		end
	end
end

function CreatePackettSpecial(RequestTemp, Socket2, OptionalData)
	if RequestTemp == "POKE" then
		MVars.PlayerReceiveID = MVars.PlayerTalkingID2
		PokemonTeamManager.GetPokemonTeam()
		local PokeTemp
		local StartNum = 0
		local StartNum2 = 0
		local Filler = "FFFFFFFFFFFFFFFFFF"
		for j = 1, 6 do
			for i = 1, 10 do
			StartNum = ((i - 1) * 25) + 1
			StartNum2 = StartNum + 24
			PokeTemp = string.sub(Pokemon[j],StartNum,StartNum2)
			Packett = GameID .. Nickname .. PlayerID2 .. MVars.PlayerReceiveID .. RequestTemp .. PokeTemp .. Filler .. "U"
			Socket2:send(Packett)
			end
		end
	elseif RequestTemp == "TRAD" then
		MVars.PlayerReceiveID = MVars.PlayerTalkingID2
		Packett = GameID .. Nickname .. PlayerID2 .. MVars.PlayerReceiveID .. RequestTemp .. TradeVars[1] .. TradeVars[2] .. TradeVars[3] .. TradeVars[5] .. "U"
		--4 + 4 + 4 + 4 + 4 + 3 + 40 + 1
		Socket2:send(Packett)
	elseif RequestTemp == "BATT" then
		MVars.PlayerReceiveID = MVars.PlayerTalkingID2
		local FillerSend = "100000000000000000000000000000000"
		Packett = GameID .. Nickname .. PlayerID2 .. MVars.PlayerReceiveID .. RequestTemp .. BattleVars[1] .. BattleVars[2] .. BattleVars[3] .. BattleVars[4] .. BattleVars[5] .. BattleVars[6] .. BattleVars[7] .. BattleVars[8] .. BattleVars[9] .. BattleVars[10] .. FillerSend .. "U"
	--	ConsoleForText:print("Packett: " .. Packett)
		Socket2:send(Packett)
	elseif RequestTemp == "SLNK" then
		MVars.PlayerReceiveID = MVars.PlayerTalkingID2
		OptionalData = OptionalData or 0
		local Filler = "100000000000000000000000000000000"
		local SizeAct = OptionalData + 1000000000
 --		SizeAct = tostring(SizeAct)
--		SizeAct = string.format("%.0f",SizeAct)
		Packett = GameID .. Nickname .. PlayerID2 .. MVars.PlayerReceiveID .. RequestTemp .. SizeAct .. Filler .. "U"
--		ConsoleForText:print("Packett: " .. Packett)
		Socket2:send(Packett)
	end
end
--Send Data to clients
function CreatePackett(RequestTemp, PackettTemp)
	local FillerStuff = "F"
	Packett = GameID .. Nickname .. PlayerID2 .. MVars.PlayerReceiveID .. RequestTemp .. PackettTemp .. MVars.CurrentX[PlayerID] .. MVars.CurrentY[PlayerID] .. MVars.Facing2[PlayerID] .. MVars.PlayerExtra1[PlayerID] .. MVars.PlayerExtra2[PlayerID] .. MVars.PlayerExtra3[PlayerID] .. MVars.PlayerExtra4[PlayerID] .. PVars.PlayerMapID .. PVars.PlayerMapIDPrev .. PVars.PlayerMapEntranceType .. MVars.StartX[PlayerID] .. MVars.StartY[PlayerID] .. FillerStuff .. "U"
end

function SendData(DataType, Socket, ExtraData)
	--If you have made a server
	if (DataType == "NewPlayer") then
		MVars.PlayerReceiveID = 1000
	--	ConsoleForText:print("Request accepted!")
		CreatePackett("STRT", ExtraData)
		Socket:send(Packett)
	elseif (DataType == "DENY") then
		CreatePackett("DENY", "1000")
		Socket:send(Packett)
	elseif (DataType == "KICK") then
		CreatePackett("KICK", "1000")
		Socket:send(Packett)
	elseif (DataType == "GPOS") then
		CreatePackett("GPOS", "1000")
		Socket:send(Packett)
	elseif (DataType == "SPOS") then
		CreatePackett("SPOS", "1000")
		Socket:send(Packett)
	elseif (DataType == "Request") then
		MVars.PlayerReceiveID = 1000
		CreatePackett("JOIN", "1000")
		Socket:send(Packett)
	elseif (DataType == "Hide") then
		CreatePackett("HIDE", "1000")
		Socket:send(Packett)
	elseif (DataType == "POKE") then
		MVars.PlayerReceiveID = MVars.PlayerTalkingID2
		CreatePackettSpecial("POKE",Socket)
	elseif (DataType == "RPOK") then
		MVars.PlayerReceiveID = MVars.PlayerTalkingID2
		local whiletempmax = 100000
		EnemyPokemon[1] = ""
		EnemyPokemon[2] = ""
		EnemyPokemon[3] = ""
		EnemyPokemon[4] = ""
		EnemyPokemon[5] = ""
		EnemyPokemon[6] = ""
		CreatePackett("RPOK", "1000")
		Socket:send(Packett)
		while (string.len(EnemyPokemon[6]) < 100 and whiletempmax > 0) do
			ReceiveData(Socket)
			ReceiveData(Socket)
			ReceiveData(Socket)
			ReceiveData(Socket)
			ReceiveData(Socket)
		whiletempmax = whiletempmax - 1
		end
	elseif (DataType == "RTRA") then
		MVars.PlayerReceiveID = MVars.PlayerTalkingID2
		CreatePackett("RTRA", "1000")
		Socket:send(Packett)
	elseif (DataType == "RBAT") then
		MVars.PlayerReceiveID = MVars.PlayerTalkingID2
		CreatePackett("RBAT", "1000")
		Socket:send(Packett)
	elseif (DataType == "STRA") then
		MVars.PlayerReceiveID = MVars.PlayerTalkingID2
		CreatePackett("STRA", "1000")
		Socket:send(Packett)
	elseif (DataType == "SBAT") then
		MVars.PlayerReceiveID = MVars.PlayerTalkingID2
		CreatePackett("SBAT", "1000")
		Socket:send(Packett)
	elseif (DataType == "DTRA") then
		MVars.PlayerReceiveID = MVars.PlayerTalkingID2
		CreatePackett("DTRA", "1000")
		Socket:send(Packett)
	elseif (DataType == "DBAT") then
		MVars.PlayerReceiveID = MVars.PlayerTalkingID2
		CreatePackett("DBAT", "1000")
		Socket:send(Packett)
	elseif (DataType == "CTRA") then
		MVars.PlayerReceiveID = MVars.PlayerTalkingID2
		CreatePackett("CTRA", "1000")
		Socket:send(Packett)
	elseif (DataType == "CBAT") then
		MVars.PlayerReceiveID = MVars.PlayerTalkingID2
		CreatePackett("CBAT", "1000")
		Socket:send(Packett)
	elseif (DataType == "TBUS") then
		MVars.PlayerReceiveID = MVars.PlayerTalkingID2
		CreatePackett("TBUS", "1000")
		Socket:send(Packett)
	elseif (DataType == "ROFF") then
		MVars.PlayerReceiveID = MVars.PlayerTalkingID2
		CreatePackett("ROFF", "1000")
		Socket:send(Packett)
	elseif (DataType == "TRAD") then
		MVars.PlayerReceiveID = MVars.PlayerTalkingID2
		CreatePackettSpecial("TRAD")
	elseif (DataType == "BATT") then
		MVars.PlayerReceiveID = MVars.PlayerTalkingID2
		CreatePackettSpecial("BATT")
	end
end


function ConnectNetwork()
	--To prevent package overrunning, sending will be every 20 frames, unlike recieve, which is every frame
	--Send timer
	--Receive timer
	local ReceiveTimer = ScriptTime % 1
	
	--If you have made a server
	if (MasterClient == "h") then
		
		if ReceiveTimer == 0 then
			--Receive data
			local PlayerData = SocketMain:accept()
			if (PlayerData ~= nil) then ReceiveData(PlayerData) end
		--	ReceiveData(PlayerData)
			for j = 1, MaxPlayers do
				for i = 1, MaxPlayers do
					if PlayerID ~= i and MVars.PlayerIDNick[i] ~= "None" then ReceiveData(MVars.Players[i]) end
				end
			end
		end
		

		--Request and send positions from all players
		if SendTimer == 0 then 
			
			for i = 1, MaxPlayers do
				if PlayerID ~= i and MVars.PlayerIDNick[i] ~= "None" then
				--	console:log("MVars.timeout for " .. MVars.PlayerIDNick[i] .. ": " .. MVars.timeout[i])
				--	console:log("Player: " .. i .. " Time left: " .. MVars.timeout[i])
					if MVars.timeout[i] > 0 then MVars.timeout[i] = MVars.timeout[i] - 4 end
					if MVars.timeout[i] <= 0 then
						console:log("Player " .. MVars.PlayerIDNick[i] .. " has timed out")
						RemovePlayerFromConsole(i)
						MVars.PlayerIDNick[i] = "None"
						ErasePlayer(i)
					--	MVars.Players[i]:remove("received",ReceiveData(MVars.Players[i]))
						MVars.Players[i]:close()
					end
					
				--	if MVars.PlayerIDNick[i] ~= "None" then SendData("GPOS", MVars.Players[i]) end
					if MVars.PlayerIDNick[i] ~= "None" then SendData("SPOS", MVars.Players[i]) end
				end
			end
		end
	end
end

--End Networking

function RandomizeNickname()
	local res = ""
	for i = 1, 4 do
		res = res .. string.char(math.random(97, 122))
	end
	return res
end

function Interact()
	local Keypress = emu:getKeys()
	local TalkingDirX = 0
	local TalkingDirY = 0
	local ScriptAddressTemp = 0
	local ScriptAddressTemp1 = 0
	local TooBusyByte = emu:read8(50335644)
	local AddressGet = ""
		
		--Hide n seek
		if LockFromScript == 1 then
			if Var8000[5] == 2 then
		--		ConsoleForText:print("Hide n' Seek selected")
				LockFromScript = 0
				ScriptLoader.Loadscript(3)
				Keypressholding = 1
				Keypress = 1
			
			elseif Var8000[5] == 1 then
		--		ConsoleForText:print("Hide n' Seek not selected")
				LockFromScript = 0
				ScriptLoader.Loadscript(3)
				Keypressholding = 1
				Keypress = 1
			end
		--Interaction Multi-choice
		elseif LockFromScript == 2 then
			if Var8000[1] ~= Var8000[14] then
				if Var8000[1] == 1 then
		--			ConsoleForText:print("Battle selected")
					FixAddress()
		--			LockFromScript = 4
		--			ScriptLoader.Loadscript(4)
					LockFromScript = 7
					ScriptLoader.Loadscript(3)
					Keypressholding = 1
					Keypress = 1
		--			SendData("RBAT", Player2)
				
				elseif Var8000[1] == 2 then
		--			ConsoleForText:print("Trade selected")
					FixAddress()
					LockFromScript = 5
					ScriptLoader.Loadscript(4)
					Keypressholding = 1
					Keypress = 1
					SendData("RTRA", MVars.Players[MVars.PlayerTalkingID])
				
				elseif Var8000[1] == 3 then
		--			ConsoleForText:print("Card selected")
					FixAddress()
					LockFromScript = 6
					ScriptLoader.Loadscript(3)
					Keypressholding = 1
					Keypress = 1
				
				elseif Var8000[1] ~= 0 then
		--			ConsoleForText:print("Exit selected")
					FixAddress()
					LockFromScript = 0
					Keypressholding = 1
					Keypress = 1
				end
			end
		end
	if Keypress ~= 0 then
		if Keypress == 1 or Keypress == 65 or Keypress == 129 or Keypress == 33 or Keypress == 17 then
	--		ConsoleForText:print("Pressed A")
	
			--SCRIPTS. LOCK AND PREVENT SPAM PRESS. 
			if LockFromScript == 0 and Keypressholding == 0 and TooBusyByte == 0 then
				--HIDE N SEEK AT DESK IN ROOM
				if MasterClient == "h" and PVars.PlayerDirection == 3 and PlayerMapX == 1009 and PlayerMapY == 1009 and PVars.PlayerMapID == 100260 then
				--Server config through bedroom drawer
					--For temp ram to load up script in 145227776 - 08A80000
					--8004 is the temp var to get yes or no
					ScriptLoader.Loadscript(1)
					LockFromScript = 1
				end
				--Interact with players
				for i = 1, MaxPlayers do
					if PlayerID ~= i and MVars.PlayerIDNick[i] ~= "None" then
						TalkingDirX = PlayerMapX - MVars.CurrentX[i]
						TalkingDirY = PlayerMapY - MVars.CurrentY[i]
						if PVars.PlayerDirection == 1 and TalkingDirX == 1 and TalkingDirY == 0 then
					--		ConsoleForText:print("Player Left")
							
						elseif PVars.PlayerDirection == 2 and TalkingDirX == -1 and TalkingDirY == 0 then
					--		ConsoleForText:print("Player Right")
						elseif PVars.PlayerDirection == 3 and TalkingDirY == 1 and TalkingDirX == 0 then
					--		ConsoleForText:print("Player Up")
						elseif PVars.PlayerDirection == 4 and TalkingDirY == -1 and TalkingDirX == 0 then
					--		ConsoleForText:print("Player Down")
						end
						if (PVars.PlayerDirection == 1 and TalkingDirX == 1 and TalkingDirY == 0) or (PVars.PlayerDirection == 2 and TalkingDirX == -1 and TalkingDirY == 0) or (PVars.PlayerDirection == 3 and TalkingDirX == 0 and TalkingDirY == 1) or (PVars.PlayerDirection == 4 and TalkingDirX == 0 and TalkingDirY == -1) then
						
					--		ConsoleForText:print("Player Any direction")
							emu:write16(Var8000Adr[1], 0) 
							emu:write16(Var8000Adr[2], 0) 
							emu:write16(Var8000Adr[14], 0)
							MVars.PlayerTalkingID = i
							MVars.PlayerTalkingID2 = i + 1000
							LockFromScript = 2
							ScriptLoader.Loadscript(2)
						end
					end
				end
			end
			Keypressholding = 1
		elseif Keypress == 2 then
			if LockFromScript == 4 and Keypressholding == 0 and Var8000[2] ~= 0 then
				--Cancel battle request
				ScriptLoader.Loadscript(15)
				SendData("CBAT",MVars.Players[MVars.PlayerTalkingID])
				LockFromScript = 0
			elseif LockFromScript == 5 and Keypressholding == 0 and Var8000[2] ~= 0 then
				--Cancel trade request
				ScriptLoader.Loadscript(16)
					SendData("CTRA",MVars.Players[MVars.PlayerTalkingID])
				LockFromScript = 0
				TradeVars[1] = 0
				TradeVars[2] = 0
				TradeVars[3] = 0
				OtherPlayerHasCancelled = 0
			elseif LockFromScript == 9 and (TradeVars[1] == 2 or TradeVars[1] == 4) and Keypressholding == 0 and Var8000[2] ~= 0 then
				--Cancel trade request
				ScriptLoader.Loadscript(16)
				SendData("CTRA",MVars.Players[MVars.PlayerTalkingID])
				LockFromScript = 0
				TradeVars[1] = 0
				TradeVars[2] = 0
				TradeVars[3] = 0
				OtherPlayerHasCancelled = 0
			end
			Keypressholding = 1
		elseif Keypress == 4 then
	--		GetPokemonTeam()
	--		SetEnemyPokemonTeam()
	--		ConsoleForText:print("Pressed Select")
		elseif Keypress == 8 then
	--		ConsoleForText:print("Pressed Start")
		elseif Keypress == 16 then
	--		ConsoleForText:print("Pressed Right")
		elseif Keypress == 32 then
	--		ConsoleForText:print("Pressed Left")
		elseif Keypress == 64 then
	--		ConsoleForText:print("Pressed Up")
		elseif Keypress == 128 then
	--		ConsoleForText:print("Pressed Down")
		elseif Keypress == 256 then
		--	if LockFromScript == 0 and Keypressholding == 0 then
		--	ConsoleForText:print("Pressed R-Trigger")
			--	ApplyMovement(0)
		--		emu:write16(Var8001Adr, 0) 
			--	BufferString = MVars.PlayerIDNick[2]
		--		ScriptLoader.Loadscript(12)
		--		LockFromScript = 5
		--		local TestString = ReadBuffers(33692880, 4)
		--		WriteBuffers(33692912, TestString, 4)
			--	ConsoleForText:print("String: " .. TestString)
			
		--		SendData("RPOK",Player2)
		--		if EnemyPokemon[6] ~= 0 then
		--			SetEnemyPokemonTeam(0,1)
		--		end
				
			--	LockFromScript = 8
		--		SendMultiplayerPackets(0,256,Player2)
		--	ScriptLoader.Loadscript(17)
		--	end
			Keypressholding = 1
		elseif Keypress == 512 then
	--		ConsoleForText:print("Pressed L-Trigger")
	--		ScriptLoader.Loadscript(22)
		end
	else
		Keypressholding = 0
	end
end

function mainLoop()

	FFTimer = os.time() - FFTimer2
	FFTimer = math.floor(FFTimer)
	ScriptTime = ScriptTime + 1
	SendTimer = ScriptTime % ScriptTimeFrame
	
	if FFTimer > FramesPS then
		--This is our framerate
		local ScriptTimeSpeed = ScriptTime - ScriptTimePrev
		ScriptTimePrev = ScriptTime
		
		if ScriptTimeSpeed < 100 then
			ScriptTimeFrame = 4
		elseif ScriptTimeSpeed < 200 then
			ScriptTimeFrame = 10
		elseif ScriptTimeSpeed < 300 then
			ScriptTimeFrame = 16
		elseif ScriptTimeSpeed < 400 then
			ScriptTimeFrame = 22
		elseif ScriptTimeSpeed < 500 then
			ScriptTimeFrame = 28
		elseif ScriptTimeSpeed < 600 then
			ScriptTimeFrame = 34
		elseif ScriptTimeSpeed < 700 then
			ScriptTimeFrame = 40
		elseif ScriptTimeSpeed < 800 then
			ScriptTimeFrame = 46
		elseif ScriptTimeSpeed < 900 then
			ScriptTimeFrame = 52
		elseif ScriptTimeSpeed >= 900 then
			ScriptTimeFrame = 60
		else
			ScriptTimeFrame = 4
		end
	end
	
	FramesPS = FFTimer
	if initialized == 0 and EnableScript == true then
		ROMCARD = emu.memory.cart0
		initialized = 1
		GetPosition()
	--	ScriptLoader.Loadscript(0)
		if Nickname == "" then
			Nickname = RandomizeNickname()
		end
		ConsoleForText:moveCursor(0,2)
		ConsoleForText:print("Nickname is now " .. Nickname)
			
		CreateNetwork()
		ConsoleForText:moveCursor(0,4)
	elseif EnableScript == true then
			--Debugging
			TempVar2 = ScriptTime % DebugTime2
			local TempVarTimer = ScriptTime % DebugTime
			if TempVarTimer == 0 then
			end
			--Update once every frame
			TempVarTimer = ScriptTime % DebugTime3
			if TempVarTimer == 0 then
				GetPosition()
				ConnectNetwork()
			end
			--Create a network if not made every half
			TempVarTimer = ScriptTime % DebugTime2
			if TempVarTimer == 0 then
				if MasterClient == "a" then
					ConsoleForText:moveCursor(0,3)
					CreateNetwork()
					ConsoleForText:moveCursor(0,4)
				elseif MasterClient == "h" then
					for i = 1, MaxPlayers do
						if MVars.PlayerIDNick[i] ~= "None" then AddPlayerToConsole(i) end
					end
				end
			end
							--VARS--
		if GameID == "BPR1" or GameID == "BPR2" then
			Startvaraddress = 33779896
		elseif GameID == "BPG1" or GameID == "BPG2" then
			Startvaraddress = 33779896
		end
		Var8000Adr[1] = Startvaraddress
		Var8000Adr[2] = Startvaraddress + 2
		Var8000Adr[3] = Startvaraddress + 4
		Var8000Adr[4] = Startvaraddress + 6
		Var8000Adr[5] = Startvaraddress + 8
		Var8000Adr[6] = Startvaraddress + 10
		Var8000Adr[14] = Startvaraddress + 26
		Var8000[1] = emu:read16(Var8000Adr[1])
		Var8000[2] = emu:read16(Var8000Adr[2])
		Var8000[3] = emu:read16(Var8000Adr[3])
		Var8000[4] = emu:read16(Var8000Adr[4])
		Var8000[5] = emu:read16(Var8000Adr[5])
		Var8000[6] = emu:read16(Var8000Adr[6])
		Var8000[14] = emu:read16(Var8000Adr[14])
		Var8000[1] = tonumber(Var8000[1])
		Var8000[2] = tonumber(Var8000[2])
		Var8000[3] = tonumber(Var8000[3])
		Var8000[4] = tonumber(Var8000[4])
		Var8000[5] = tonumber(Var8000[5])
		Var8000[6] = tonumber(Var8000[6])
		Var8000[14] = tonumber(Var8000[14])
			
						--BATTLE/TRADE--
			
		--	if TempVar2 == 0 then ConsoleForText:print("OtherPlayerCanceled: " .. OtherPlayerHasCancelled) end
			
			--If you cancel/stop
			if LockFromScript == 0 then
				MVars.PlayerTalkingID = 0
			end
			
			--Wait until other player accepts battle
			if LockFromScript == 4 then
				if Var8000[2] ~= 0 then
					if TextSpeedWait == 1 then
						TextSpeedWait = 0
						LockFromScript = 8
						ScriptLoader.Loadscript(13)
					elseif TextSpeedWait == 3 then
						TextSpeedWait = 0
						LockFromScript = 7
						ScriptLoader.Loadscript(11)
					elseif TextSpeedWait == 5 then
						TextSpeedWait = 0
						LockFromScript = 7
						ScriptLoader.Loadscript(20)
					end
				end
--				if SendTimer == 0 then SendData("RBAT") end
				
			--Wait until other player accepts trade
			elseif LockFromScript == 5 then
				if Var8000[2] ~= 0 then
					if TextSpeedWait == 2 then
						TextSpeedWait = 0
						LockFromScript = 9
					elseif TextSpeedWait == 4 then
						TextSpeedWait = 0
						LockFromScript = 7
						ScriptLoader.Loadscript(7)
					elseif TextSpeedWait == 6 then
						TextSpeedWait = 0
						LockFromScript = 7
						ScriptLoader.Loadscript(21)
					end
				end
				
			--Show card. Placeholder for now
			elseif LockFromScript == 6 then
				if Var8000[2] ~= 0 then
		--			ConsoleForText:print("Var 8001: " .. Var8000[2])
					LockFromScript = 0
				--	if SendTimer == 0 then SendData("RTRA") end
				end
				
			--Exit message
			elseif LockFromScript == 7 then
				if Var8000[2] ~= 0 then LockFromScript = 0 Keypressholding = 1 end
			
			--Battle script
			elseif LockFromScript == 8 then
			
				Battlescript()
			
			--Trade script
			elseif LockFromScript == 9 then
			
				Tradescript()
			
			
			--Player 2 has requested to battle
			elseif LockFromScript == 12 then
		--	if Var8000[2] ~= 0 then ConsoleForText:print("Var8001: " .. Var8000[2]) end
				if Var8000[2] == 2 then
					if OtherPlayerHasCancelled == 0 then
						SendData("RPOK", MVars.Players[MVars.PlayerTalkingID])
						SendData("SBAT", MVars.Players[MVars.PlayerTalkingID])
						LockFromScript = 8
						ScriptLoader.Loadscript(13)
					else
						OtherPlayerHasCancelled = 0
						LockFromScript = 7
						ScriptLoader.Loadscript(18)
					end
				elseif Var8000[2] == 1 then LockFromScript = 0 SendData("DBAT", MVars.Players[MVars.PlayerTalkingID]) Keypressholding = 1 end
				
			--Player 2 has requested to trade
			elseif LockFromScript == 13 then
		--	if Var8000[2] ~= 0 then ConsoleForText:print("Var8001: " .. Var8000[2]) end
				--If accept, then send that you accept
				if Var8000[2] == 2 then
					if OtherPlayerHasCancelled == 0 then
						SendData("RPOK", MVars.Players[MVars.PlayerTalkingID])
						SendData("STRA", MVars.Players[MVars.PlayerTalkingID])
						LockFromScript = 9
					else
						OtherPlayerHasCancelled = 0
						LockFromScript = 7
						ScriptLoader.Loadscript(19)
					end
				elseif Var8000[2] == 1 then LockFromScript = 0 SendData("DTRA", MVars.Players[MVars.PlayerTalkingID]) Keypressholding = 1 end
			end
	end
end

console:log("Started GBA-PK_Server.lua")
if not (emu == nil) then
	if ConsoleForText == nil then ConsoleForText = console:createBuffer("GBA-PK SERVER") end
	ConsoleForText:clear()
	ConsoleForText:moveCursor(0,1)
	FFTimer2 = os.time()
	GameChecker.GetGameVersion()
end

--SocketMain:add("received", ConnectNetwork)
--Player2:add("received", Player2Network)
--Player3:add("received", Player3Network)
--Player4:add("received", Player4Network)
callbacks:add("reset", GetNewGame)
callbacks:add("shutdown", shutdownGame)
callbacks:add("frame", mainLoop)
callbacks:add("frame", DrawChars)


callbacks:add("keysRead", Interact)