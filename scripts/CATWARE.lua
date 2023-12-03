--[[
#########################################################
			 Script LUA Aimware v5.1.x CS:2
			Created by blurry and Cl0ne helped
💗 Leave a +rep on my profile if you enjoy using this script! 💗
		UID: https://aimware.net/forum/user/61632
#########################################################
--]]

--##### VARIABLE #####
	local cat_icon = "🐱";
	local spacer = " ";
	local version = " v2.2";
    local script_name = "CATWARE.lua";-- .. version .. "";
	local player_name = cheat.GetUserName(); 
	--local player_fps = 1 / globals.AbsoluteFrameTime(); 
	local font_watermark = draw.CreateFont("Verdana", 13, 900);
	--local curtime = globals.CurTime(); 
	local size_x, size_y = draw.GetScreenSize(watermarkText);
	local vertical, horizontal = 30, 70;
	local font_indicator = draw.CreateFont("Tahoma", 15, 1300); 



--##### REFERENCE #####
local ct2_reference 	= gui.Reference("SETTINGS"); 
	local ct2_tab 			= gui.Tab(ct2_reference, "catware2", "CATWARE.lua"); 
		local ct2_box 			= gui.Groupbox(ct2_tab, "Welcome to semirager, ".. player_name .." !" , 10, 5, 300, 1);  -- 
			local ct2_enable 		= gui.Checkbox(ct2_box, "enable", "Enable Master", true); 
			local ct2_unsafe 		= gui.Checkbox(ct2_box, "unsafe", "Unsafe mode", false); 
				  ct2_unsafe:SetDescription("*WARNING* Drop trust factor or get banned"); 


--##### TAB SLIDER #####
local ct2_slider		= gui.Groupbox(ct2_tab, "Slider", 10, 150, 300, 1); 
	local ct2_sfreestand	= gui.Slider(ct2_slider, "sfreestand", "Freestand", 0, 0, 90, 1); 
	--local ct2_syaw			= gui.Slider(ct2_slider, "syaw", "Anti-Aim Yaw", 0, 0, 60, 1); 
	local ct2_syjitter		= gui.Slider(ct2_slider, "srangejitter", "Range Jitter", 0, 0, 180, 1); 
	--local ct2_srapidspeed	= gui.Slider(ct2_slider, "srapidspeed", "Rapidfire speed", 0, 0, 20, 1); 
	local ct2_dmgweapons	= gui.Combobox(ct2_slider, "dmgweapons", "Type weapon", "Pistol", "Deagle/R8", "Scout", "Auto", "AWP", "Submachine", "Rifle", "Shotgun", "Negev"); 
	--local main_mindmg = {"shared","zeus","pistol","hpistol","smg","rifle","shotgun","scout","asniper","sniper","lmg"}
	local pistol_mindmg		= gui.Slider(ct2_slider, "spistol_mindmg", "Pistol Min. damage", 0, 0, 130, 1); 
	local pistol_ormindmg	= gui.Slider(ct2_slider, "spistol_ormindmg", "Pistol Override damage", 0, 0, 70, 1); 
	local hpistol_mindmg	= gui.Slider(ct2_slider, "shpistol_mindmg", "Deagle/R8 Min. damage", 0, 0, 130, 1); 
	local hpistol_ormindmg	= gui.Slider(ct2_slider, "shpistol_ormindmg", "Deagle/R8 Override damage", 0, 0, 70, 1); 
	local scout_mindmg		= gui.Slider(ct2_slider, "sscout_mindmg", "Scout Min. damage", 0, 0, 130, 1); 
	local scout_ormindmg	= gui.Slider(ct2_slider, "sscout_ormindmg", "Scout Override damage", 0, 0, 70, 1); 
	local asniper_mindmg	= gui.Slider(ct2_slider, "sasniper_mindmg", "Auto Min. damage", 0, 0, 130, 1); 
	local asniper_ormindmg	= gui.Slider(ct2_slider, "sasniper_ormindmg", "Auto Override damage", 0, 0, 70, 1); 
	local sniper_mindmg		= gui.Slider(ct2_slider, "ssniper_mindmg", "AWP Min. damage", 0, 0, 130, 1); 
	local sniper_ormindmg	= gui.Slider(ct2_slider, "ssniper_ormindmg", "AWP Override damage", 0, 0, 70, 1); 
	local smg_mindmg		= gui.Slider(ct2_slider, "ssmg_mindmg", "Submachine Min. damage", 0, 0, 130, 1); 
	local smg_ormindmg		= gui.Slider(ct2_slider, "ssmg_ormindmg", "Submachine Override damage", 0, 0, 70, 1); 
	local rifle_mindmg		= gui.Slider(ct2_slider, "srifle_mindmg", "Rifle Min. damage", 0, 0, 130, 1); 
	local rifle_ormindmg	= gui.Slider(ct2_slider, "srifle_ormindmgg", "Rifle Override damage", 0, 0, 70, 1); 
	local shotgun_mindmg	= gui.Slider(ct2_slider, "sshotgun_mindmg", "Shotgun Min. damage", 0, 0, 130, 1); 
	local shotgun_ormindmg	= gui.Slider(ct2_slider, "sshotgun_ormindmg", "Shotgun Override damage", 0, 0, 70, 1); 
	local lmg_mindmg		= gui.Slider(ct2_slider, "slmg_mindmg", "Negev Min. damage", 0, 0, 130, 1); 
	local lmg_ormindmg		= gui.Slider(ct2_slider, "slmg_ormindmg", "Negev Override damage", 0, 0, 70, 1); 
	--local core_mindmg = pistol_ormindmg, hpistol_ormindmg, scout_ormindmg, asniper_ormindmg, sniper_ormindmg


--##### TAB KEYBINDS #####
local ct2_keybind 		= gui.Groupbox(ct2_tab, "Bindkeys", 320, 5, 300, 1); 
	  ct2_keybind:SetDescription("Toggle/hold key"); 
	local ct2_kmasterbot 	= gui.Checkbox(ct2_keybind, "kswitchsemi", "Semirage", false); 
	local ct2_kautowall 	= gui.Checkbox(ct2_keybind, "kautowall", "AutoWall", false); 
	local ct2_kforcebaim 	= gui.Checkbox(ct2_keybind, "kforcebaim", "Bodyaim", false); 
	local ct2_koverridedmg 	= gui.Checkbox(ct2_keybind, "koverridedmg", "Override Damage", false); 
	--local ct2_kinverter 	= gui.Checkbox(ct2_keybind, "kinverter", "AA Yaw Inverter", false); 
	local ct2_kfreestand 	= gui.Checkbox(ct2_keybind, "kfreestand", "Freestand", false); 
	local ct2_kpitchdown 	= gui.Checkbox(ct2_keybind, "kpitchdown", "Pitch down", false);
		  ct2_kpitchdown:SetDescription("Detectable vac live"); 
	--local ct2_krapidfire	= gui.Checkbox(ct2_keybind, "krapidfire", "Rapidfire", false); 
	--local ct2_kmagicbullet	= gui.Keybox(ct2_keybind, "kmagicbullet", "Magic Bullet", 0);


--##### TAB FEATURE #####
local ct2_feature 		= gui.Groupbox(ct2_tab, "Features", 320, 340, 300, 1); 
	local ct2_indicator 	= gui.Checkbox(ct2_feature, "tindicator", "Indicator", true);
		local indicator_rgb		= gui.ColorPicker(ct2_indicator, "tindicator_rgb", "", 200, 150, 150, 250);  -- 200, 150, 150 RGB cyberpink
	local ct2_watermark 	= gui.Checkbox(ct2_feature, "twatermark", "Watermark", true);
		local watermark_rgb		= gui.ColorPicker(ct2_watermark, "twatermark_rgb", "", 200, 150, 150, 250); 
	local ct2_yjitter 		= gui.Checkbox(ct2_feature, "tjitter", "Random Jitter", false);



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



--##### CHECK UNSAFE #####
local function check_unsafe_func()

	if ct2_unsafe:GetValue() then
		ct2_sfreestand:SetDisabled(false)
		--ct2_syaw:SetDisabled(false)
		ct2_syjitter:SetDisabled(false)
		--ct2_srapidspeed:SetDisabled(false)
		--ct2_kinverter:SetDisabled(false)
		ct2_kfreestand:SetDisabled(false)
		ct2_kpitchdown:SetDisabled(false)
		--ct2_krapidfire:SetDisabled(false)
		--ct2_kmagicbullet:SetDisabled(false)
		ct2_yjitter:SetDisabled(false)
		
	else
		ct2_sfreestand:SetDisabled(true)
		--ct2_syaw:SetDisabled(true)
		ct2_syjitter:SetDisabled(true)
		--ct2_srapidspeed:SetDisabled(true)
		--ct2_kinverter:SetDisabled(true)
		ct2_kfreestand:SetDisabled(true)
		ct2_kpitchdown:SetDisabled(true)
		--ct2_krapidfire:SetDisabled(true)
		--ct2_kmagicbullet:SetDisabled(true)
		ct2_yjitter:SetDisabled(true)
	end
	
end		
callbacks.Register("Draw", check_unsafe_func)



--########## UNSAFE ##########
local function unsafe_func()

	local unsafe_weapons = {"shared","zeus","pistol","hpistol","smg","rifle","shotgun","scout","asniper","sniper","lmg", "knife"}
	
	if ct2_enable:GetValue() then
	
		if not ct2_unsafe:GetValue() then
			gui.SetValue("misc.antiuntrusted", true)
			gui.SetValue("rbot.antiaim.base", "0 Off")
			gui.SetValue("rbot.antiaim.advanced.pitch", "Off")
			gui.SetValue("rbot.aim.aimadj.silentaim", false)
			gui.SetValue("rbot.antiaim.condition.autodir.edges", false)
			gui.SetValue("rbot.antiaim.right", "0 Off")
			gui.SetValue("rbot.antiaim.left", "0 Off")
			--[[
			for i, v in next, unsafe_weapons do
				gui.SetValue("rbot.accuracy.attack.".. v ..".fire", "Off")
			end
			--]]
			if gui.GetValue("rbot.aim.target.fov") >= 30 then
				gui.SetValue("rbot.aim.target.fov", 30)
			end
			
		end
		
	end

end
callbacks.Register("Draw", unsafe_func)



--########## WATERMARK ########## 
local function watermark_func()

	local r, g, b = watermark_rgb:GetValue() 
	local watermarkText = spacer .. cat_icon .. spacer .. script_name .. spacer .. cat_icon .. spacer
	
	if ct2_enable:GetValue() then
	
		if ct2_watermark:GetValue() then
			draw.SetFont(font_watermark); 
			
			draw.Color(10, 10, 10, 150);
			draw.FilledRect((size_x - 10) - draw.GetTextSize(watermarkText), 5, size_x - 5, vertical );
			
			draw.Color(r, g, b, 250) 
			draw.OutlinedRect((size_x - 10) - draw.GetTextSize(watermarkText), 5, size_x - 5, vertical);
			draw.OutlinedRect((size_x - 10) - draw.GetTextSize(watermarkText), 4, size_x - 5, vertical);
			
			draw.Color(250, 250, 250, 250);
			draw.TextShadow((size_x - 8) - draw.GetTextSize(watermarkText), 13, watermarkText);
		end
	end
	
end
callbacks.Register("Draw", watermark_func)



--########## INDICATOR ##########
local function indicator_func()

	--if ct2_enable:GetValue() then 
		--if ct2_indicator:GetValue() then

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
		draw.Text(10, indCenterY / 2 + sideextraY, "LEGIT")
		sideextraY = sideextraY + 13
	elseif gui.GetValue("rbot.master") == true then
		draw.SetFont(font_indicator);
		draw.Color(r, g, b, 250)
		draw.Text(indCenterX / 2 - 25 , indCenterY / 2 + extraY, "RAGE fov " .. gui.GetValue("rbot.aim.target.fov") .. "º")
		extraY = extraY + 13
	end
	
	
	if ct2_unsafe:GetValue() == true then
		draw.SetFont(font_indicator);
		draw.Color(250, 50, 50, 250)
		draw.TextShadow(10 , indCenterY / 2 + sideextraY , "UNSAFE");
		sideextraY = sideextraY + 13
	end
	if gui.GetValue("rbot.aim.aimadj.silentaim") == true and gui.GetValue("rbot.master") == true then
		draw.SetFont(font_indicator);
		draw.Color(250, 50, 50, 250)
		draw.TextShadow(10 , indCenterY / 2 + sideextraY , "SILENT");
		sideextraY = sideextraY + 13
	end
	if ct2_koverridedmg:GetValue()  and gui.GetValue("rbot.master") then
		draw.SetFont(font_indicator);
		draw.Color(r, g, b, 250)
		draw.Text(indCenterX / 2 - 25, indCenterY / 2 + extraY, "DMG") --.. core_mindmg:GetValue()  .."")
		extraY = extraY + 13
	--elseif not ct2_koverridedmg:GetValue()  and gui.GetValue("rbot.master") then
	end
	if ct2_kautowall:GetValue() == true and gui.GetValue("rbot.master") == true then
		draw.SetFont(font_indicator);
		draw.Color(r, g, b, 250)
		draw.Text(indCenterX / 2 - 25, indCenterY / 2 + extraY, "AWALL")
		extraY = extraY + 13
	end
	if ct2_kfreestand:GetValue() == true and gui.GetValue("rbot.master") == true and ct2_unsafe:GetValue() == true then
		draw.SetFont(font_indicator);
		draw.Color(r, g, b, 250)
		draw.Text(indCenterX / 2 - 25, indCenterY / 2 + extraY, "EDGE")
		extraY = extraY + 13
	end
	if ct2_kforcebaim:GetValue() == true and gui.GetValue("rbot.master") == true then
		draw.SetFont(font_indicator);
		draw.Color(r, g, b, 250)
		draw.Text(indCenterX / 2 - 25, indCenterY / 2 + extraY , "BAIM")
		extraY = extraY + 13
	end

	if ct2_kpitchdown:GetValue() == true and gui.GetValue("rbot.master") == true and ct2_unsafe:GetValue() == true then
		draw.SetFont(font_indicator);
		draw.Color(r, g, b, 250)
		draw.Text(indCenterX / 2 - 25, indCenterY / 2 + extraY, "PITCH")
		extraY = extraY + 13
	end 
--[[
	if ct2_krapidfire:GetValue() == true and gui.GetValue("rbot.master") == true and ct2_unsafe:GetValue() == true then
		draw.SetFont(font_indicator);
		draw.Color(r, g, b, 250)
		draw.Text(indCenterX / 2 - 25, indCenterY / 2 + extraY, "RAPID")
		extraY = extraY + 13
	end

	if ct2_kmagicbullet:GetValue() ~= 0 and gui.GetValue("rbot.master") == true and ct2_unsafe:GetValue() == true and input.IsButtonDown(ct2_kmagicbullet:GetValue()) then
		draw.SetFont(font_indicator);
		draw.Color(r, g, b, 250)
		draw.Text(indCenterX / 2 - 25, indCenterY / 2 + extraY, "MAGIC")
		extraY = extraY + 13
	end
--]]
	
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

	local aw_weapons = {"shared","pistol","hpistol","smg","rifle","shotgun","scout","asniper","sniper","lmg"}
	
	if ct2_enable:GetValue() == true then
		if ct2_kautowall:GetValue() then
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
   
	if ct2_enable:GetValue() then
	
		if ct2_kforcebaim:GetValue() then
			for i, v in next, baim_weapons do
				gui.SetValue("rbot.hitscan.hitbox.".. v ..".head.priority", 0)
				gui.SetValue("rbot.hitscan.hitbox.".. v ..".body.priority", 1)
				--gui.SetValue("rbot.hitscan.extra.".. v ..".safepoint.body", 1)
				gui.SetValue("rbot.hitscan.extra.".. v ..".safepoint.forcebody", 1)
			end
		else
			for i, v in next, baim_weapons do
				gui.SetValue("rbot.hitscan.hitbox.".. v ..".head.priority", 1)
				gui.SetValue("rbot.hitscan.hitbox.".. v ..".body.priority", 0)
				--gui.SetValue("rbot.hitscan.extra.".. v ..".safepoint.body", 0)
				gui.SetValue("rbot.hitscan.extra.".. v ..".safepoint.forcebody", 0)
			end
			
		end
	end
	
end
callbacks.Register("Draw", forcebaim_func)



--########## PITCH DOWN ##########
local function pitchdown_func()
	
	if ct2_enable:GetValue() and ct2_unsafe:GetValue() then
	
		if ct2_kpitchdown:GetValue() then
			gui.SetValue("rbot.antiaim.advanced.pitch", 1)
			gui.SetValue("rbot.antiaim.condition.autodir.targets", true)
			gui.SetValue("rbot.antiaim.base", "180 Backward")
		else
			gui.SetValue("rbot.antiaim.advanced.pitch", "Off")
			gui.SetValue("rbot.antiaim.condition.autodir.targets", false)
			gui.SetValue("rbot.antiaim.base", "0 Off")
			
		end
	end
	
end
callbacks.Register("Draw", pitchdown_func)


--[[
--########## RAPIDFIRE ##########
local function rapidfire_func()
	
	local rapidfire_weapons = {"shared","zeus","pistol","hpistol","smg","rifle","shotgun","scout","asniper","sniper","lmg", "knife"}
	
	if ct2_enable:GetValue() == true and ct2_unsafe:GetValue() == true then
		if ct2_krapidfire:GetValue() then
			for i, v in next, rapidfire_weapons do
				gui.SetValue("rbot.accuracy.attack.".. v ..".fire", "Rapid Fire") 
			end
		else
			for i, v in next, rapidfire_weapons do
				gui.SetValue("rbot.accuracy.attack.".. v ..".fire", "Off")
			end
		end
		if ct2_srapidspeed:GetValue() >= 1 and ct2_krapidfire:GetValue() then
			for i, v in next, rapidfire_weapons do
				gui.SetValue("rbot.accuracy.attack.".. v ..".speed", ct2_srapidspeed:GetValue()) 
			end
		end
	end
	
end
callbacks.Register("Draw", rapidfire_func)
--]]

--[[
--########## MAGIC BULLET ##########
local function magicbullet_func()
	
	local magicbullet_weapons = {"shared","zeus","pistol","hpistol","smg","rifle","shotgun","scout","asniper","sniper","lmg", "knife"}

	if ct2_enable:GetValue() and ct2_unsafe:GetValue() then
		if ct2_kmagicbullet:GetValue() ~= 0 and input.IsButtonDown(ct2_kmagicbullet:GetValue()) then
			for i, v in next, magicbullet_weapons do
				gui.SetValue("rbot.accuracy.attack.".. v ..".magic", ct2_kmagicbullet:GetValue())
			end
			if not gui.GetValue( "catware2.kautowall" ) then
				gui.SetValue("catware2.kautowall", true)
			end
		end
	end
	
end
callbacks.Register("Draw", magicbullet_func)
--]]


--########## YAW JITTER RANDOM ##########
local random_base 	= 0;
local curtime 		= globals.CurTime()

local function get_random( number )
	return math.random( number )
end

local function yawjitter_func()
	
	if ct2_enable:GetValue() and ct2_unsafe:GetValue() then
		if ct2_yjitter:GetValue() then --and not ct2_kpitchdown:GetValue() then
			if globals.CurTime() - curtime % 2 then
				if random_base >= 1 then 
					random_base = get_random(ct2_syjitter:GetValue()*-1) 
				elseif random_base <= 0 then
					random_base = get_random(ct2_syjitter:GetValue()*1)
				else 
					random_base = 1
				end
				gui.SetValue("rbot.antiaim.base", random_base)
				curtime = globals.CurTime()
			end
		end
	end
	
end
callbacks.Register("Draw", yawjitter_func)


--########## ANTI-AIM YAW ##########



--########## OVERRIDE/MIN-DAMAGE ##########
local function min_damage_func()

	if ct2_enable:GetValue() then
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
callbacks.Register("Draw", min_damage_func)



--########## FORCE UNCHECK ##########
--[[
local function antiuntrusted_func()
	
	if ct2_enable:GetValue() and ct2_unsafe:GetValue() then
		if ct2_krapidfire:GetValue() or ct2_kmagicbullet:GetValue() ~= 0 and input.IsButtonDown(ct2_kmagicbullet:GetValue()) then
			if gui.GetValue( "misc.antiuntrusted" ) then
				gui.SetValue("misc.antiuntrusted", false)
			end
		else
			gui.SetValue("misc.antiuntrusted", true)
		end
	end
	
end
callbacks.Register("Draw", antiuntrusted_func)
--]]


--[[
CHANGELOG
2.0 +release script support cs2
2.1 +added 
2.2 +added rapid-fire bindkey; 
	random jitter;
	oneway-weapons slider rapidfirespeed; 
	custom rgb watermark/indicator;
	override/min-damage;
2.3 FUTURE 
	toggle visual hack legitbot 
	watermark line top rainbow 
	custom color darkmode theme
	yaw AA inverter
	auto-updater
	aim-step AA safe
	dyminac fov min-max + safe max 30 or 40 FOV
	aspect ratio
--]]