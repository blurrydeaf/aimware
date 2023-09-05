
--[[
#########################################################
				 Script lua aimware
				      by blurry
	 Leave +rep on my profile if enjoy using this script!
		   UID: https://aimware.net/forum/user/61632
#########################################################
]]


--[[
--##### AUTO-UPDATER by m0nsterJ #####
local local_version = "1.1"
---@diagnostic disable-next-line: undefined-global
local local_script_name = GetScriptName()
local github_version_url = "https://raw.githubusercontent.com/ file version checker text"
local github_version = http.Get(github_version_url)
local github_source_url = "https://raw.githubusercontent.com/ file script lua"

if local_version ~= tostring(github_version) then
    print("Now updating " ..local_script_name)
    file.Delete(local_script_name)
    print("Successfully deleted old version of " ..local_script_name)
    file.Write(local_script_name, http.Get(github_source_url))
    local_version = github_version
    print("Successfully updated " ..local_script_name)
---@diagnostic disable-next-line: undefined-global
    UnloadScript(local_script_name)
end
--]]


--##### REFERENCE #####
local rb_reference		= gui.Reference("MISC")
	local rb_tab			= gui.Tab(rb_reference, "catware_script", "CATWARE.lua")
		local rb_box			= gui.Groupbox(rb_tab, "Welcome Semirager! ", 10, 5, 300, 1)
			local rb_enable			= gui.Checkbox(rb_box, "catware_enable", "Enable Master", true)
			local rb_unsafe			= gui.Checkbox(rb_box, "catware_unsafe", "Enable Unsafe", false)
				rb_unsafe:SetDescription("*WARNNING* Lower your trust factor")

--##### FEATURE #####
local rb_feature		= gui.Groupbox(rb_tab, "Feature", 320, 290, 300, 1)
	local rb_unmuted		= gui.Checkbox(rb_feature, "catware_unmuted", "Auto unmuted", 1)
	local rb_walkslide		= gui.Checkbox(rb_feature, 'catware_slidewalk', 'Reverse Slide Walk', false);
	local rb_indicator		= gui.Checkbox(rb_feature, "catware_watermark", "Enable indicator", true);
	--local rb_watermark		= gui.Checkbox(rb_feature, "catware_watermark", "Enable Watermark", true);

--##### KEYBINDS #####
local rb_keybind		= gui.Groupbox(rb_tab, "Bindkey", 320, 5, 300, 1)
	local rb_kinverter		= gui.Checkbox(rb_keybind, "catware_kinverter", "Side Inverter", false)
	local rb_kfreestand		= gui.Checkbox(rb_keybind, "catware_kfreestand", "Freestand", false)
	local rb_kforcebaim		= gui.Checkbox(rb_keybind, "catware_kforcebaim", "Force Bodyaim", 0)
	local rb_kpitchdown		= gui.Checkbox(rb_keybind, "catware_kpitchdown", "Pitch down", false)
	local rb_autowall		= gui.Checkbox(rb_keybind, "catware_autowall", "AutoWall", false)
	local rb_masterswitch	= gui.Checkbox(rb_keybind, "catware_masterswitch", "Switch Rage/Legitbot", false)

--##### SIDE ANTIAIM #####
local rb_antiaim		= gui.Groupbox(rb_tab, "AntiAim", 10, 160, 300, 1)
	local rb_sdesync		= gui.Slider(rb_antiaim, "catware_sdesync", "Desync", 0, 0, 58, 1)
	local rb_syaw			= gui.Slider(rb_antiaim, "catware_syaw", "Yaw", 0, 0, 30, 1)
	local rb_sroll			= gui.Slider(rb_antiaim, "catware_sroll", "Roll", 0, 0, 45, 1)
	local rb_sfreestand		= gui.Slider(rb_antiaim, "catware_sfreestand", "Freestand", 0, 0, 80, 1)
	local rb_spitchdown		= gui.Slider(rb_antiaim, "catware_spitch", "Pitch", 0, 0, 88, 1)


--##### PRINT LOADED #####
print("###################################")
print("Script CATWARE.lua loaded by blurry")
print("###################################")


--http://www.foreui.com/articles/Key_Code_Table.htm
--##### VARIABLE #####
	local cat_icon = "🐱";
	local spacer = " ";
	local version = " 1.2";
    local script_name = "CATWARE" .. version .. "";
	local player_name = cheat.GetUserName()
	local player_fps = 1 / globals.AbsoluteFrameTime()
	local font_watermark = draw.CreateFont("Verdana", 13, 900);
	local curtime = globals.CurTime()
	local size_x, size_y = draw.GetScreenSize(watermarkText);
	local vertical, horizontal = 30, 70;
	local weapons = {"shared","zeus","pistol","hpistol","smg","rifle","shotgun","scout","asniper","sniper","lmg"}
	local font_indicator = draw.CreateFont("Tahoma", 17, 1300)
	local silent = gui.GetValue("rbot.aim.aimadj.silentaim")
	
	
--##########  FUNCTION INDICATOR ##########
local function indicator_func()

	if not rb_enable:GetValue() then return end
	if not rb_indicator:GetValue() then return end
	
	local local_player = entities.GetLocalPlayer();
	if local_player == nil or not local_player:IsAlive() then return end
	
	local screenCenterX, screenCenterY = draw.GetScreenSize();
	
	
	screenCenterX = screenCenterX * 0.5;
	screenCenterY = screenCenterY * 0.5;
	
	if gui.GetValue("rbot.antiaim.base.rotation") < 0 and gui.GetValue("rbot.master") == true  then
		draw.Color(200, 150, 150, 250)
		draw.Triangle(screenCenterX + 50, screenCenterY - 7, screenCenterX + 65, screenCenterY - 7 + 8, screenCenterX + 50, screenCenterY - 7 + 15);
	end
	if gui.GetValue("rbot.antiaim.base.rotation") > 0  then
		draw.Color(200, 150, 150, 250)
		draw.Triangle(screenCenterX - 50, screenCenterY - 7, screenCenterX - 65, screenCenterY - 7 + 8, screenCenterX - 50, screenCenterY - 7 + 15);
	end
	
	local indCenterX, indCenterY = draw.GetScreenSize();
	local extraY = 30
	local sideextraY = -50
	
	if gui.GetValue("misc.catware_script.catware_unsafe") == true then
		draw.SetFont(font_indicator);
		draw.Color(250, 50, 50, 250)
		draw.TextShadow(10 , indCenterY / 2 + sideextraY , "UNSAFE");
		sideextraY = sideextraY + 17
	end
	if gui.GetValue("lbot.master") == true  then
		draw.SetFont(font_indicator);
		draw.Color(200, 150, 150, 250);
		draw.Text(10, indCenterY / 2 + sideextraY, "LEGIT")
		sideextraY = sideextraY + 17
	elseif gui.GetValue("rbot.master") == true then
		draw.SetFont(font_indicator);
		draw.Color(200, 150, 150, 250)
		draw.Text(10 , indCenterY / 2 + sideextraY, "RAGE " .. gui.GetValue("rbot.aim.target.fov") .. "º")
		sideextraY = sideextraY + 17
	end
	if gui.GetValue("misc.catware_script.catware_kfreestand") == true and gui.GetValue("rbot.master") == true and gui.GetValue("misc.catware_script.catware_unsafe") == true then
		draw.SetFont(font_indicator);
		draw.Color(200, 150, 150, 250)
		draw.Text(indCenterX / 2 - 25, indCenterY / 2 + extraY, "EDGE")
		extraY = extraY + 15
	end
	if gui.GetValue("misc.catware_script.catware_kforcebaim") == true and gui.GetValue("rbot.master") == true then
		draw.SetFont(font_indicator);
		draw.Color(200, 150, 150, 250)
		draw.Text(indCenterX / 2 - 25, indCenterY / 2 + extraY , "BAIM")
		extraY = extraY + 15

	end
	if gui.GetValue("misc.catware_script.catware_unsafe") == true and gui.GetValue("rbot.master") == true and gui.GetValue("misc.catware_script.catware_kpitchdown") == true or gui.GetValue("rbot.antiaim.advanced.pitch") == 1 then
		draw.SetFont(font_indicator);
		draw.Color(200, 150, 150, 250)
		draw.Text(indCenterX / 2 - 25, indCenterY / 2 + extraY, "PITCH " .. gui.GetValue("misc.catware_script.catware_spitch") .. "°")
		extraY = extraY + 15
	end
	if gui.GetValue("misc.catware_script.catware_autowall") == true and gui.GetValue("rbot.master") == true then
		draw.SetFont(font_indicator);
		draw.Color(200, 150, 150, 250)
		draw.Text(indCenterX / 2 - 25, indCenterY / 2 + extraY, "AWALL")
		extraY = extraY + 15
	end
	

	local key_fakeduck = gui.GetValue("rbot.antiaim.extra.fakecrouchkey")
	if input.IsButtonDown(key_fakeduck) and gui.GetValue("rbot.master") == true then
		draw.SetFont(font_indicator);
		draw.Color(200, 150, 150, 250)
		draw.Text(indCenterX / 2 - 25, indCenterY / 2 + extraY, "FAKEDUCK")
		extraY = extraY + 15
	end
end


--##########  FUNCTION WATERMARK ########## 
local function watermark_func()
	if not rb_enable:GetValue() then return end
	local watermarkText = spacer .. cat_icon .. spacer .. script_name .. spacer .. player_name .. spacer .. cat_icon .. spacer
	--print(size_w .. "x" .. size_h);
	draw.SetFont(font_watermark); 
	draw.Color(10, 10, 10, 150);
	draw.FilledRect((size_x - 10) - draw.GetTextSize(watermarkText), 5, size_x - 5, vertical );
	draw.Color(200, 150, 150, 250)
	draw.OutlinedRect((size_x - 10) - draw.GetTextSize(watermarkText), 5, size_x - 5, vertical);
	draw.Color(250, 250, 250, 250);
	draw.TextShadow((size_x - 8) - draw.GetTextSize(watermarkText), 13, watermarkText);
end


--########## UNLOCK INVENTORY THE SERVERS VALVE ##########
function unlockinventory_func()
	if not rb_enable:GetValue() then return end
	panorama.RunScript([[ LoadoutAPI.IsLoadoutAllowed = () => { return true; }; ]])
end


--##########  UNSAFE MODE OFF ANTI-UNTRUSTED ##########
local function unsafe_func()
	if not rb_unsafe:GetValue() then
		gui.SetValue("misc.antiuntrusted", 1)
		gui.SetValue("rbot.antiaim.base", 0)
		gui.SetValue("rbot.antiaim.advanced.pitch", 0)
		gui.SetValue("rbot.antiaim.advanced.antiresolver", 0)
		gui.SetValue("rbot.antiaim.advanced.roll", 0)
		gui.SetValue("rbot.aim.aimadj.silentaim", 0)
	else
		gui.SetValue("misc.antiuntrusted", 0)
	end
end


--##########  FUNCTION ANTIAIM BASE ##########
local function antiaim_func(cmd)
	if not rb_enable:GetValue() then return end
	if not rb_kinverter:GetValue() then 
		gui.SetValue("rbot.antiaim.base", "0 Desync")
		gui.SetValue("rbot.antiaim.base.rotation", rb_sdesync:GetValue())
		gui.SetValue("rbot.antiaim.base", rb_syaw:GetValue())
		cmd.viewangles = EulerAngles(cmd.viewangles.x, cmd.viewangles.y, rb_sroll:GetValue())
	else
		gui.SetValue("rbot.antiaim.base.rotation", rb_sdesync:GetValue()*-1)
		gui.SetValue("rbot.antiaim.base", rb_syaw:GetValue()*-1)
		cmd.viewangles = EulerAngles(cmd.viewangles.x, cmd.viewangles.y, rb_sroll:GetValue()*-1)
	end
	cmd.viewangles = EulerAngles(cmd.viewangles.x, cmd.viewangles.y, cmd.viewangles.z)
end


--##########  FUNCTION ANTIAIM PITCH ##########
local function pitch_func(cmd)
	if not rb_enable:GetValue() or not rb_unsafe:GetValue() or not gui.GetValue("rbot.master") == true then return end
	local local_player = entities.GetLocalPlayer()
	if local_player == nil or not local_player:IsAlive() then return end
	local weapon_id = local_player:GetWeaponID()
	if weapon_id > 42 and weapon_id < 49 then return end --getting error  nil 

	if rb_kpitchdown:GetValue() and bit.band(cmd.buttons, bit.lshift(1, 0)) ~= 1 then
		cmd.viewangles = EulerAngles(rb_spitchdown:GetValue(), cmd.viewangles.y, cmd.viewangles.z)
		gui.SetValue("rbot.antiaim.condition.autodir.targets", 1)
		gui.SetValue("rbot.aim.aimadj.silentaim", 0)
		gui.SetValue("rbot.antiaim.base", 180)
	else
		cmd.viewangles = EulerAngles(cmd.viewangles.x, cmd.viewangles.y, cmd.viewangles.z)
		gui.SetValue("rbot.aim.aimadj.silentaim", 1)
	end
end


--##########  FUNCTION FOR FREESTAND ON PEEK ##########
local function freestand_func()
	if not rb_enable:GetValue() then return end
	if not rb_unsafe:GetValue() then return end
	if rb_kfreestand:GetValue() then
		gui.SetValue("rbot.antiaim.condition.autodir.edges", true)
		
		gui.SetValue("rbot.antiaim.right", "0 Backward")
		--gui.SetValue("rbot.antiaim.base", "0 Desync")
		gui.SetValue("rbot.antiaim.right", rb_sfreestand:GetValue()*-1)
		gui.SetValue("rbot.antiaim.right.rotation", rb_sdesync:GetValue()*1)
		
		gui.SetValue("rbot.antiaim.left", "0 Backward")
		--gui.SetValue("rbot.antiaim.base", "0 Desync")
		gui.SetValue("rbot.antiaim.left", rb_sfreestand:GetValue()*1)
		gui.SetValue("rbot.antiaim.left.rotation", rb_sdesync:GetValue()*-1)
		--gui.SetValue("rbot.antiaim.advanced.pitch", 2)
	else
		gui.SetValue("rbot.antiaim.condition.autodir.edges", false)
		--gui.SetValue("rbot.antiaim.advanced.pitch", 0)
	end
end


--##########  FUNCTION FORCE BODYAIM ##########
local function forcebaim_func()
	if not rb_enable:GetValue() then return end
	--local weapons = {"shared","zeus","pistol","hpistol","smg","rifle","shotgun","scout","asniper","sniper","lmg"}
    if rb_kforcebaim:GetValue() then
		for i, v in next, weapons do
		gui.SetValue("rbot.hitscan.hitbox.".. v ..".head.priority",0)
		gui.SetValue("rbot.hitscan.hitbox.".. v ..".body.priority",1)
		--gui.SetValue("rbot.hitscan.extra.".. v ..".safepoint.body",1)
		gui.SetValue("rbot.hitscan.extra.".. v ..".safepoint.forcebody",1)
		end
	else
		for i, v in next, weapons do
		gui.SetValue("rbot.hitscan.hitbox.".. v ..".head.priority",1)
		gui.SetValue("rbot.hitscan.hitbox.".. v ..".body.priority",0)
		--gui.SetValue("rbot.hitscan.extra.".. v ..".safepoint.body",0)
		gui.SetValue("rbot.hitscan.extra.".. v ..".safepoint.forcebody",0)
		end
	end
end


--##########  FUNCTION WALKSLIDE ##########
local function walkslide_func(cmd)
	if not rb_enable:GetValue() then return end
    if rb_walkslide:GetValue() then
        gui.SetValue("misc.slidewalk", not cmd.sendpacket) -- thank shared GLadiator
    end
end


--##########  FUNCTION OVERRIDE MIN DAMAGE ##########
local function mindmg_func()
	--SOON
end


--##########  FUNCTION AUTOWALL ##########
local function autowall_func()
	if not rb_enable:GetValue() then return end
    if rb_autowall:GetValue() then
		for i, v in next, weapons do
		gui.SetValue("rbot.hitscan.accuracy.".. v ..".autowall", 1)
		end
	else
		for i, v in next, weapons do
		gui.SetValue("rbot.hitscan.accuracy.".. v ..".autowall", 0)
		end
	end
end


--##########  FUNCTION AUTO UNMUTE ##########
function unmuter(index)
    panorama.RunScript([[
        (function unmute() {
            var xuid = GameStateAPI.GetPlayerXuidStringFromEntIndex(]].. index ..[[)
            var deleteMute = GameStateAPI.IsSelectedPlayerMuted(xuid)
            if (deleteMute) GameStateAPI.ToggleMute(xuid)
        } )()
    ]])
end
local function startUnmute(event)
	if not rb_enable:GetValue() then return end
	if not rb_unmuted:GetValue() then return end
	if( event:GetName() and event:GetName() ~= "round_start" ) then return end;
	local players = entities.FindByClass("CCSPlayer");
	for k,v in pairs(players) do
		unmuter(v:GetIndex())
    end
end


--##########  FUNCTION SWITCH LEGIT or RAGE ##########
local function masterswitch_func()
	if rb_masterswitch:GetValue() then
		gui.SetValue("lbot.master", 1)
	else
		gui.SetValue("rbot.master", 1)
	end
end


--########## CALLBACKS ##########
client.AllowListener("round_start")
callbacks.Register( "FireGameEvent", startUnmute )
callbacks.Register("Draw", function()
		unlockinventory_func()
		indicator_func()
		watermark_func()
end)

callbacks.Register("CreateMove", function(cmd)
		unsafe_func()
		antiaim_func(cmd)
		pitch_func(cmd)
		freestand_func()
		forcebaim_func()
		walkslide_func(cmd)
		autowall_func()
		mindmg_func()
		masterswitch_func()
end)
