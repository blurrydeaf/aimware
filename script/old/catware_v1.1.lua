--[[
#########################################################
				 Script lua aimware
			 	  catware.lua v1.1
				      by blurry
		Leave +rep on my profile if enjoy using this script!
		       UID: https://aimware.net/forum/user/61632
#########################################################
]]

--##### REFERENCE #####
local rb_reference		= gui.Reference("ragebot")
	local rb_tab			= gui.Tab(rb_reference, "", "CATWARE.lua")
		local rb_box			= gui.Groupbox(rb_tab, "Welcome Semirager! ", 10, 5, 300, 1)
			local rb_enable			= gui.Checkbox(rb_box, "", "Enable Master", true)
			local rb_unsafe			= gui.Checkbox(rb_box, "catware_unsafe", "Enable Unsafe", false)
				rb_unsafe:SetDescription("*WARNNING* Unsafe mode risk ban")
			--local rb_unmuted		= gui.Checkbox(rb_box, "catware_unmuted", "Auto unmuted", 0)
			
--##### KEYBINDS #####
local rb_keybind		= gui.Groupbox(rb_tab, "Bindkey", 320, 5, 300, 1)
	local rb_kinverter		= gui.Checkbox(rb_keybind, "catware_kinverter", "Side Inverter", false)
	local rb_kfreestand		= gui.Checkbox(rb_keybind, "catware_kfreestand", "Freestand", false)
	local rb_kforcebaim		= gui.Checkbox(rb_keybind, "catware_kforcebaim", "Force Bodyaim", 0)
	local rb_kpitchdown		= gui.Checkbox(rb_keybind, "catware_kpitchdown", "Pitch down", false)

--##### SIDE ANTIAIM #####
local rb_antiaim		= gui.Groupbox(rb_tab, "AntiAim", 10, 160, 300, 1)
	local rb_sdesync		= gui.Slider(rb_antiaim, "catware_sdesync", "Desync", 0, 0, 58, 1)
	local rb_syaw			= gui.Slider(rb_antiaim, "catware_syaw", "Yaw", 0, 0, 30, 1)
	local rb_sroll			= gui.Slider(rb_antiaim, "catware_sroll", "Roll", 0, 0, 45, 1)
	local rb_sfreestand		= gui.Slider(rb_antiaim, "catware_sfreestand", "Freestand", 0, 0, 80, 1)
	local rb_spitchdown		= gui.Slider(rb_antiaim, "catware_spitch", "Pitch", 0, 0, 88, 1)

--##### VARIABLES VOID #####

--########## UNLOCK INVENTORY THE SERVERS VALVE ##########
function unlockinventory_func()
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
		gui.SetValue("rbot.antiaim.base", "0 Desync")
	else
		gui.SetValue("misc.antiuntrusted", 0)
		
	end
end

--##########  FUNCTION FOR ANTIAIM ##########
local function antiaim_func(cmd)
	if not rb_enable:GetValue() then return end
	if not rb_kinverter:GetValue() then 
		gui.SetValue("rbot.antiaim.base", "0 Desync")
		gui.SetValue("rbot.antiaim.base.rotation", rb_sdesync:GetValue())
		gui.SetValue("rbot.antiaim.base", rb_syaw:GetValue()*-1)
		cmd.viewangles = EulerAngles(cmd.viewangles.x, cmd.viewangles.y, rb_sroll:GetValue())
	else
		gui.SetValue("rbot.antiaim.base.rotation", rb_sdesync:GetValue()*-1)
		gui.SetValue("rbot.antiaim.base", rb_syaw:GetValue())
		cmd.viewangles = EulerAngles(cmd.viewangles.x, cmd.viewangles.y, rb_sroll:GetValue()*-1)
	end
	cmd.viewangles = EulerAngles(cmd.viewangles.x, cmd.viewangles.y, cmd.viewangles.z)
end

--##########  FUNCTION FOR ANTIAIM ##########
local function pitch_func(cmd)
	local local_player = entities.GetLocalPlayer()
	if local_player == nil or not local_player:IsAlive() then return end
	local weapon_id = local_player:GetWeaponID()
	if weapon_id > 42 and weapon_id < 49 then return end
	if not rb_enable:GetValue() then return end
	if not rb_unsafe:GetValue() then return end
	if rb_kpitchdown:GetValue() and bit.band(cmd.buttons, bit.lshift(1, 0)) ~= 1 then
		cmd.viewangles = EulerAngles(rb_spitchdown:GetValue(), cmd.viewangles.y, cmd.viewangles.z)
		gui.SetValue("rbot.antiaim.condition.autodir.targets", 1)
		gui.SetValue("rbot.aim.aimadj.silentaim", 0)
		gui.SetValue("rbot.antiaim.base", 180)
	else
		cmd.viewangles = EulerAngles(cmd.viewangles.x, cmd.viewangles.y, cmd.viewangles.z)
	end
end

--##########  FUNCTION FOR FREESTAND ON PEEK ##########
local function freestand_func()
	if not rb_enable:GetValue() then return end
	if not rb_unsafe:GetValue() then return end
	if rb_kfreestand:GetValue() then
		gui.SetValue("rbot.antiaim.condition.autodir.edges", true)
		gui.SetValue("rbot.antiaim.right", "0 Desync")
		gui.SetValue("rbot.antiaim.right", rb_sfreestand:GetValue()*-1)
		gui.SetValue("rbot.antiaim.right.rotation", rb_sdesync:GetValue())
		gui.SetValue("rbot.antiaim.left", "0 Desync")
		gui.SetValue("rbot.antiaim.left", rb_sfreestand:GetValue())
		gui.SetValue("rbot.antiaim.left.rotation", rb_sdesync:GetValue()*-1)
		gui.SetValue("rbot.antiaim.advanced.pitch", 2)
	else
		gui.SetValue("rbot.antiaim.condition.autodir.edges", false)
		gui.SetValue("rbot.antiaim.advanced.pitch", 0)
	end
end

--##########  FUNCTION FORCE BODYAIM ##########
local function forcebaim_func()
	local weapons = {"shared","zeus","pistol","hpistol","smg","rifle","shotgun","scout","asniper","sniper","lmg"}
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

--##########  FUNCTION OVERRIDE MIN DAMAGE ##########

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
	if( event:GetName() and event:GetName() ~= "round_start" ) then return end;
	local players = entities.FindByClass("CCSPlayer");
	for k,v in pairs(players) do
		unmuter(v:GetIndex())
    end
end


--########## CALLBACKS ##########
client.AllowListener("round_start")
callbacks.Register( "FireGameEvent", startUnmute )
callbacks.Register("Draw", function()
		unlockinventory_func()
end)

callbacks.Register("CreateMove", function(cmd)
		unsafe_func()
		antiaim_func(cmd)
		pitch_func(cmd)
		freestand_func()
		forcebaim_func()
		--mindamage_func()
end)
