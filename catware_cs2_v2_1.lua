--[[
#########################################################
				 Script lua aimware
				      by blurry
	 Leave +rep on my profile if enjoy using this script!
		 UID: https://aimware.net/forum/user/61632
#########################################################
--]]

--##### REFERENCE #####
local ct2_reference = gui.Reference("settings")
	local ct2_tab = gui.Tab(ct2_reference, "catware2", "CATWARE.lua")
		local ct2_box = gui.Groupbox(ct2_tab, "Welcome Semirager! ", 10, 5, 300, 1)
			local ct2_enable = gui.Checkbox(ct2_box, "ct2_enable", "Enable Master", true)
			local ct2_unsafe = gui.Checkbox(ct2_box, "ct2_unsafe", "Enable Unsafe", false)
				  ct2_unsafe:SetDescription("*WARNING* Lower trust factor or get banned")
				  
--##### TAB FEATURE #####
local ct2_feature = gui.Groupbox(ct2_tab, "Feature", 320, 290, 300, 1)
	--local ct2_unmuted = gui.Checkbox(ct2_feature, "ct2_unmuted", "Auto unmuted", 1)
	--local ct2_walkslide = gui.Checkbox(ct2_feature, 'ct2_slidewalk', 'Reverse Slide Walk', false);
	local ct2_indicator = gui.Checkbox(ct2_feature, "ct2_indicator", "Enable Indicator", true);
	local ct2_watermark = gui.Checkbox(ct2_feature, "ct2_watermark", "Enable Watermark", true);
	--local ct2_clantag = gui.Checkbox(ct2_feature, "ct2_clantag", "Enable Clantag", false);
	
--##### TAB KEYBINDS #####
local ct2_keybind = gui.Groupbox(ct2_tab, "Bindkey", 320, 5, 300, 1)
	local ct2_masterbot = gui.Checkbox(ct2_keybind, "ct2_switchsemi", "Semirage", false)
	local ct2_autowall = gui.Checkbox(ct2_keybind, "ct2_autowall", "AutoWall", false)
	--local ct2_kinverter = gui.Checkbox(ct2_keybind, "ct2_kinverter", "Side Inverter", false)
	local ct2_kfreestand = gui.Checkbox(ct2_keybind, "ct2_kfreestand", "Freestand", false)
	local ct2_kforcebaim = gui.Checkbox(ct2_keybind, "ct2_kforcebaim", "Bodyaim", false)
	local ct2_kpitchdown = gui.Checkbox(ct2_keybind, "ct2_kpitchdown", "Pitch down", false)
	
--##### TAB ANTIAIM #####
local ct2_antiaim		= gui.Groupbox(ct2_tab, "AntiAim", 10, 160, 300, 1)
	--local ct2_sdesync		= gui.Slider(ct2_antiaim, "ct2_sdesync", "Desync", 0, 0, 58, 1)
	--local ct2_syaw			= gui.Slider(ct2_antiaim, "ct2_syaw", "Yaw", 0, 0, 50, 1)
	--local ct2_sroll			= gui.Slider(ct2_antiaim, "ct2_sroll", "Roll", 0, 0, 45, 1)
	local ct2_sfreestand		= gui.Slider(ct2_antiaim, "ct2_sfreestand", "Freestand", 0, 0, 90, 1)
	--local ct2_spitchdown		= gui.Slider(ct2_antiaim, "ct2_spitch", "Pitch", 0, 0, 88, 1)
	

--##### VARIABLE #####
	local cat_icon = "🐱";
	local spacer = " ";
	local version = " v2.1";
    local script_name = "CATWARE" .. version .. "";
	local player_name = cheat.GetUserName()
	--local player_fps = 1 / globals.AbsoluteFrameTime()
	local font_watermark = draw.CreateFont("Verdana", 13, 900);
	--local curtime = globals.CurTime()
	local size_x, size_y = draw.GetScreenSize(watermarkText);
	local vertical, horizontal = 30, 70;
	local font_indicator = draw.CreateFont("Tahoma", 17, 1300)

	

--########## UNSAFE ##########
local function unsafe_func()

	local unsafe_weapons = {"shared","zeus","pistol","hpistol","smg","rifle","shotgun","scout","asniper","sniper","lmg", "knife"}
	
	if ct2_enable:GetValue() == true then
		if not ct2_unsafe:GetValue() then
			gui.SetValue("misc.antiuntrusted", true)
			gui.SetValue("rbot.antiaim.base", "0 Off")
			gui.SetValue("rbot.antiaim.advanced.pitch", "Off")
			gui.SetValue("rbot.aim.aimadj.silentaim", false)
			gui.SetValue("rbot.antiaim.condition.autodir.edges", false)
			--gui.SetValue("rbot.antiaim.right", "0 Off")
			--gui.SetValue("rbot.antiaim.left", "0 Off")
				for i, v in next, unsafe_weapons do
				gui.SetValue("rbot.accuracy.attack.".. v ..".fire", "Off")
				end
		end
	end
	
end
callbacks.Register("Draw", unsafe_func)


--########## WATERMARK ########## 
local function watermark_func()

	local watermarkText = spacer .. cat_icon .. spacer .. script_name .. spacer .. cat_icon .. spacer

	draw.SetFont(font_watermark); 
	draw.Color(10, 10, 10, 150);
	draw.FilledRect((size_x - 10) - draw.GetTextSize(watermarkText), 5, size_x - 5, vertical );
	draw.Color(200, 150, 150, 250)
	draw.OutlinedRect((size_x - 10) - draw.GetTextSize(watermarkText), 5, size_x - 5, vertical);
	draw.Color(250, 250, 250, 250);
	draw.TextShadow((size_x - 8) - draw.GetTextSize(watermarkText), 13, watermarkText);
	
end
callbacks.Register("Draw", watermark_func)


--########## INDICATOR ##########
local function indicator_func()
--[[
	if not ct2_enable:GetValue() then return end
	if not ct2_indicator:GetValue() then return end
	
	local local_player = entities.GetLocalPlayer();
	if local_player == nil or not local_player:IsAlive() then return end
--]]
	local screenCenterX, screenCenterY = draw.GetScreenSize();
	
	
	screenCenterX = screenCenterX * 0.5;
	screenCenterY = screenCenterY * 0.5;
--[[
	if gui.GetValue("rbot.antiaim.base.rotation") < 0 and gui.GetValue("rbot.master") == true  then
		draw.Color(200, 150, 150, 250)
		draw.Triangle(screenCenterX + 50, screenCenterY - 7, screenCenterX + 65, screenCenterY - 7 + 8, screenCenterX + 50, screenCenterY - 7 + 15);
	end
	if gui.GetValue("rbot.antiaim.base.rotation") > 0 and gui.GetValue("rbot.master") == true then
		draw.Color(200, 150, 150, 250)
		draw.Triangle(screenCenterX - 50, screenCenterY - 7, screenCenterX - 65, screenCenterY - 7 + 8, screenCenterX - 50, screenCenterY - 7 + 15);
	end
--]]
	local indCenterX, indCenterY = draw.GetScreenSize();
	local extraY = 30
	local sideextraY = -50
	if gui.GetValue("lbot.master") == true  then
		draw.SetFont(font_indicator);
		draw.Color(200, 150, 150, 250);
		draw.Text(10, indCenterY / 2 + sideextraY, "LEGIT")
		sideextraY = sideextraY + 17
	elseif gui.GetValue("rbot.master") == true then
		draw.SetFont(font_indicator);
		draw.Color(200, 150, 150, 250)
		draw.Text(indCenterX / 2 - 25 , indCenterY / 2 + extraY, "RAGE " .. gui.GetValue("rbot.aim.target.fov") .. "º")
		extraY = extraY + 17
	end
	if ct2_unsafe:GetValue() == true then
		draw.SetFont(font_indicator);
		draw.Color(250, 50, 50, 250)
		draw.TextShadow(10 , indCenterY / 2 + sideextraY , "UNSAFE");
		sideextraY = sideextraY + 17
	end
	if gui.GetValue("rbot.aim.aimadj.silentaim") == true and gui.GetValue("rbot.master") == true then
		draw.SetFont(font_indicator);
		draw.Color(250, 50, 50, 250)
		draw.TextShadow(10 , indCenterY / 2 + sideextraY , "SILENT");
		sideextraY = sideextraY + 17
	end
--[[
	if gui.GetValue("misc.catware_script.catware_sroll") > 1 and gui.GetValue("rbot.master") == true and gui.GetValue("misc.catware_script.catware_unsafe") == true then
		draw.SetFont(font_indicator);
		draw.Color(200, 150, 150, 250)
		draw.Text(indCenterX / 2 - 25, indCenterY / 2 + extraY, "ROLL ") -- .. gui.GetValue("misc.catware_script.catware_sroll") .. "º")
		extraY = extraY + 15
	end
--]]
	if ct2_autowall:GetValue() == true and gui.GetValue("rbot.master") == true then
		draw.SetFont(font_indicator);
		draw.Color(200, 150, 150, 250)
		draw.Text(indCenterX / 2 - 25, indCenterY / 2 + extraY, "AWALL")
		extraY = extraY + 15
	end
	if ct2_kfreestand:GetValue() == true and gui.GetValue("rbot.master") == true then
		draw.SetFont(font_indicator);
		draw.Color(200, 150, 150, 250)
		draw.Text(indCenterX / 2 - 25, indCenterY / 2 + extraY, "EDGE")
		extraY = extraY + 15
	end
	if ct2_kforcebaim:GetValue() == true and gui.GetValue("rbot.master") == true then
		draw.SetFont(font_indicator);
		draw.Color(200, 150, 150, 250)
		draw.Text(indCenterX / 2 - 25, indCenterY / 2 + extraY , "BAIM")
		extraY = extraY + 15

	end
	if ct2_kpitchdown:GetValue() == true and gui.GetValue("rbot.master") == true then
		draw.SetFont(font_indicator);
		draw.Color(200, 150, 150, 250)
		draw.Text(indCenterX / 2 - 25, indCenterY / 2 + extraY, "PITCH ")
		extraY = extraY + 15
	end
--[[
	local key_fakeduck = gui.GetValue("rbot.antiaim.extra.fakecrouchkey")
	if input.IsButtonDown(key_fakeduck) and gui.GetValue("rbot.master") == true then
		draw.SetFont(font_indicator);
		draw.Color(200, 150, 150, 250)
		draw.Text(indCenterX / 2 - 25, indCenterY / 2 + extraY, "FAKEDUCK")
		extraY = extraY + 15
	end
--]]

end
callbacks.Register("Draw", indicator_func)

--########## MASTERBOT ##########
local function masterbot_func()

	if ct2_masterbot:GetValue() then
		gui.SetValue("rbot.master", true)
	else
		gui.SetValue("lbot.master", true)
	end
	
end
callbacks.Register("Draw", masterbot_func)


--########## AUTOWALL ##########
local function autowall_func()

	local aw_weapons = {"shared","zeus","pistol","hpistol","smg","rifle","shotgun","scout","asniper","sniper","lmg"}
	
	if ct2_enable:GetValue() == true then
		if ct2_autowall:GetValue() then
			for i, v in next, aw_weapons do
			gui.SetValue("rbot.hitscan.accuracy.".. v ..".autowall", true)
			end
		else
			for i, v in next, aw_weapons do
			gui.SetValue("rbot.hitscan.accuracy.".. v ..".autowall", false)
			end
		end
	end
	
end
callbacks.Register("Draw", autowall_func)


--########## FREESTAND ##########
local function freestand_func()

	if ct2_enable:GetValue() == true and ct2_unsafe:GetValue() == true then
		if ct2_kfreestand:GetValue() then
			gui.SetValue("rbot.antiaim.condition.autodir.edges", true)
			gui.SetValue("rbot.antiaim.right", "0 Backward")
			gui.SetValue("rbot.antiaim.right", ct2_sfreestand:GetValue()*-1)
			gui.SetValue("rbot.antiaim.left", "0 Backward")
			gui.SetValue("rbot.antiaim.left", ct2_sfreestand:GetValue()*1)
		else
			gui.SetValue("rbot.antiaim.condition.autodir.edges", false)
		end
	end
	
end
callbacks.Register("Draw", freestand_func)


--########## BODYAIM ##########
local function forcebaim_func()

	local baim_weapons = {"shared","pistol","hpistol","smg","rifle","shotgun","scout","asniper","sniper","lmg"}
   
	if ct2_enable:GetValue() == true then
		if ct2_kforcebaim:GetValue() then
			for i, v in next, baim_weapons do
			gui.SetValue("rbot.hitscan.hitbox.".. v ..".head.priority",0)
			gui.SetValue("rbot.hitscan.hitbox.".. v ..".body.priority",1)
			--gui.SetValue("rbot.hitscan.extra.".. v ..".safepoint.body",1)
			gui.SetValue("rbot.hitscan.extra.".. v ..".safepoint.forcebody",1)
			end
		else
			for i, v in next, baim_weapons do
			gui.SetValue("rbot.hitscan.hitbox.".. v ..".head.priority",1)
			gui.SetValue("rbot.hitscan.hitbox.".. v ..".body.priority",0)
			--gui.SetValue("rbot.hitscan.extra.".. v ..".safepoint.body",0)
			gui.SetValue("rbot.hitscan.extra.".. v ..".safepoint.forcebody",0)
			end
		end
	end
	
end
callbacks.Register("Draw", forcebaim_func)

--########## PITCH DOWN ##########
local function pitchdown_func()
	
	if ct2_enable:GetValue() == true and ct2_unsafe:GetValue() == true then
		if ct2_kpitchdown:GetValue() then
			gui.SetValue("rbot.antiaim.advanced.pitch", 1)
			gui.SetValue("rbot.antiaim.condition.autodir.targets", true)
			gui.SetValue("rbot.antiaim.base", "180 Backward")
		else
			gui.SetValue("rbot.antiaim.advanced.pitch", 0)
			gui.SetValue("rbot.antiaim.condition.autodir.targets", false)
			gui.SetValue("rbot.antiaim.base", "Off")
		end
	end
end
callbacks.Register("Draw", pitchdown_func) 
