--gui.Command("clear")
--[[
#########################################################
			Script LUA Aimware v5.1.x CS:2
			Created by blurry and Cl0ne helped
💗 Leave a +rep on my profile if you enjoy using this script! 💗
		UID: https://aimware.net/forum/user/61632
#########################################################
--]]
--##### AUTO UPDATER ##### credit: m0nsterJ
local local_version = "2.3"
local name_script = "CATWARE.lua"
---@diagnostic disable-next-line: undefined-global
local local_script_name = GetScriptName()
local github_version_url = "https://raw.githubusercontent.com/blurrydeaf/aimware/main/scripts/version_catware.txt"
local github_version = http.Get(github_version_url)
local github_source_url = "https://raw.githubusercontent.com/blurrydeaf/aimware/main/scripts/CATWARE.lua"
local devmode = false


--##### DPI #####
local dpi = 1
local dpi_scale = {0.75, 1, 1.25, 1.5, 1.75, 2, 2.25, 2.5, 2.75, 3}
local dpi_elements = {0.75, 1, 1.25, 1.5, 1.75, 2, 2.25, 2.5, 2.75, 3}
callbacks.Register("Draw", function()
	dpi = dpi_scale[gui.GetValue("adv.dpi") + 1];
	dpitext = dpi_elements[gui.GetValue("adv.dpi.elements") + 1];
end)

--##### VARIABLE #####
	local cat_icon = "🐱";
	local spacer = " ";
	--local version = " v2.3";
    local script_name = "CATWARE.lua";-- .. local_version .. "";
	local player_name = cheat.GetUserName(); 
	--local local_config_name = GetConfigName()					-- api miss
	local player_fps = 1 / globals.AbsoluteFrameTime(); 
	local font_watermark = draw.CreateFont("Verdana", (13*dpitext), 900);
	--local curtime = globals.CurTime(); 
	local size_x, size_y = draw.GetScreenSize(watermarkText);
	local vertical, horizontal = 30, 70;
	local font_indicator = draw.CreateFont("Tahoma", 18*dpitext, 1300); 
	local group_weapons = {"shared","zeus","pistol","hpistol","smg","rifle","shotgun","scout","asniper","sniper","lmg"}
	local nedge = 90
	
--##### REFERENCE #####
local ct2_reference 	= gui.Reference("SETTINGS"); 
	local ct2_tab 			= gui.Tab(ct2_reference, "catware2", "CATWARE.lua"); 
		local ct2_box 			= gui.Groupbox(ct2_tab, "Welcome to semirager, ".. player_name .." !" , 10, 10, 300, 1);
			local ct2_enable 		= gui.Checkbox(ct2_box, "enable", "Enable Master", true); 
			local ct2_safemode 		= gui.Checkbox(ct2_box, "safemode", "Enable Safemode", false); 
				  ct2_safemode:SetDescription("Prevent flagged VAC-Live"); 
local ct2_groupdmg	= gui.Groupbox(ct2_tab, "Minimum damage", 10, 160, 300, 1); 
	local enable_override 	= gui.Checkbox(ct2_groupdmg, "enable_override", "Enable min. damage", false); 
	local ct2_dmgweapons	= gui.Combobox(ct2_groupdmg, "dmgweapons", "Type weapon", "Pistol", "Deagle/R8", "Scout", "Auto", "AWP", "Submachine", "Rifle", "Shotgun", "Negev"); 
	local pistol_mindmg		= gui.Slider(ct2_groupdmg, "spistol_mindmg", "Pistol Min. damage", 0, 0, 130, 1); 
	local pistol_ormindmg	= gui.Slider(ct2_groupdmg, "spistol_ormindmg", "Pistol Override damage", 0, 0, 70, 1); 
	local hpistol_mindmg	= gui.Slider(ct2_groupdmg, "shpistol_mindmg", "Deagle/R8 Min. damage", 0, 0, 130, 1); 
	local hpistol_ormindmg	= gui.Slider(ct2_groupdmg, "shpistol_ormindmg", "Deagle/R8 Override damage", 0, 0, 70, 1); 
	local scout_mindmg		= gui.Slider(ct2_groupdmg, "sscout_mindmg", "Scout Min. damage", 0, 0, 130, 1); 
	local scout_ormindmg	= gui.Slider(ct2_groupdmg, "sscout_ormindmg", "Scout Override damage", 0, 0, 70, 1); 
	local asniper_mindmg	= gui.Slider(ct2_groupdmg, "sasniper_mindmg", "Auto Min. damage", 0, 0, 130, 1); 
	local asniper_ormindmg	= gui.Slider(ct2_groupdmg, "sasniper_ormindmg", "Auto Override damage", 0, 0, 70, 1); 
	local sniper_mindmg		= gui.Slider(ct2_groupdmg, "ssniper_mindmg", "AWP Min. damage", 0, 0, 130, 1); 
	local sniper_ormindmg	= gui.Slider(ct2_groupdmg, "ssniper_ormindmg", "AWP Override damage", 0, 0, 70, 1); 
	local smg_mindmg		= gui.Slider(ct2_groupdmg, "ssmg_mindmg", "Submachine Min. damage", 0, 0, 130, 1); 
	local smg_ormindmg		= gui.Slider(ct2_groupdmg, "ssmg_ormindmg", "Submachine Override damage", 0, 0, 70, 1); 
	local rifle_mindmg		= gui.Slider(ct2_groupdmg, "srifle_mindmg", "Rifle Min. damage", 0, 0, 130, 1); 
	local rifle_ormindmg	= gui.Slider(ct2_groupdmg, "srifle_ormindmgg", "Rifle Override damage", 0, 0, 70, 1); 
	local shotgun_mindmg	= gui.Slider(ct2_groupdmg, "sshotgun_mindmg", "Shotgun Min. damage", 0, 0, 130, 1); 
	local shotgun_ormindmg	= gui.Slider(ct2_groupdmg, "sshotgun_ormindmg", "Shotgun Override damage", 0, 0, 70, 1); 
	local lmg_mindmg		= gui.Slider(ct2_groupdmg, "slmg_mindmg", "Negev Min. damage", 0, 0, 130, 1); 
	local lmg_ormindmg		= gui.Slider(ct2_groupdmg, "slmg_ormindmg", "Negev Override damage", 0, 0, 70, 1); 
local ct2_keybind 		= gui.Groupbox(ct2_tab, "Bindkeys", 320, 10, 300, 1); 
	local ct2_kmasterbot 	= gui.Checkbox(ct2_keybind, "kswitchsemi", "Switch Semirage", false); 
	local ct2_kautowall 	= gui.Checkbox(ct2_keybind, "kautowall", "Force Autowall", false); 
	local ct2_kforcebaim 	= gui.Checkbox(ct2_keybind, "kforcebaim", "Force Bodyaim", false); 
	local ct2_koverridedmg 	= gui.Checkbox(ct2_keybind, "koverridedmg", "Override damage", false); 
local ct2_slider		= gui.Groupbox(ct2_tab, "AntiAim direction", 320, 220, 300, 1);
	local ct2_kfreestand 	= gui.Checkbox(ct2_slider, "kfreestand", "Freestand", false); 
	local ct2_sfreestand	= gui.Slider(ct2_slider, "sfreestand", "Freestand", 0, 0, nedge, 1); 
local ct2_feature 		= gui.Groupbox(ct2_tab, "Misc", 320, 360, 300, 1);
	local ct2_indicator 	= gui.Checkbox(ct2_feature, "tindicator", "Indicator", true);
		local indicator_rgb		= gui.ColorPicker(ct2_indicator, "tindicator_rgb", "", 200, 150, 150, 250);
	local ct2_watermark 	= gui.Checkbox(ct2_feature, "twatermark", "Watermark", true);
		local watermark_rgb		= gui.ColorPicker(ct2_watermark, "twatermark_rgb", "", 200, 150, 150, 250);

--##### CHECK WEAPONS #####
local function check_weapon_func()
	if ct2_dmgweapons:GetValue() == 0 then
			pistol_mindmg:SetInvisible(false)
			pistol_ormindmg:SetInvisible(false) 
		hpistol_mindmg:SetInvisible(true)
		hpistol_ormindmg:SetInvisible(true)
		scout_mindmg:SetInvisible(true)
		scout_ormindmg:SetInvisible(true)
		asniper_mindmg:SetInvisible(true)
		asniper_ormindmg:SetInvisible(true)
		sniper_mindmg:SetInvisible(true)
		sniper_ormindmg:SetInvisible(true)
		smg_mindmg:SetInvisible(true)
		smg_ormindmg:SetInvisible(true)
		rifle_mindmg:SetInvisible(true)
		rifle_ormindmg:SetInvisible(true)
		shotgun_mindmg:SetInvisible(true)
		shotgun_ormindmg:SetInvisible(true)
		lmg_mindmg:SetInvisible(true)
		lmg_ormindmg:SetInvisible(true)
	elseif ct2_dmgweapons:GetValue() == 1 then
		pistol_mindmg:SetInvisible(true)
		pistol_ormindmg:SetInvisible(true)
			hpistol_mindmg:SetInvisible(false) 
			hpistol_ormindmg:SetInvisible(false) 
		scout_mindmg:SetInvisible(true)
		scout_ormindmg:SetInvisible(true)
		asniper_mindmg:SetInvisible(true)
		asniper_ormindmg:SetInvisible(true)
		sniper_mindmg:SetInvisible(true)
		sniper_ormindmg:SetInvisible(true)
		smg_mindmg:SetInvisible(true)
		smg_ormindmg:SetInvisible(true)
		rifle_mindmg:SetInvisible(true)
		rifle_ormindmg:SetInvisible(true)
		shotgun_mindmg:SetInvisible(true)
		shotgun_ormindmg:SetInvisible(true)
		lmg_mindmg:SetInvisible(true)
		lmg_ormindmg:SetInvisible(true)
	elseif ct2_dmgweapons:GetValue() == 2 then
		pistol_mindmg:SetInvisible(true)
		pistol_ormindmg:SetInvisible(true)
		hpistol_mindmg:SetInvisible(true)
		hpistol_ormindmg:SetInvisible(true)
			scout_mindmg:SetInvisible(false) 
			scout_ormindmg:SetInvisible(false) 
		asniper_mindmg:SetInvisible(true)
		asniper_ormindmg:SetInvisible(true)
		sniper_mindmg:SetInvisible(true)
		sniper_ormindmg:SetInvisible(true)
		smg_mindmg:SetInvisible(true)
		smg_ormindmg:SetInvisible(true)
		rifle_mindmg:SetInvisible(true)
		rifle_ormindmg:SetInvisible(true)
		shotgun_mindmg:SetInvisible(true)
		shotgun_ormindmg:SetInvisible(true)
		lmg_mindmg:SetInvisible(true)
		lmg_ormindmg:SetInvisible(true)
	elseif ct2_dmgweapons:GetValue() == 3 then
		pistol_mindmg:SetInvisible(true)
		pistol_ormindmg:SetInvisible(true)
		hpistol_mindmg:SetInvisible(true)
		hpistol_ormindmg:SetInvisible(true)
		scout_mindmg:SetInvisible(true)
		scout_ormindmg:SetInvisible(true)
			asniper_mindmg:SetInvisible(false) 
			asniper_ormindmg:SetInvisible(false) 
		sniper_mindmg:SetInvisible(true)
		sniper_ormindmg:SetInvisible(true)
		smg_mindmg:SetInvisible(true)
		smg_ormindmg:SetInvisible(true)
		rifle_mindmg:SetInvisible(true)
		rifle_ormindmg:SetInvisible(true)
		shotgun_mindmg:SetInvisible(true)
		shotgun_ormindmg:SetInvisible(true)
		lmg_mindmg:SetInvisible(true)
		lmg_ormindmg:SetInvisible(true)
	elseif ct2_dmgweapons:GetValue() == 4 then
		pistol_mindmg:SetInvisible(true)
		pistol_ormindmg:SetInvisible(true)
		hpistol_mindmg:SetInvisible(true)
		hpistol_ormindmg:SetInvisible(true)
		scout_mindmg:SetInvisible(true)
		scout_ormindmg:SetInvisible(true)
		asniper_mindmg:SetInvisible(true)
		asniper_ormindmg:SetInvisible(true)
			sniper_mindmg:SetInvisible(false) 
			sniper_ormindmg:SetInvisible(false) 
		smg_mindmg:SetInvisible(true)
		smg_ormindmg:SetInvisible(true)
		rifle_mindmg:SetInvisible(true)
		rifle_ormindmg:SetInvisible(true)
		shotgun_mindmg:SetInvisible(true)
		shotgun_ormindmg:SetInvisible(true)
		lmg_mindmg:SetInvisible(true)
		lmg_ormindmg:SetInvisible(true)
	elseif ct2_dmgweapons:GetValue() == 5 then
		pistol_mindmg:SetInvisible(true)
		pistol_ormindmg:SetInvisible(true)
		hpistol_mindmg:SetInvisible(true)
		hpistol_ormindmg:SetInvisible(true)
		scout_mindmg:SetInvisible(true)
		scout_ormindmg:SetInvisible(true)
		asniper_mindmg:SetInvisible(true)
		asniper_ormindmg:SetInvisible(true)
		sniper_mindmg:SetInvisible(true)
		sniper_ormindmg:SetInvisible(true)
			smg_mindmg:SetInvisible(false)
			smg_ormindmg:SetInvisible(false)
		rifle_mindmg:SetInvisible(true)
		rifle_ormindmg:SetInvisible(true)
		shotgun_mindmg:SetInvisible(true)
		shotgun_ormindmg:SetInvisible(true)
		lmg_mindmg:SetInvisible(true)
		lmg_ormindmg:SetInvisible(true)
	elseif ct2_dmgweapons:GetValue() == 6 then
		pistol_mindmg:SetInvisible(true)
		pistol_ormindmg:SetInvisible(true)
		hpistol_mindmg:SetInvisible(true)
		hpistol_ormindmg:SetInvisible(true)
		scout_mindmg:SetInvisible(true)
		scout_ormindmg:SetInvisible(true)
		asniper_mindmg:SetInvisible(true)
		asniper_ormindmg:SetInvisible(true)
		sniper_mindmg:SetInvisible(true)
		sniper_ormindmg:SetInvisible(true)
		smg_mindmg:SetInvisible(true)
		smg_ormindmg:SetInvisible(true)
			rifle_mindmg:SetInvisible(false)
			rifle_ormindmg:SetInvisible(false)
		shotgun_mindmg:SetInvisible(true)
		shotgun_ormindmg:SetInvisible(true)
		lmg_mindmg:SetInvisible(true)
		lmg_ormindmg:SetInvisible(true)
	elseif ct2_dmgweapons:GetValue() == 7 then
		pistol_mindmg:SetInvisible(true)
		pistol_ormindmg:SetInvisible(true)
		hpistol_mindmg:SetInvisible(true)
		hpistol_ormindmg:SetInvisible(true)
		scout_mindmg:SetInvisible(true)
		scout_ormindmg:SetInvisible(true)
		asniper_mindmg:SetInvisible(true)
		asniper_ormindmg:SetInvisible(true)
		sniper_mindmg:SetInvisible(true)
		sniper_ormindmg:SetInvisible(true)
		smg_mindmg:SetInvisible(true)
		smg_ormindmg:SetInvisible(true)
		rifle_mindmg:SetInvisible(true)
		rifle_ormindmg:SetInvisible(true)
			shotgun_mindmg:SetInvisible(false)
			shotgun_ormindmg:SetInvisible(false)
		lmg_mindmg:SetInvisible(true)
		lmg_ormindmg:SetInvisible(true)
	elseif ct2_dmgweapons:GetValue() == 8 then
		pistol_mindmg:SetInvisible(true)
		pistol_ormindmg:SetInvisible(true)
		hpistol_mindmg:SetInvisible(true)
		hpistol_ormindmg:SetInvisible(true)
		scout_mindmg:SetInvisible(true)
		scout_ormindmg:SetInvisible(true)
		asniper_mindmg:SetInvisible(true)
		asniper_ormindmg:SetInvisible(true)
		sniper_mindmg:SetInvisible(true)
		sniper_ormindmg:SetInvisible(true)
		smg_mindmg:SetInvisible(true)
		smg_ormindmg:SetInvisible(true)
		rifle_mindmg:SetInvisible(true)
		rifle_ormindmg:SetInvisible(true)
		shotgun_mindmg:SetInvisible(true)
		shotgun_ormindmg:SetInvisible(true)
			lmg_mindmg:SetInvisible(false)
			lmg_ormindmg:SetInvisible(false)
	end
end		
callbacks.Register("Draw", check_weapon_func)


--########## WATERMARK ########## 
local localPlayer = entities.GetLocalPlayer();
--if localPlayer == nil or not localPlayer:IsAlive() then return end
local playerResources = entities.FindByClass("C_CSPlayerResource");
local iPing = entities.FindByClass("m_iPing");
local localPlayerIndex = client.GetLocalPlayerIndex();
--local ping = localPlayer:GetPropInt("m_iPing")
--local ping = playerResources:GetPropInt(iping, localPlayer);
--local ping = entities.GetPlayerResources():GetPropInt("m_iPing", client.GetLocalPlayerIndex());
local frame_rate = 0;
local frame = function()  frame_rate = 0.9 * frame_rate + (0.1) * globals.AbsoluteFrameTime();
return math.floor((1 / frame_rate) + 0.5);
end

local function watermark_func()
	--local frame = 1.0 / globals.AbsoluteFrameTime();
	local r, g, b = watermark_rgb:GetValue() 
	local watermarkText = spacer .. cat_icon .. spacer .. script_name .. spacer .. frame() .. " FPS" .. spacer .. cat_icon .. spacer
	if ct2_enable:GetValue() then
		if ct2_watermark:GetValue() then
			draw.SetFont(font_watermark); 
			draw.Color(10, 10, 10, 150);
			draw.FilledRect( (size_x - 10*dpitext) - draw.GetTextSize(watermarkText), 5*dpitext , (size_x-5*dpitext) , vertical *dpitext );
			draw.Color(r, g, b, 250) 
			--draw.OutlinedRect( (size_x - 10*dpitext) - draw.GetTextSize(watermarkText), 5*dpitext , (size_x-5*dpitext) , vertical*dpitext );
			--draw.OutlinedRect( (size_x - 10*dpitext) - draw.GetTextSize(watermarkText), 4*dpitext , (size_x-5*dpitext) , vertical*dpitext );
			draw.RoundedRect( (size_x - 10*dpitext) - draw.GetTextSize(watermarkText), 4*dpitext , (size_x-5*dpitext) , vertical*dpitext, 20*dpitext, 0.2*dpitext, 0.2*dpitext, 0.2*dpitext, 0.2*dpitext );
			draw.Color(250, 250, 250, 250);
			draw.TextShadow( (size_x - 8*dpitext) - draw.GetTextSize(watermarkText), 13*dpitext , watermarkText );
		end
	end
end
callbacks.Register("Draw", watermark_func)

--########## INDICATOR ##########
local function indicator_func()
if ct2_enable:GetValue() then 
if ct2_indicator:GetValue() then
--[[
	local local_player = entities.GetLocalPlayer();
	if local_player == nil or not local_player:IsAlive() then return end
--]]
	local r, g, b = indicator_rgb:GetValue()
	local screenCenterX, screenCenterY = draw.GetScreenSize();
	screenCenterX = screenCenterX * 0.5;
	screenCenterY = screenCenterY * 0.5;

--[[
	if gui.GetValue("rbot.antiaim.base") < 0 and gui.GetValue("rbot.master") == true  then
		draw.Color(r, g, b, 250)
		draw.Triangle(screenCenterX + 50, screenCenterY - 7, screenCenterX + 65, screenCenterY - 7 + 8, screenCenterX + 50, screenCenterY - 7 + 15);
	end
	if gui.GetValue("rbot.antiaim.base") > 0 and gui.GetValue("rbot.master") == true then
		draw.Color(r, g, b, 250)
		draw.Triangle(screenCenterX - 50, screenCenterY - 7, screenCenterX - 65, screenCenterY - 7 + 8, screenCenterX - 50, screenCenterY - 7 + 15);
	end
--]]
	local indCenterX, indCenterY = draw.GetScreenSize();
	local extraY = 30
	local sideextraY = -50
	if gui.GetValue("lbot.master") == true  then
		draw.SetFont(font_indicator);
		draw.Color(r, g, b, 250);
		draw.TextShadow(10, indCenterY / 2 + sideextraY, "LEGIT")
		sideextraY = sideextraY + 13*dpitext
	elseif gui.GetValue("rbot.master") == true then
		draw.SetFont(font_indicator);
		draw.Color(r, g, b, 250)
		draw.TextShadow(indCenterX / 2 - 25 , indCenterY / 2 + extraY, "FOV " .. gui.GetValue("rbot.aim.target.fov") .. "º")
		extraY = extraY + 13*dpitext
	end
	--[[
	if ct2_safemode:GetValue() == true then
		draw.SetFont(font_indicator);
		draw.Color(250, 50, 50, 250)
		draw.TextShadow(10 , indCenterY / 2 + sideextraY , "safemode");
		sideextraY = sideextraY + 13*dpitext
	end
	--]]
	if ct2_koverridedmg:GetValue()  and gui.GetValue("rbot.master") then
		draw.SetFont(font_indicator);
		draw.Color(r, g, b, 250)
		draw.TextShadow(indCenterX / 2 - 25, indCenterY / 2 + extraY, "DMG") --.. core_mindmg:GetValue()  .."")
		extraY = extraY + 13*dpitext
	--elseif not ct2_koverridedmg:GetValue()  and gui.GetValue("rbot.master") then
	end
	if ct2_kautowall:GetValue() == true and gui.GetValue("rbot.master") == true then
		draw.SetFont(font_indicator);
		draw.Color(r, g, b, 250)
		draw.TextShadow(indCenterX / 2 - 25, indCenterY / 2 + extraY, "AWALL")
		extraY = extraY + 13*dpitext
	end
	if ct2_kfreestand:GetValue() == true and gui.GetValue("rbot.master") == true and ct2_safemode:GetValue() == true then
		draw.SetFont(font_indicator);
		draw.Color(r, g, b, 250)
		draw.TextShadow(indCenterX / 2 - 25, indCenterY / 2 + extraY, "EDGE")
		extraY = extraY + 13*dpitext
	end
	if ct2_kforcebaim:GetValue() == true and gui.GetValue("rbot.master") == true then
		draw.SetFont(font_indicator);
		draw.Color(r, g, b, 250)
		draw.TextShadow(indCenterX / 2 - 25, indCenterY / 2 + extraY , "BAIM")
		extraY = extraY + 13*dpitext
	end
--[[
	if ct2_kpitchdown:GetValue() == true and gui.GetValue("rbot.master") == true and ct2_safemode:GetValue() == true then
		draw.SetFont(font_indicator);
		draw.Color(r, g, b, 250)
		draw.TextShadow(indCenterX / 2 - 25, indCenterY / 2 + extraY, "PITCH")
		extraY = extraY + 13*dpitext
	end 
	if gui.GetValue("rbot.aim.aimadj.silentaim") == true and gui.GetValue("rbot.master") == true then
		draw.SetFont(font_indicator);
		draw.Color(250, 50, 50, 250)
		draw.TextShadow(10 , indCenterY / 2 + sideextraY , "SILENT");
		sideextraY = sideextraY + 13*dpitext
	end
	if ct2_krapidfire:GetValue() == true and gui.GetValue("rbot.master") == true and ct2_safemode:GetValue() == true then
		draw.SetFont(font_indicator);
		draw.Color(r, g, b, 250)
		draw.TextShadow(indCenterX / 2 - 25, indCenterY / 2 + extraY, "RAPID")
		extraY = extraY + 13*dpitext
	end
--]]
end
end
end
callbacks.Register("Draw", indicator_func)

--########## MASTERBOT ##########
local function masterbot_func()
	if ct2_enable:GetValue() == true then
		if ct2_kmasterbot:GetValue() then
			gui.SetValue("rbot.master", true)
		else
			gui.SetValue("lbot.master", true)
		end
	end
end
callbacks.Register("Draw", masterbot_func)

--########## AUTOWALL ##########
local function autowall_func()
	if ct2_enable:GetValue() == true then
		if ct2_kautowall:GetValue() then
			for i, v in next, group_weapons do
				gui.SetValue("rbot.hitscan.accuracy.".. v ..".autowall", true)
			end
		else
			for i, v in next, group_weapons do
				gui.SetValue("rbot.hitscan.accuracy.".. v ..".autowall", false)
			end
		end
	end
end
callbacks.Register("Draw", autowall_func)

--########## FREESTAND ##########
local function freestand_func()
	if ct2_enable:GetValue() == true then
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
	if ct2_enable:GetValue() then
	
		if ct2_kforcebaim:GetValue() then
			for i, v in next, group_weapons do
				gui.SetValue("rbot.hitscan.hitbox.".. v ..".head.priority", 0)
				gui.SetValue("rbot.hitscan.hitbox.".. v ..".body.priority", 1)
			end
		else
			for i, v in next, group_weapons do
				gui.SetValue("rbot.hitscan.hitbox.".. v ..".head.priority", 1)
				gui.SetValue("rbot.hitscan.hitbox.".. v ..".body.priority", 0)
			end
		end
	end
end
callbacks.Register("Draw", forcebaim_func)

--########## OVERRIDE/MIN-DAMAGE ##########
local function min_damage_func()
	if ct2_enable:GetValue() then
	if enable_override:GetValue() then
		if ct2_koverridedmg:GetValue() then
			if pistol_ormindmg:GetValue() >= 1 then
				gui.SetValue("rbot.hitscan.accuracy.pistol.mindamage", pistol_ormindmg:GetValue())
			end
			if hpistol_ormindmg:GetValue() >= 1 then
				gui.SetValue("rbot.hitscan.accuracy.hpistol.mindamage", hpistol_ormindmg:GetValue())
			end
			if scout_ormindmg:GetValue() >= 1 then
				gui.SetValue("rbot.hitscan.accuracy.scout.mindamage", scout_ormindmg:GetValue())
			end
			if asniper_ormindmg:GetValue() >= 1 then
				gui.SetValue("rbot.hitscan.accuracy.asniper.mindamage", asniper_ormindmg:GetValue())
			end
			if sniper_ormindmg:GetValue() >= 1 then
				gui.SetValue("rbot.hitscan.accuracy.sniper.mindamage", sniper_ormindmg:GetValue())
			end
			if smg_ormindmg:GetValue() >= 1 then
				gui.SetValue("rbot.hitscan.accuracy.smg.mindamage", smg_ormindmg:GetValue())
			end
			if rifle_ormindmg:GetValue() >= 1 then
				gui.SetValue("rbot.hitscan.accuracy.rifle.mindamage", rifle_ormindmg:GetValue())
			end
			if shotgun_ormindmg:GetValue() >= 1 then
				gui.SetValue("rbot.hitscan.accuracy.shotgun.mindamage", shotgun_ormindmg:GetValue())
			end
			if lmg_ormindmg:GetValue() >= 1 then
				gui.SetValue("rbot.hitscan.accuracy.lmg.mindamage", lmg_ormindmg:GetValue())
			end
		else
			if pistol_mindmg:GetValue() >= 1 then
				gui.SetValue("rbot.hitscan.accuracy.pistol.mindamage", pistol_mindmg:GetValue())
			end
			if hpistol_mindmg:GetValue() >= 1 then
				gui.SetValue("rbot.hitscan.accuracy.hpistol.mindamage", hpistol_mindmg:GetValue())
			end
			if scout_mindmg:GetValue() >= 1 then
				gui.SetValue("rbot.hitscan.accuracy.scout.mindamage", scout_mindmg:GetValue())
			end
			if asniper_mindmg:GetValue() >= 1 then
				gui.SetValue("rbot.hitscan.accuracy.asniper.mindamage", asniper_mindmg:GetValue())
			end
			if sniper_mindmg:GetValue() >= 1 then
				gui.SetValue("rbot.hitscan.accuracy.sniper.mindamage", sniper_mindmg:GetValue())
			end
			if smg_mindmg:GetValue() >= 1 then
				gui.SetValue("rbot.hitscan.accuracy.smg.mindamage", smg_mindmg:GetValue())
			end
			if rifle_mindmg:GetValue() >= 1 then
				gui.SetValue("rbot.hitscan.accuracy.rifle.mindamage", rifle_mindmg:GetValue())
			end
			if shotgun_mindmg:GetValue() >= 1 then
				gui.SetValue("rbot.hitscan.accuracy.shotgun.mindamage", shotgun_mindmg:GetValue())
			end
			if lmg_mindmg:GetValue() >= 1 then
				gui.SetValue("rbot.hitscan.accuracy.lmg.mindamage", lmg_mindmg:GetValue())
			end
		end
	end
	end
end
callbacks.Register("Draw", min_damage_func)

--##### CHECK SAFEMODE #####
local function safemode_func()
	if ct2_enable:GetValue() then
		if ct2_safemode:GetValue() then
			ct2_sfreestand:SetDisabled(true)
			ct2_kfreestand:SetDisabled(true)
			gui.SetValue("misc.antiuntrusted", true) 
			gui.SetValue("rbot.antiaim.base", "0 Off")
			gui.SetValue("rbot.antiaim.advanced.pitch", "Off")
			--gui.SetValue("rbot.aim.aimadj.silentaim", false)
			--gui.SetValue("rbot.antiaim.condition.autodir.edges", false)
			gui.SetValue("rbot.antiaim.right", "0 Off")
			gui.SetValue("rbot.antiaim.left", "0 Off")
			gui.SetValue("rbot.aim.aimadj.antispread", false)
			--[[ 
			for i, v in next, group_weapons do
				gui.SetValue("rbot.hitscan.accuracy.".. v ..".enhitchance", false)
			end
			--]]
			if gui.GetValue("rbot.aim.target.fov") >= 30 then
				gui.SetValue("rbot.aim.target.fov", 30)
			end
		else
			ct2_sfreestand:SetDisabled(false)
			ct2_kfreestand:SetDisabled(false)
		end
	end
end
callbacks.Register("Draw", safemode_func)

--[[
CHANGELOG
2.0 
	release script support counterstrike 2
2.1 
	added 
2.2 
	added rapid-fire bindkey; 
	random jitter;
	oneway-weapons slider rapidfirespeed; 
	custom rgb watermark/indicator;
	override/min-damage;
2.3 
	added FPS in watermark, auto-updater, support dpiel ements, safemode
	removed rapidfire,magicbullet,nospread,safepoint,unsafemode,yaw random,jitter and pitchdown
	fixed gui menu and enable indicator
2.31 soon ? need test
	added pitch down bindkey ?
	aa manual righ and left ?
	added rapdifire
	need improve indicator
	add ping, etc in Watermark
2.4 FUTURE 
	toggle visual hack legitbot 
	watermark line top rainbow
	rainbow bottom line
	yaw AA inverter
	aim-step AA safe
	dyminac fov min-max + safe max 30 or 40 FOV
	aspect ratio
--]]