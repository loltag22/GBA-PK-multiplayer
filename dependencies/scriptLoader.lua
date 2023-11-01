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
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
		--		LoadScriptIntoMemory()
			--Host script
			elseif ScriptNo == 1 then 
				emu:write16(Var8000Adr[2], 0) 
				emu:write16(Var8000Adr[5], 0) 
				ScriptAddressTemp = ScriptAddress2
				ScriptAddressTemp1 = 603983722
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 151562240
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 2148344069
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 17170433
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 145227804
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 25166870
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 4278348800
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 41944086
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 4278348800
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 3773424593
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 3823960280
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 3722445033
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 3892369887
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 3805872355
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 3655390933
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 3638412030
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 3034710233
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 3654929664
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 16755935
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
				LoadScriptIntoMemory()
		--Interaction Menu	Multi Choice
			elseif ScriptNo == 2 then
				emu:write16(Var8000Adr[1], 0) 
				emu:write16(Var8000Adr[2], 0) 
				emu:write16(Var8000Adr[14], 0) 
				ScriptAddressTemp = ScriptAddress2
				ScriptAddressTemp1 = 1664873
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 1868957864
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 132117
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 226492441
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 2147489664
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 40566785
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 3588018687
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 3823829224
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 14213353
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 15328237
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 3655327200
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 14936318
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 3942704088
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 14477533
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 4289463293
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 4294967040
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
				--For buffer 2
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
				PrevExtraAdr = ROMCARD:read32(MultichoiceAdr)
				--Overwrite multichoice 0x2 with a custom at address MultichoiceAdr2
				ScriptAddressTemp = MultichoiceAdr
				ScriptAddressTemp1 = MultichoiceAdr2
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
				--Multi-Choice
				ScriptAddressTemp = MultichoiceAdr2
				ScriptAddressTemp1 = ScriptAddress3
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
				ScriptAddressTemp = ScriptAddressTemp + 4
				ScriptAddressTemp1 = 0
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = ScriptAddress3 + 7
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
				ScriptAddressTemp = ScriptAddressTemp + 4
				ScriptAddressTemp1 = 0
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
				ScriptAddressTemp = ScriptAddressTemp + 4
				ScriptAddressTemp1 = ScriptAddress3 + 13
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
				ScriptAddressTemp = ScriptAddressTemp + 4
				ScriptAddressTemp1 = 0
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
				ScriptAddressTemp = ScriptAddressTemp + 4
				ScriptAddressTemp1 = ScriptAddress3 + 18
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
				ScriptAddressTemp = ScriptAddressTemp + 4
				ScriptAddressTemp1 = 0
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
				--Text
				ScriptAddressTemp = ScriptAddress3
				ScriptAddressTemp1 = 3907573180
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
				ScriptAddressTemp = ScriptAddressTemp + 4
				ScriptAddressTemp1 = 3472873952
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
				ScriptAddressTemp = ScriptAddressTemp + 4
				ScriptAddressTemp1 = 3654866406
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
				ScriptAddressTemp = ScriptAddressTemp + 4
				ScriptAddressTemp1 = 3872767487
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
				ScriptAddressTemp = ScriptAddressTemp + 4
				ScriptAddressTemp1 = 3972005848
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
				ScriptAddressTemp = ScriptAddressTemp + 4
				ScriptAddressTemp1 = 4294961373
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
				LoadScriptIntoMemory()
		--Placeholder
			elseif ScriptNo == 3 then
				emu:write16(Var8000Adr[2], 0) 
				ScriptAddressTemp = ScriptAddress2
				ScriptAddressTemp1 = 285216618
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 151562240
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 2147554822
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 40632321
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 3907242239
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 3689078236
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 3839220736
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 3655522788
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 16756952
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 4294967295
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				LoadScriptIntoMemory()
		--Waiting message
			elseif ScriptNo == 4 then
				emu:write16(Var8000Adr[2], 0) 
				ScriptAddressTemp = ScriptAddress2
				ScriptAddressTemp1 = 1271658
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 375785640
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 5210113
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 654415909
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 3523150444
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 3723025877
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 3657489378
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 3808487139
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 3873037544
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 3588285440
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 2967919085
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 4294902015
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				LoadScriptIntoMemory()
		--Cancel message
			elseif ScriptNo == 5 then
				emu:write16(Var8000Adr[2], 0) 
				ScriptAddressTemp = ScriptAddress2
				ScriptAddressTemp1 = 285216618
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 151562240
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 2147554822
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 40632325
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 3655126783
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 3706249984
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 3825264345
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 3656242656
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 3587965158
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 3587637479
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 3772372962
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 4289583321
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)  
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 4294967040
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
				LoadScriptIntoMemory()
		--Trade request
			elseif ScriptNo == 6 then
				emu:write16(Var8000Adr[2], 0) 
				ScriptAddressTemp = ScriptAddress2
				ScriptAddressTemp1 = 469765994
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 151562240
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 2148344069
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 393217
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 145227850
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 41943318
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 4278348800
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 3942646781
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 3655133149
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 3823632615
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 3588679680
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 3942701528
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)  
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 14477533
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 2917786605
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 14925566
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 15328237
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 3654801365
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 4289521892
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 18284288
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 1811939712
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 4294967042
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
				LoadScriptIntoMemory()
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
				emu:write16(Var8000Adr[2], 0) 
				ScriptAddressTemp = ScriptAddress2
				ScriptAddressTemp1 = 285216618
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 151562240
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 2147554822
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 40632321
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 3655126783
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 3706249984
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 3825264345
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 3656242656
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 3822584038
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 3808356313
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 3942705379
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 14477277
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)  
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 3892372456
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 3654866406
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 4278255533
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
				LoadScriptIntoMemory()
		--Trade offer
			elseif ScriptNo == 8 then
				emu:write16(Var8000Adr[2], 0) 
				ScriptAddressTemp = ScriptAddress2
				ScriptAddressTemp1 = 469765994
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 151562240
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 2148344069
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 393217
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 145227866
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 41943318
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 4278348800
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 15328211
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 3656046044
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 3671778048
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 3638159065
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 2902719744
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)  
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 3655126782
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 3587965165
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 3808483818
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 3873037018
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 4244691161
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 3522931970
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 14737629
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 15328237
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 3654801365
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 4289521892
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 18284288
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 1811939712
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 4294967042
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
				LoadScriptIntoMemory()
		--Trade offer denied
			elseif ScriptNo == 9 then
				emu:write16(Var8000Adr[2], 0) 
				ScriptAddressTemp = ScriptAddress2
				ScriptAddressTemp1 = 285216618
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 151562240
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 2147554822
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 40632321
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 3655126783
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 3588679680
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 3691043288
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 3590383573
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 14866905
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 3772242392
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 3638158045
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 4278255533
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
				LoadScriptIntoMemory()
		--Battle request
			elseif ScriptNo == 10 then
				emu:write16(Var8000Adr[2], 0) 
				ScriptAddressTemp = ScriptAddress2
				ScriptAddressTemp1 = 469765994
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 151562240
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 2148344069
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 393217
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 145227846
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 41943318
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 4278348800
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 3942646781
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 3655133149
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 3823632615
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 3906328064
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 14278888
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 2917786605
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 14925566
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 15328237
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 3654801365
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 4289521892
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 18284288
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 1811939712
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 4294967042
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
				LoadScriptIntoMemory()
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
				emu:write16(Var8000Adr[2], 0) 
				ScriptAddressTemp = ScriptAddress2
				ScriptAddressTemp1 = 285216618
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 151562240
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 2147554822
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 40632321
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 3655126783
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 3706249984
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 3825264345
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 3656242656
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 3822584038
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 3808356313
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 3942705379
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 14477277
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 3590382568
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 3773360341
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 16756185
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 4294967295
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
				LoadScriptIntoMemory()
		--Select Pokemon for trade
			elseif ScriptNo == 12 then
				emu:write16(Var8000Adr[1], 0) 
				emu:write16(Var8000Adr[2], 0) 
				emu:write16(Var8000Adr[4], 0) 
				emu:write16(Var8000Adr[5], 0) 
				emu:write16(Var8000Adr[14], 0) 
				ScriptAddressTemp = ScriptAddress2
				ScriptAddressTemp1 = 10429802
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 2147754279
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 67502086
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 145227809
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 1199571750
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 50429185
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 2147554944
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 40632322
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 2147555071
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 40632321
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 4294967295
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				LoadScriptIntoMemory()
		--Battle will start
			elseif ScriptNo == 13 then
				emu:write16(Var8000Adr[2], 0)
				ScriptAddressTemp = ScriptAddress2
				ScriptAddressTemp1 = 1416042
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 627443880
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 1009254542
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 2147554816
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 40632322
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 3924022271
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 3587571942
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 3655395560
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 3772640000
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 3823239392
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 3654680811
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 2917326299
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 4294902015
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				LoadScriptIntoMemory()
		--Trade will start
			elseif ScriptNo == 14 then
				emu:write16(Var8000Adr[2], 0)
				ScriptAddressTemp = ScriptAddress2
				ScriptAddressTemp1 = 1416042
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 627443880
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 1009254542
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 2147554816
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 40632322
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 3924022271
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 3873964262
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 14276821
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 3772833259
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 3957580288
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 3688486400
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 4289585885
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 4294967040
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
				LoadScriptIntoMemory()
		--You have canceled the battle
			elseif ScriptNo == 15 then
				emu:write16(Var8000Adr[2], 0)
				ScriptAddressTemp = ScriptAddress2
				ScriptAddressTemp1 = 285216618
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 151562240
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 2147554822
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 40632326
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 3924022271
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 3939884032
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 3587637465
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 3772372962
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 14211552
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 14277864
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 3907573206
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 4289583584
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 4294967040
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				LoadScriptIntoMemory()
		--You have canceled the trade
			elseif ScriptNo == 16 then
				emu:write16(Var8000Adr[2], 0)
				ScriptAddressTemp = ScriptAddress2
				ScriptAddressTemp1 = 285216618
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 151562240
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 2147554822
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 40632326
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 3924022271
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 3939884032
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 3587637465
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1)
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 3772372962
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 14211552
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 14277864
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 3637896936
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 16756185
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 4294967295
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				LoadScriptIntoMemory()
			--Trading. Your pokemon is stored in 8004, whereas enemy pokemon is already stored through setenemypokemon command
			elseif ScriptNo == 17 then
				emu:write16(Var8000Adr[2], 0)
				emu:write16(Var8000Adr[6], Var8000[5])
				ScriptAddressTemp = ScriptAddress2
				ScriptAddressTemp1 = 16655722
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 2147554855
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 40632321
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 4294967295
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				LoadScriptIntoMemory()
			--Cancel Battle
			elseif ScriptNo == 18 then
				emu:write16(Var8000Adr[2], 0)
				ScriptAddressTemp = ScriptAddress2
				ScriptAddressTemp1 = 285216618
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 151562240
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 2147554822
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 40632325
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 3655126783
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 3706249984
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 3825264345
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 3656242656
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 3587965158
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 3587637479
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 3772372962
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 4275624416
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 14277864
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 3907573206
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 4289583584
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 4294967040
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				LoadScriptIntoMemory()
			--Cancel Trading
			elseif ScriptNo == 19 then
				emu:write16(Var8000Adr[2], 0)
				ScriptAddressTemp = ScriptAddress2
				ScriptAddressTemp1 = 285216618
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 151562240
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 2147554822
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 40632325
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 3655126783
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 3706249984
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 3825264345
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 3656242656
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 3587965158
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 3587637479
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 3772372962
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 4275624416
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 14277864
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 3637896936
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 16756185
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 4294967295
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				LoadScriptIntoMemory()
			--other player is too busy to battle.
			elseif ScriptNo == 20 then
				emu:write16(Var8000Adr[2], 0)
				ScriptAddressTemp = ScriptAddress2
				ScriptAddressTemp1 = 285216618
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 151562240
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 2147554822
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 40632321
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 3722235647
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 3873964263
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 3655523797
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 3655794918
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 15196633
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 4276347880
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 3991398870
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 14936064
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 3907573206
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 4289780192
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 4294967040
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				LoadScriptIntoMemory()
			--other player is too busy to trade.
			elseif ScriptNo == 21 then
				emu:write16(Var8000Adr[2], 0)
				ScriptAddressTemp = ScriptAddress2
				ScriptAddressTemp1 = 285216618
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 151562240
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 2147554822
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 40632321
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 3722235647
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 3873964263
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 3655523797
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 3655794918
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 15196633
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 4276347880
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 3991398870
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 14936064
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 3637896936
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 16756953
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				ScriptAddressTemp = ScriptAddressTemp + 4 
				ScriptAddressTemp1 = 4294967295
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				LoadScriptIntoMemory()
			--battle script
			elseif ScriptNo == 22 then
				emu:write16(Var8000Adr[2], 0)
				ScriptAddressTemp = ScriptAddress2
				ScriptAddressTemp1 = 40656234
				ROMCARD:write32(ScriptAddressTemp, ScriptAddressTemp1) 
				LoadScriptIntoMemory()
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

return mod