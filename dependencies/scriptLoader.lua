local MVars = require "multiplayerVars"
local Globals = require "globalVars"

local addressVersion = {
    ["BPR1"] =  138282176,
    ["BPR2"] =  138282288,
    ["BPG1"] =  138281724,
    ["BPG2"] =  138281836
}
local scripts = {

}
local mod = {}

function mod.Loadscript(ScriptNo)
	local ScriptAddressTemp = 0
	local ScriptAddressTemp1 = 0
	--2 is where the script itself is, whereas 1 is the memory to force it to read that. 3 is an extra address to use alongside it, such as multi-choice
	local u32 ScriptAddress2 = 145227776
	
	local u32 ScriptAddress3 = 145227712
	
	local MultichoiceAdr2 = ScriptAddress3 - 32
	local TextToNum = 0
	local NickNameNum
	local Buffer = {0,0,0,0}
	local Buffer1 = 33692880
	local Buffer2 = 33692912
	local Buffer3 = 33692932
	local MultichoiceAdr = addressVersion[Globals.GameID] and addressVersion[Globals.GameID] or 0
	
    --Convert 4-byte buffer to readable bytes in case its needed
    TextToNum = 0
    for i = 1, 4 do
        NickNameNum = string.sub(MVars.PlayerIDNick[MVars.PlayerTalkingID],i,i)
        NickNameNum = string.byte(NickNameNum)
        NickNameNum = tonumber(NickNameNum)

        if NickNameNum > 64 and NickNameNum < 93 then
            NickNameNum = NickNameNum + 122
        
        elseif NickNameNum > 92 and NickNameNum < 128 then
            NickNameNum = NickNameNum + 116
        else
            NickNameNum = NickNameNum + 113
        end
        Buffer[i] = NickNameNum
        if Buffer[i] == "" or Buffer[i] == nil then Buffer[i] = "A" end
    end
			
    if ScriptNo == 0 then
        ScriptAddressTemp = ScriptAddress2
        ScriptAddressTemp1 = 4294902380
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
        --		mod.LoadScriptIntoMemory()
    --Host script
    elseif ScriptNo == 1 then
        emu:write16(Globals.Var8000Adr[2], 0) 
        emu:write16(Globals.Var8000Adr[5], 0) 
        ScriptAddressTemp = ScriptAddress2
        ScriptAddressTemp1 = 603983722
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 151562240
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 2148344069
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 17170433
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 145227804
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 25166870
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 4278348800
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 41944086
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 4278348800
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 3773424593
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 3823960280
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 3722445033
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 3892369887
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 3805872355
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 3655390933
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 3638412030
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 3034710233
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 3654929664
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 16755935
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
        mod.LoadScriptIntoMemory()
    --Interaction Menu	Multi Choice
    elseif ScriptNo == 2 then
        emu:write16(Globals.Var8000Adr[1], 0) 
        emu:write16(Globals.Var8000Adr[2], 0) 
        emu:write16(Globals.Var8000Adr[14], 0) 
        ScriptAddressTemp = ScriptAddress2
        ScriptAddressTemp1 = 1664873
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 1868957864
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 132117
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 226492441
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 2147489664
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 40566785
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 3588018687
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
        --Printing in the bottom box
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 3823829224
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 14213353
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 15328237
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 3655327200
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 14936318
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 3942704088
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 14477533
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 4289463293
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 4294967040
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
        --For buffer 2 ["nick"?]
        ScriptAddressTemp = Buffer2
        ScriptAddressTemp1 = Buffer[1]
        emu:write8(ScriptAddressTemp, ScriptAddressTemp1)
        ScriptAddressTemp = Buffer2 + 1
        ScriptAddressTemp1 = Buffer[2]
        emu:write8(ScriptAddressTemp, ScriptAddressTemp1)
        ScriptAddressTemp = Buffer2 + 2
        ScriptAddressTemp1 = Buffer[3]
        emu:write8(ScriptAddressTemp, ScriptAddressTemp1)
        ScriptAddressTemp = Buffer2 + 3
        ScriptAddressTemp1 = Buffer[4]
        emu:write8(ScriptAddressTemp, ScriptAddressTemp1)
        ScriptAddressTemp = Buffer2 + 4
        ScriptAddressTemp1 = 255
        emu:write8(ScriptAddressTemp, ScriptAddressTemp1)
        --First save multichoice in case it's needed later
        PrevExtraAdr = Globals.ROMCARD:read32(MultichoiceAdr)
        --Overwrite multichoice 0x2 with a custom at address MultichoiceAdr2
        ScriptAddressTemp = MultichoiceAdr
        ScriptAddressTemp1 = MultichoiceAdr2
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
        --Multi-Choice box and cursor
        ScriptAddressTemp = MultichoiceAdr2
        ScriptAddressTemp1 = ScriptAddress3
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
        ScriptAddressTemp = ScriptAddressTemp + 4
        ScriptAddressTemp1 = 0
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = ScriptAddress3 + 7
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
        ScriptAddressTemp = ScriptAddressTemp + 4
        ScriptAddressTemp1 = 0
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
        ScriptAddressTemp = ScriptAddressTemp + 4
        ScriptAddressTemp1 = ScriptAddress3 + 13
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
        ScriptAddressTemp = ScriptAddressTemp + 4
        ScriptAddressTemp1 = 0
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
        ScriptAddressTemp = ScriptAddressTemp + 4
        ScriptAddressTemp1 = ScriptAddress3 + 18
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
        ScriptAddressTemp = ScriptAddressTemp + 4
        ScriptAddressTemp1 = 0
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
        --Text of multi choice menu
        ScriptAddressTemp = ScriptAddress3
        ScriptAddressTemp1 = 3907573180
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
        ScriptAddressTemp = ScriptAddressTemp + 4
        ScriptAddressTemp1 = 3472873952
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
        ScriptAddressTemp = ScriptAddressTemp + 4
        ScriptAddressTemp1 = 3654866406
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
        ScriptAddressTemp = ScriptAddressTemp + 4
        ScriptAddressTemp1 = 3872767487
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
        ScriptAddressTemp = ScriptAddressTemp + 4
        ScriptAddressTemp1 = 3972005848
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
        ScriptAddressTemp = ScriptAddressTemp + 4
        ScriptAddressTemp1 = 4294961373
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
        mod.LoadScriptIntoMemory()
    --Placeholder
    elseif ScriptNo == 3 then
        emu:write16(Globals.Var8000Adr[2], 0) 
        ScriptAddressTemp = ScriptAddress2
        ScriptAddressTemp1 = 285216618
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 151562240
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 2147554822
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 40632321
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 3907242239
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 3689078236
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 3839220736
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 3655522788
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 16756952
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 4294967295
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
        mod.LoadScriptIntoMemory()
    --Waiting message
    elseif ScriptNo == 4 then
        emu:write16(Globals.Var8000Adr[2], 0) 
        ScriptAddressTemp = ScriptAddress2
        ScriptAddressTemp1 = 1271658
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 375785640
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 5210113
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 654415909
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 3523150444
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 3723025877
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 3657489378
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 3808487139
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 3873037544
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 3588285440
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 2967919085
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 4294902015
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
        mod.LoadScriptIntoMemory()
    --Cancel message
    elseif ScriptNo == 5 then
        emu:write16(Globals.Var8000Adr[2], 0) 
        ScriptAddressTemp = ScriptAddress2
        ScriptAddressTemp1 = 285216618
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 151562240
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 2147554822
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 40632325
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 3655126783
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 3706249984
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 3825264345
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 3656242656
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 3587965158
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 3587637479
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 3772372962
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 4289583321
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)  
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 4294967040
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
        mod.LoadScriptIntoMemory()
    --Trade request
    elseif ScriptNo == 6 then
        emu:write16(Globals.Var8000Adr[2], 0) 
        ScriptAddressTemp = ScriptAddress2
        ScriptAddressTemp1 = 469765994
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 151562240
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 2148344069
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 393217
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 145227850
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 41943318
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 4278348800
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 3942646781
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 3655133149
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 3823632615
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 3588679680
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 3942701528
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)  
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 14477533
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 2917786605
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 14925566
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 15328237
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 3654801365
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 4289521892
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 18284288
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 1811939712
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 4294967042
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
        mod.LoadScriptIntoMemory()
        --For buffer 2
        ScriptAddressTemp = 33692912
        ScriptAddressTemp1 = Buffer[1]
        emu:write8(ScriptAddressTemp, ScriptAddressTemp1)
        ScriptAddressTemp = 33692912 + 1
        ScriptAddressTemp1 = Buffer[2]
        emu:write8(ScriptAddressTemp, ScriptAddressTemp1)
        ScriptAddressTemp = 33692912 + 2
        ScriptAddressTemp1 = Buffer[3]
        emu:write8(ScriptAddressTemp, ScriptAddressTemp1)
        ScriptAddressTemp = 33692912 + 3
        ScriptAddressTemp1 = Buffer[4]
        emu:write8(ScriptAddressTemp, ScriptAddressTemp1)
        ScriptAddressTemp = 33692912 + 4
        ScriptAddressTemp1 = 255
        emu:write8(ScriptAddressTemp, ScriptAddressTemp1)
    --Trade request denied
    elseif ScriptNo == 7 then
        emu:write16(Globals.Var8000Adr[2], 0) 
        ScriptAddressTemp = ScriptAddress2
        ScriptAddressTemp1 = 285216618
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 151562240
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 2147554822
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 40632321
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 3655126783
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 3706249984
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 3825264345
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 3656242656
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 3822584038
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 3808356313
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 3942705379
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 14477277
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)  
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 3892372456
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 3654866406
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 4278255533
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
        mod.LoadScriptIntoMemory()
    --Trade offer
    elseif ScriptNo == 8 then
        emu:write16(Globals.Var8000Adr[2], 0) 
        ScriptAddressTemp = ScriptAddress2
        ScriptAddressTemp1 = 469765994
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 151562240
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 2148344069
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 393217
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 145227866
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 41943318
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 4278348800
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 15328211
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 3656046044
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 3671778048
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 3638159065
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 2902719744
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)  
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 3655126782
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 3587965165
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 3808483818
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 3873037018
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 4244691161
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 3522931970
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 14737629
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 15328237
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 3654801365
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 4289521892
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 18284288
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 1811939712
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 4294967042
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
        mod.LoadScriptIntoMemory()
    --Trade offer denied
    elseif ScriptNo == 9 then
        emu:write16(Globals.Var8000Adr[2], 0) 
        ScriptAddressTemp = ScriptAddress2
        ScriptAddressTemp1 = 285216618
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 151562240
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 2147554822
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 40632321
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 3655126783
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 3588679680
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 3691043288
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 3590383573
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 14866905
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 3772242392
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 3638158045
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 4278255533
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
        mod.LoadScriptIntoMemory()
    --Battle request
    elseif ScriptNo == 10 then
        emu:write16(Globals.Var8000Adr[2], 0) 
        ScriptAddressTemp = ScriptAddress2
        ScriptAddressTemp1 = 469765994
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 151562240
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 2148344069
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 393217
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 145227846
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 41943318
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 4278348800
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 3942646781
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 3655133149
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 3823632615
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 3906328064
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 14278888
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 2917786605
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 14925566
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 15328237
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 3654801365
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 4289521892
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 18284288
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 1811939712
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 4294967042
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
        mod.LoadScriptIntoMemory()
        --For buffer 2
        ScriptAddressTemp = 33692912
        ScriptAddressTemp1 = Buffer[1]
        emu:write8(ScriptAddressTemp, ScriptAddressTemp1)
        ScriptAddressTemp = 33692912 + 1
        ScriptAddressTemp1 = Buffer[2]
        emu:write8(ScriptAddressTemp, ScriptAddressTemp1)
        ScriptAddressTemp = 33692912 + 2
        ScriptAddressTemp1 = Buffer[3]
        emu:write8(ScriptAddressTemp, ScriptAddressTemp1)
        ScriptAddressTemp = 33692912 + 3
        ScriptAddressTemp1 = Buffer[4]
        emu:write8(ScriptAddressTemp, ScriptAddressTemp1)
        ScriptAddressTemp = 33692912 + 4
        ScriptAddressTemp1 = 255
        emu:write8(ScriptAddressTemp, ScriptAddressTemp1)
    --Battle request denied
    elseif ScriptNo == 11 then
        emu:write16(Globals.Var8000Adr[2], 0) 
        ScriptAddressTemp = ScriptAddress2
        ScriptAddressTemp1 = 285216618
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 151562240
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 2147554822
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 40632321
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 3655126783
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 3706249984
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 3825264345
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 3656242656
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 3822584038
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 3808356313
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 3942705379
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 14477277
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 3590382568
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 3773360341
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 16756185
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
        ScriptAddressTemp = ScriptAddressTemp + 4 
        ScriptAddressTemp1 = 4294967295
        Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
        mod.LoadScriptIntoMemory()
    --Select Pokemon for trade
        elseif ScriptNo == 12 then
            emu:write16(Globals.Var8000Adr[1], 0) 
            emu:write16(Globals.Var8000Adr[2], 0) 
            emu:write16(Globals.Var8000Adr[4], 0) 
            emu:write16(Globals.Var8000Adr[5], 0) 
            emu:write16(Globals.Var8000Adr[14], 0) 
            ScriptAddressTemp = ScriptAddress2
            ScriptAddressTemp1 = 10429802
            Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
            ScriptAddressTemp = ScriptAddressTemp + 4 
            ScriptAddressTemp1 = 2147754279
            Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
            ScriptAddressTemp = ScriptAddressTemp + 4 
            ScriptAddressTemp1 = 67502086
            Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
            ScriptAddressTemp = ScriptAddressTemp + 4 
            ScriptAddressTemp1 = 145227809
            Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
            ScriptAddressTemp = ScriptAddressTemp + 4 
            ScriptAddressTemp1 = 1199571750
            Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
            ScriptAddressTemp = ScriptAddressTemp + 4 
            ScriptAddressTemp1 = 50429185
            Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
            ScriptAddressTemp = ScriptAddressTemp + 4 
            ScriptAddressTemp1 = 2147554944
            Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
            ScriptAddressTemp = ScriptAddressTemp + 4 
            ScriptAddressTemp1 = 40632322
            Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
            ScriptAddressTemp = ScriptAddressTemp + 4 
            ScriptAddressTemp1 = 2147555071
            Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
            ScriptAddressTemp = ScriptAddressTemp + 4 
            ScriptAddressTemp1 = 40632321
            Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
            ScriptAddressTemp = ScriptAddressTemp + 4 
            ScriptAddressTemp1 = 4294967295
            Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
            mod.LoadScriptIntoMemory()
    --Battle will start
        elseif ScriptNo == 13 then
            emu:write16(Globals.Var8000Adr[2], 0)
            ScriptAddressTemp = ScriptAddress2
            ScriptAddressTemp1 = 1416042
            Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
            ScriptAddressTemp = ScriptAddressTemp + 4 
            ScriptAddressTemp1 = 627443880
            Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
            ScriptAddressTemp = ScriptAddressTemp + 4 
            ScriptAddressTemp1 = 1009254542
            Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
            ScriptAddressTemp = ScriptAddressTemp + 4 
            ScriptAddressTemp1 = 2147554816
            Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
            ScriptAddressTemp = ScriptAddressTemp + 4 
            ScriptAddressTemp1 = 40632322
            Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
            ScriptAddressTemp = ScriptAddressTemp + 4 
            ScriptAddressTemp1 = 3924022271
            Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
            ScriptAddressTemp = ScriptAddressTemp + 4 
            ScriptAddressTemp1 = 3587571942
            Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
            ScriptAddressTemp = ScriptAddressTemp + 4 
            ScriptAddressTemp1 = 3655395560
            Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
            ScriptAddressTemp = ScriptAddressTemp + 4 
            ScriptAddressTemp1 = 3772640000
            Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
            ScriptAddressTemp = ScriptAddressTemp + 4 
            ScriptAddressTemp1 = 3823239392
            Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
            ScriptAddressTemp = ScriptAddressTemp + 4 
            ScriptAddressTemp1 = 3654680811
            Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
            ScriptAddressTemp = ScriptAddressTemp + 4 
            ScriptAddressTemp1 = 2917326299
            Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
            ScriptAddressTemp = ScriptAddressTemp + 4 
            ScriptAddressTemp1 = 4294902015
            Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
            mod.LoadScriptIntoMemory()
    --Trade will start
        elseif ScriptNo == 14 then
            emu:write16(Globals.Var8000Adr[2], 0)
            ScriptAddressTemp = ScriptAddress2
            ScriptAddressTemp1 = 1416042
            Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
            ScriptAddressTemp = ScriptAddressTemp + 4 
            ScriptAddressTemp1 = 627443880
            Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
            ScriptAddressTemp = ScriptAddressTemp + 4 
            ScriptAddressTemp1 = 1009254542
            Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
            ScriptAddressTemp = ScriptAddressTemp + 4 
            ScriptAddressTemp1 = 2147554816
            Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
            ScriptAddressTemp = ScriptAddressTemp + 4 
            ScriptAddressTemp1 = 40632322
            Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
            ScriptAddressTemp = ScriptAddressTemp + 4 
            ScriptAddressTemp1 = 3924022271
            Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
            ScriptAddressTemp = ScriptAddressTemp + 4 
            ScriptAddressTemp1 = 3873964262
            Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
            ScriptAddressTemp = ScriptAddressTemp + 4 
            ScriptAddressTemp1 = 14276821
            Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
            ScriptAddressTemp = ScriptAddressTemp + 4 
            ScriptAddressTemp1 = 3772833259
            Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
            ScriptAddressTemp = ScriptAddressTemp + 4 
            ScriptAddressTemp1 = 3957580288
            Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
            ScriptAddressTemp = ScriptAddressTemp + 4 
            ScriptAddressTemp1 = 3688486400
            Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
            ScriptAddressTemp = ScriptAddressTemp + 4 
            ScriptAddressTemp1 = 4289585885
            Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
            ScriptAddressTemp = ScriptAddressTemp + 4 
            ScriptAddressTemp1 = 4294967040
            Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
            mod.LoadScriptIntoMemory()
    --You have canceled the battle
        elseif ScriptNo == 15 then
            emu:write16(Globals.Var8000Adr[2], 0)
            ScriptAddressTemp = ScriptAddress2
            ScriptAddressTemp1 = 285216618
            Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
            ScriptAddressTemp = ScriptAddressTemp + 4 
            ScriptAddressTemp1 = 151562240
            Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
            ScriptAddressTemp = ScriptAddressTemp + 4 
            ScriptAddressTemp1 = 2147554822
            Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
            ScriptAddressTemp = ScriptAddressTemp + 4 
            ScriptAddressTemp1 = 40632326
            Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
            ScriptAddressTemp = ScriptAddressTemp + 4 
            ScriptAddressTemp1 = 3924022271
            Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
            ScriptAddressTemp = ScriptAddressTemp + 4 
            ScriptAddressTemp1 = 3939884032
            Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
            ScriptAddressTemp = ScriptAddressTemp + 4 
            ScriptAddressTemp1 = 3587637465
            Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
            ScriptAddressTemp = ScriptAddressTemp + 4 
            ScriptAddressTemp1 = 3772372962
            Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
            ScriptAddressTemp = ScriptAddressTemp + 4 
            ScriptAddressTemp1 = 14211552
            Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
            ScriptAddressTemp = ScriptAddressTemp + 4 
            ScriptAddressTemp1 = 14277864
            Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
            ScriptAddressTemp = ScriptAddressTemp + 4 
            ScriptAddressTemp1 = 3907573206
            Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
            ScriptAddressTemp = ScriptAddressTemp + 4 
            ScriptAddressTemp1 = 4289583584
            Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
            ScriptAddressTemp = ScriptAddressTemp + 4 
            ScriptAddressTemp1 = 4294967040
            Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
            mod.LoadScriptIntoMemory()
    --You have canceled the trade
        elseif ScriptNo == 16 then
            emu:write16(Globals.Var8000Adr[2], 0)
            ScriptAddressTemp = ScriptAddress2
            ScriptAddressTemp1 = 285216618
            Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
            ScriptAddressTemp = ScriptAddressTemp + 4 
            ScriptAddressTemp1 = 151562240
            Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
            ScriptAddressTemp = ScriptAddressTemp + 4 
            ScriptAddressTemp1 = 2147554822
            Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
            ScriptAddressTemp = ScriptAddressTemp + 4 
            ScriptAddressTemp1 = 40632326
            Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
            ScriptAddressTemp = ScriptAddressTemp + 4 
            ScriptAddressTemp1 = 3924022271
            Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
            ScriptAddressTemp = ScriptAddressTemp + 4 
            ScriptAddressTemp1 = 3939884032
            Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
            ScriptAddressTemp = ScriptAddressTemp + 4 
            ScriptAddressTemp1 = 3587637465
            Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
            ScriptAddressTemp = ScriptAddressTemp + 4 
            ScriptAddressTemp1 = 3772372962
            Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
            ScriptAddressTemp = ScriptAddressTemp + 4 
            ScriptAddressTemp1 = 14211552
            Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
            ScriptAddressTemp = ScriptAddressTemp + 4 
            ScriptAddressTemp1 = 14277864
            Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
            ScriptAddressTemp = ScriptAddressTemp + 4 
            ScriptAddressTemp1 = 3637896936
            Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
            ScriptAddressTemp = ScriptAddressTemp + 4 
            ScriptAddressTemp1 = 16756185
            Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
            ScriptAddressTemp = ScriptAddressTemp + 4 
            ScriptAddressTemp1 = 4294967295
            Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
            mod.LoadScriptIntoMemory()
        --Trading. Your pokemon is stored in 8004, whereas enemy pokemon is already stored through setenemypokemon command
        elseif ScriptNo == 17 then
            emu:write16(Globals.Var8000Adr[2], 0)
            emu:write16(Globals.Var8000Adr[6], Globals.Var8000[5])
            ScriptAddressTemp = ScriptAddress2
            ScriptAddressTemp1 = 16655722
            Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
            ScriptAddressTemp = ScriptAddressTemp + 4 
            ScriptAddressTemp1 = 2147554855
            Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
            ScriptAddressTemp = ScriptAddressTemp + 4 
            ScriptAddressTemp1 = 40632321
            Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
            ScriptAddressTemp = ScriptAddressTemp + 4 
            ScriptAddressTemp1 = 4294967295
            Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
            mod.LoadScriptIntoMemory()
        --Cancel Battle
        elseif ScriptNo == 18 then
            emu:write16(Globals.Var8000Adr[2], 0)
            ScriptAddressTemp = ScriptAddress2
            ScriptAddressTemp1 = 285216618
            Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
            ScriptAddressTemp = ScriptAddressTemp + 4 
            ScriptAddressTemp1 = 151562240
            Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
            ScriptAddressTemp = ScriptAddressTemp + 4 
            ScriptAddressTemp1 = 2147554822
            Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
            ScriptAddressTemp = ScriptAddressTemp + 4 
            ScriptAddressTemp1 = 40632325
            Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
            ScriptAddressTemp = ScriptAddressTemp + 4 
            ScriptAddressTemp1 = 3655126783
            Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
            ScriptAddressTemp = ScriptAddressTemp + 4 
            ScriptAddressTemp1 = 3706249984
            Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
            ScriptAddressTemp = ScriptAddressTemp + 4 
            ScriptAddressTemp1 = 3825264345
            Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
            ScriptAddressTemp = ScriptAddressTemp + 4 
            ScriptAddressTemp1 = 3656242656
            Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
            ScriptAddressTemp = ScriptAddressTemp + 4 
            ScriptAddressTemp1 = 3587965158
            Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
            ScriptAddressTemp = ScriptAddressTemp + 4 
            ScriptAddressTemp1 = 3587637479
            Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
            ScriptAddressTemp = ScriptAddressTemp + 4 
            ScriptAddressTemp1 = 3772372962
            Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
            ScriptAddressTemp = ScriptAddressTemp + 4 
            ScriptAddressTemp1 = 4275624416
            Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
            ScriptAddressTemp = ScriptAddressTemp + 4 
            ScriptAddressTemp1 = 14277864
            Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
            ScriptAddressTemp = ScriptAddressTemp + 4 
            ScriptAddressTemp1 = 3907573206
            Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
            ScriptAddressTemp = ScriptAddressTemp + 4 
            ScriptAddressTemp1 = 4289583584
            Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
            ScriptAddressTemp = ScriptAddressTemp + 4 
            ScriptAddressTemp1 = 4294967040
            Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
            mod.LoadScriptIntoMemory()
        --Cancel Trading
        elseif ScriptNo == 19 then
            emu:write16(Globals.Var8000Adr[2], 0)
            ScriptAddressTemp = ScriptAddress2
            ScriptAddressTemp1 = 285216618
            Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
            ScriptAddressTemp = ScriptAddressTemp + 4 
            ScriptAddressTemp1 = 151562240
            Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
            ScriptAddressTemp = ScriptAddressTemp + 4 
            ScriptAddressTemp1 = 2147554822
            Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
            ScriptAddressTemp = ScriptAddressTemp + 4 
            ScriptAddressTemp1 = 40632325
            Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
            ScriptAddressTemp = ScriptAddressTemp + 4 
            ScriptAddressTemp1 = 3655126783
            Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
            ScriptAddressTemp = ScriptAddressTemp + 4 
            ScriptAddressTemp1 = 3706249984
            Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
            ScriptAddressTemp = ScriptAddressTemp + 4 
            ScriptAddressTemp1 = 3825264345
            Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
            ScriptAddressTemp = ScriptAddressTemp + 4 
            ScriptAddressTemp1 = 3656242656
            Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
            ScriptAddressTemp = ScriptAddressTemp + 4 
            ScriptAddressTemp1 = 3587965158
            Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
            ScriptAddressTemp = ScriptAddressTemp + 4 
            ScriptAddressTemp1 = 3587637479
            Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
            ScriptAddressTemp = ScriptAddressTemp + 4 
            ScriptAddressTemp1 = 3772372962
            Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
            ScriptAddressTemp = ScriptAddressTemp + 4 
            ScriptAddressTemp1 = 4275624416
            Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
            ScriptAddressTemp = ScriptAddressTemp + 4 
            ScriptAddressTemp1 = 14277864
            Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
            ScriptAddressTemp = ScriptAddressTemp + 4 
            ScriptAddressTemp1 = 3637896936
            Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
            ScriptAddressTemp = ScriptAddressTemp + 4 
            ScriptAddressTemp1 = 16756185
            Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
            ScriptAddressTemp = ScriptAddressTemp + 4 
            ScriptAddressTemp1 = 4294967295
            Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
            mod.LoadScriptIntoMemory()
        --other player is too busy to battle.
        elseif ScriptNo == 20 then
            emu:write16(Globals.Var8000Adr[2], 0)
            ScriptAddressTemp = ScriptAddress2
            ScriptAddressTemp1 = 285216618
            Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
            ScriptAddressTemp = ScriptAddressTemp + 4 
            ScriptAddressTemp1 = 151562240
            Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
            ScriptAddressTemp = ScriptAddressTemp + 4 
            ScriptAddressTemp1 = 2147554822
            Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
            ScriptAddressTemp = ScriptAddressTemp + 4 
            ScriptAddressTemp1 = 40632321
            Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
            ScriptAddressTemp = ScriptAddressTemp + 4 
            ScriptAddressTemp1 = 3722235647
            Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
            ScriptAddressTemp = ScriptAddressTemp + 4 
            ScriptAddressTemp1 = 3873964263
            Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
            ScriptAddressTemp = ScriptAddressTemp + 4 
            ScriptAddressTemp1 = 3655523797
            Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
            ScriptAddressTemp = ScriptAddressTemp + 4 
            ScriptAddressTemp1 = 3655794918
            Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
            ScriptAddressTemp = ScriptAddressTemp + 4 
            ScriptAddressTemp1 = 15196633
            Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
            ScriptAddressTemp = ScriptAddressTemp + 4 
            ScriptAddressTemp1 = 4276347880
            Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
            ScriptAddressTemp = ScriptAddressTemp + 4 
            ScriptAddressTemp1 = 3991398870
            Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
            ScriptAddressTemp = ScriptAddressTemp + 4 
            ScriptAddressTemp1 = 14936064
            Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
            ScriptAddressTemp = ScriptAddressTemp + 4 
            ScriptAddressTemp1 = 3907573206
            Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
            ScriptAddressTemp = ScriptAddressTemp + 4 
            ScriptAddressTemp1 = 4289780192
            Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
            ScriptAddressTemp = ScriptAddressTemp + 4 
            ScriptAddressTemp1 = 4294967040
            Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
            mod.LoadScriptIntoMemory()
        --other player is too busy to trade.
        elseif ScriptNo == 21 then
            emu:write16(Globals.Var8000Adr[2], 0)
            ScriptAddressTemp = ScriptAddress2
            ScriptAddressTemp1 = 285216618
            Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
            ScriptAddressTemp = ScriptAddressTemp + 4 
            ScriptAddressTemp1 = 151562240
            Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
            ScriptAddressTemp = ScriptAddressTemp + 4 
            ScriptAddressTemp1 = 2147554822
            Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
            ScriptAddressTemp = ScriptAddressTemp + 4 
            ScriptAddressTemp1 = 40632321
            Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
            ScriptAddressTemp = ScriptAddressTemp + 4 
            ScriptAddressTemp1 = 3722235647
            Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
            ScriptAddressTemp = ScriptAddressTemp + 4 
            ScriptAddressTemp1 = 3873964263
            Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
            ScriptAddressTemp = ScriptAddressTemp + 4 
            ScriptAddressTemp1 = 3655523797
            Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
            ScriptAddressTemp = ScriptAddressTemp + 4 
            ScriptAddressTemp1 = 3655794918
            Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
            ScriptAddressTemp = ScriptAddressTemp + 4 
            ScriptAddressTemp1 = 15196633
            Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
            ScriptAddressTemp = ScriptAddressTemp + 4 
            ScriptAddressTemp1 = 4276347880
            Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
            ScriptAddressTemp = ScriptAddressTemp + 4 
            ScriptAddressTemp1 = 3991398870
            Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
            ScriptAddressTemp = ScriptAddressTemp + 4 
            ScriptAddressTemp1 = 14936064
            Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
            ScriptAddressTemp = ScriptAddressTemp + 4 
            ScriptAddressTemp1 = 3637896936
            Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
            ScriptAddressTemp = ScriptAddressTemp + 4 
            ScriptAddressTemp1 = 16756953
            Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
            ScriptAddressTemp = ScriptAddressTemp + 4 
            ScriptAddressTemp1 = 4294967295
            Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
            mod.LoadScriptIntoMemory()
        --battle script
        elseif ScriptNo == 22 then
            emu:write16(Globals.Var8000Adr[2], 0)
            ScriptAddressTemp = ScriptAddress2
            ScriptAddressTemp1 = 40656234
            Globals.ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
            mod.LoadScriptIntoMemory()
        --trade names script.
        elseif ScriptNo == 23 then
            --Other trainer aka other player
            ScriptAddressTemp = Buffer1
            ScriptAddressTemp1 = Buffer[1]
            emu:write8(ScriptAddressTemp, ScriptAddressTemp1)
            ScriptAddressTemp = Buffer1 + 1
            ScriptAddressTemp1 = Buffer[2]
            emu:write8(ScriptAddressTemp, ScriptAddressTemp1)
            ScriptAddressTemp = Buffer1 + 2
            ScriptAddressTemp1 = Buffer[3]
            emu:write8(ScriptAddressTemp, ScriptAddressTemp1)
            ScriptAddressTemp = Buffer1 + 3
            ScriptAddressTemp1 = Buffer[4]
            emu:write8(ScriptAddressTemp, ScriptAddressTemp1)
            ScriptAddressTemp = Buffer1 + 4
            ScriptAddressTemp1 = 255
            emu:write8(ScriptAddressTemp, ScriptAddressTemp1)
            --Their pokemon
            WriteBuffers(Buffer3, EnemyTradeVars[6], 5)
        end
			
end

function mod.LoadScriptIntoMemory()
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

return mod