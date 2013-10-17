if CLIENT then

	if not GetConVar("gmc_startmessage") then
		CreateClientConVar("gmc_startmessage","1",true,false)
	end

	local gmactcmd = {
		["dances"] = {
			["dance"] 	= "Обычный танец",
			["muscle"] 	= "Секси танец",
			["robot"]  	= "Танец/имитация робота",
		},
		["saying hi"]   = {	
			["wave"] 	= "Привет",
			["salute"]  = "\"Честь имею\"",
			["bow"] 	= "Поклон",
		},
		["taunts"] 		= {		
			["laugh"] 	= "Смех",
			["pers"] 	= "Поза льва",
			["cheer"] 	= "О, да!",
		},
		["advises"] 	= {
			["agree"]	= "Согласие",
			["disagree"]= "Несогласие",
		},
		["imitations"]  = {
			["zombie"] 	= "Имитация зомби",
			["robot"]  	= "Танец/имитация робота",
		},
		["command"] 	= {
			["halt"] 	= "Стой!",
			["group"] 	= "Группируемся!",
			["forward"] = "Вперед!",
			["becon"]   = "Давайте!",
		}
	}

	local NormalDanceLoopIsOn = false
	local SexyDanceLoopIsOn = false
	local RobotDanceLoopIsOn = false

	local function GestureMessage( message )
		chat.AddText( Color( 129, 224, 27 ), "[Меню жестов] ", Color( 255, 255, 255), message )
	end

	local function ToggleNormalDanceLoop()
		if SexyDanceLoopIsOn == true or RobotDanceLoopIsOn == true
			then
				GestureMessage( "Вы уже танцуете!" )
			elseif NormalDanceLoopIsOn == false
				then
					RunConsoleCommand( "act", "dance" )
					timer.Create( "normaldanceloop", 10, 0, function() RunConsoleCommand( "act", "dance" ) end ) 
					GestureMessage( "Бесконечный танец включен." )
					if ToggleNormalDanceLoopButton
					then
						ToggleNormalDanceLoopButton:SetImage( "icon16/tick.png" )
					end
					NormalDanceLoopIsOn = true
			elseif NormalDanceLoopIsOn == true
				then
					timer.Destroy("normaldanceloop")
					GestureMessage( "Бесконечный танец выключен." )
					if ToggleNormalDanceLoopButton
					then
						ToggleNormalDanceLoopButton:SetImage( "icon16/cross.png" )
					end
					NormalDanceLoopIsOn = false
		end
	end

	local function ToggleSexyDanceLoop()
		if NormalDanceLoopIsOn == true or RobotDanceLoopIsOn == true
			then
				GestureMessage( "Вы уже танцуете!" )
			elseif SexyDanceLoopIsOn == false
				then
					RunConsoleCommand( "act", "muscle" ) 
					timer.Create( "sexydanceloop", 14, 0, function() RunConsoleCommand( "act", "muscle" ) end ) 
					GestureMessage( "Бесконечный секси танец включен." )
					if ToggleSexyDanceLoopButton
					then
						ToggleSexyDanceLoopButton:SetImage( "icon16/tick.png" )
					end
					SexyDanceLoopIsOn = true
			elseif SexyDanceLoopIsOn == true 
				then
					timer.Destroy( "sexydanceloop" )
					GestureMessage( "Бесконечный секси танец выключен." )
					if ToggleSexyDanceLoopButton
					then
						ToggleSexyDanceLoopButton:SetImage( "icon16/cross.png" )
					end
					SexyDanceLoopIsOn = false
		end
	end

	local function ToggleRobotDanceLoop()
		if NormalDanceLoopIsOn == true or SexyDanceLoopIsOn == true
			then
				GestureMessage( "Вы уже танцуете!" )
			elseif RobotDanceLoopIsOn == false
				then
					RunConsoleCommand( "act", "robot" ) 
					timer.Create( "robotdanceloop", 14, 0, function() RunConsoleCommand( "act", "robot" ) end ) 
					GestureMessage( "Бесконечный танец робота включен." )
					if ToggleRobotDanceLoopButton
					then
						ToggleRobotDanceLoopButton:SetImage( "icon16/tick.png" )
					end
					RobotDanceLoopIsOn = true
			elseif RobotDanceLoopIsOn == true 
				then
					timer.Destroy( "robotdanceloop" )
					GestureMessage( "Бесконечный танец робота выключен." )
					if ToggleRobotDanceLoopButton
					then
						ToggleRobotDanceLoopButton:SetImage( "icon16/cross.png" )
					end
					RobotDanceLoopIsOn = false
		end
	end

	local function ShowHelp()
		GestureMessage("Откройте консоль для просмотра команд.")
		Msg( "Команды:" )
		MsgC( Color( 129, 224, 27 ), 
	[[

	- /dance (Обычный танец) 
	- /muscle (Секси танец) 
	- /wave 
	- /salute 
	- /bow 
	- /laugh 
	- /pers (Поза льва) 
	- /cheer 
	- /agree 
	- /disagree 
	- /zombie (Имитация зомби) 
	- /robot (Имитация робота) 
	- /halt 
	- /group 
	- /forward 
	- /becon (Иди сюда) 
	- /toggledance (Бесконечный танец) 
	- /togglemuscle (Бесконечный секси танец)
	- /togglerobot (Бесконечный танец робота)
	- /gesture_help (Показывает этот текст)
	]])
	end			
		
	hook.Add( "PopulateMenuBar", "GestureMenu_MenuBar", function( menubar )

		local m = menubar:AddOrGetMenu( "Жесты" )
		
		for subcategoryname,subcategorycontent in pairs( gmactcmd ) do 
			for act,name in pairs( subcategorycontent ) do 
				m:AddOption( name , function() RunConsoleCommand( "act" , act ) end )
			end
			m:AddSpacer()
		end
		
		m:AddSpacer()
		
		ToggleNormalDanceLoopButton = m:AddOption( "Бесконечный танец", ToggleNormalDanceLoop )
		ToggleNormalDanceLoopButton:SetImage( "icon16/cross.png" )
		ToggleSexyDanceLoopButton   = m:AddOption( "Бесконечный секси танец", ToggleSexyDanceLoop )
		ToggleSexyDanceLoopButton:SetImage( "icon16/cross.png" )
		ToggleRobotDanceLoopButton   = m:AddOption( "Бесконечный танец робота", ToggleRobotDanceLoop )
		ToggleRobotDanceLoopButton:SetImage( "icon16/cross.png" )
		
		m:AddSpacer()
		
		m:AddOption("Помощь", ShowHelp )
			
	end )

	hook.Add( "OnPlayerChat", "GestureMenu_Commands", function( ply, text, public )
		local cmd = text:sub( 0, 1 ) 
		
		if not cmd == "!" or not cmd == "/" then return end
		
		local emote = text:lower():sub( 2, 14 ) 
		  
		for _,subcategory in pairs( gmactcmd ) do
			if subcategory[ emote ] then
				RunConsoleCommand( "act", emote )
				return true 
			end
		end
		
		if emote == "toggledance"
		then
			ToggleNormalDanceLoop()
			return --true
		elseif emote == "togglemuscle" 
		then
			ToggleSexyDanceLoop()
			return --true
		elseif emote == "togglerobot"
		then
			ToggleRobotDanceLoop()
			return --true
		end
		
		if emote == "gesture_help"
		then
			ShowHelp()
			return --true
		end
		
	end )

	if GetConVarNumber("gmc_startmessage") == 1 then
		GestureMessage("Initialized. Write \"/gesture_help\" in chat to show commands help in dev console.")
	end

	AddCSLuaFile()

end

AddCSLuaFile()

-- Code realised by Mare and Tenrys