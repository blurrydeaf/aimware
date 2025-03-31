gui.Command("clear")
--[[
#########################################################
			Script LUA Aimware v5.1.x CS:2
💗 Leave a +rep on my profile if you enjoy using this script! 💗
		UID: https://aimware.net/forum/user/61632
#########################################################
--]]

--##### AUTO UPDATER ##### credit: m0nsterJ
--local local_version = "1.31" --dev ver 
local local_version = "1.31"
local name_script = "CATGIRL.lua"
---@diagnostic disable-next-line: undefined-global
local local_script_name = GetScriptName()
local github_version_url = "https://raw.githubusercontent.com/blurrydeaf/aimware/main/scripts/version_catgirl.txt"
local github_version = http.Get(github_version_url)
local github_source_url = "https://raw.githubusercontent.com/blurrydeaf/aimware/main/scripts/CATGIRL.lua"


if "nil" == tostring(github_version) then 

	print("Enable lua permission 'Allow internet connections...'")
	
--elseif local_version <= tostring(github_version) then --dev mode
elseif local_version ~= tostring(github_version) then

	print("your version outdated")
	print("Now updating " ..local_script_name)
	
    file.Delete(local_script_name)
    print("Successfully deleted old version of " ..local_script_name)
	
    file.Write(local_script_name, http.Get(github_source_url))
    local_version = github_version
    print("Successfully updated " ..local_script_name)
---@diagnostic disable-next-line: undefined-global
    UnloadScript(local_script_name)

else
	print(""..name_script.." current: v" ..local_version.. ", lastest: v" .. tostring(github_version) .. "")
end
--#########################

--########## FILES LOCALED ########## credit: cl0ne thank you helped
local file_found = 0
local theme_files = 
	{"theme/bgmenu.png",
	"theme/bgneko.png",
	"theme/bgrias.png",	
	"theme/sideright.png", 	
	"theme/sideright1.png", 
	"theme/sideleft.png", 	
	"theme/top.png", 		
	"theme/center.png", 	
	"theme/center1.png", 	
	"theme/bottom.png", 	
	"theme/aimwarelogo.png",
	"theme/clawlogo.png", 	
	"theme/catgirllogo.png",
	"theme/invisible.png"}

--print("now checking files if existed")
file.Enumerate(function(files)

	for k,v in pairs(theme_files) do
		
		if v == files then
			file_found = file_found + 1
			--print("file " .. v .. " found")
		end
		
	end
	
end)

if file_found == 14 then	
	--print("all files " .. file_found .. " counted.")
	
else
	print("file missing, downloading")
	file.Write("theme/bgmenu.png", http.Get("https://github.com/blurrydeaf/aimware/blob/main/imagens/bgmenu.png?raw=true")) 			--1
	file.Write("theme/bgneko.png", http.Get("https://github.com/blurrydeaf/aimware/blob/main/imagens/bgneko.png?raw=true"))
	file.Write("theme/bgrias.png", http.Get("https://github.com/blurrydeaf/aimware/blob/main/imagens/bgrias.png?raw=true"))
	
	file.Write("theme/sideright.png", http.Get("https://github.com/blurrydeaf/catware.aimware/blob/main/imagens/sideright.png?raw=true"))	--2
	file.Write("theme/sideright1.png", http.Get("https://github.com/blurrydeaf/catware.aimware/blob/main/imagens/sideright1.png?raw=true"))	--3
	file.Write("theme/sideleft.png", http.Get("https://raw.githubusercontent.com/blurrydeaf/catware.aimware/main/imagens/sideleft.png"))	--4
	file.Write("theme/top.png", http.Get("https://github.com/blurrydeaf/catware.aimware/blob/main/imagens/top.png?raw=true"))				--5
	file.Write("theme/center.png", http.Get("https://github.com/blurrydeaf/catware.aimware/blob/main/imagens/center.png?raw=true"))			--6
	file.Write("theme/center1.png", http.Get("https://github.com/blurrydeaf/catware.aimware/blob/main/imagens/center1.png?raw=true"))		--7
	
	file.Write("theme/bottom.png", http.Get("https://raw.githubusercontent.com/blurrydeaf/catware.aimware/main/imagens/bottom.png"))		--8
	file.Write("theme/aimwarelogo.png", http.Get("https://github.com/blurrydeaf/aimware/blob/main/imagens/aimwarelogo.png?raw=true"))				--9
	file.Write("theme/clawlogo.png", http.Get("https://github.com/blurrydeaf/aimware/blob/main/imagens/clawlogo.png?raw=true"))				--10
	file.Write("theme/catgirllogo.png", http.Get("https://github.com/blurrydeaf/aimware/blob/main/imagens/catgirllogo.png?raw=true"))				--11
	file.Write("theme/invisible.png", http.Get("https://github.com/blurrydeaf/aimware/blob/main/imagens/invisible.png?raw=true"))			--12
end
--#########################

--########## VARIBLE ##########
local bgmenu = draw.CreateTexture(common.DecodePNG(file.Read("theme/bgmenu.png")))			--1
local bgneko = draw.CreateTexture(common.DecodePNG(file.Read("theme/bgneko.png")))			--1
local bgrias = draw.CreateTexture(common.DecodePNG(file.Read("theme/bgrias.png")))			--1

local sideright = draw.CreateTexture(common.DecodePNG(file.Read("theme/sideright.png")))	--2
local sideright1 = draw.CreateTexture(common.DecodePNG(file.Read("theme/sideright1.png")))	--3
local sideleft = draw.CreateTexture(common.DecodePNG(file.Read("theme/sideleft.png")))		--4
local top = draw.CreateTexture(common.DecodePNG(file.Read("theme/top.png")))				--5
local center = draw.CreateTexture(common.DecodePNG(file.Read("theme/center.png")))			--6
local center1 = draw.CreateTexture(common.DecodePNG(file.Read("theme/center1.png")))		--7
local bottom = draw.CreateTexture(common.DecodePNG(file.Read("theme/bottom.png")))			--8

local aimwarelogo = draw.CreateTexture(common.DecodePNG(file.Read("theme/aimwarelogo.png")))		--9
local clawlogo = draw.CreateTexture(common.DecodePNG(file.Read("theme/clawlogo.png")))			--10
local catgirllogo = draw.CreateTexture(common.DecodePNG(file.Read("theme/catgirllogo.png")))		--11
local invisible = draw.CreateTexture(common.DecodePNG(file.Read("theme/invisible.png")))	--12

local dpi = 1
local dpi_scale = {0.75, 1, 1.25, 1.5, 1.75, 2, 2.25, 2.5, 2.75, 3}

callbacks.Register("Draw", function()
	dpi = dpi_scale[gui.GetValue("adv.dpi") + 1];
end)

local screenX, screenY = draw.GetScreenSize();
local menu = gui.Reference("MENU")
local abgmenu = 255
local acenter = 255
local acenter1 = 255
local atheme = 0
local r,g,b = 20, 20, 20

--[[
--############	test	#############
local Font = draw.CreateFont("Bahnschrift", 35, 100)
local x = 128
local y = 128
local function ExampleDrawingHook()
	local common_time = common.Time();
	local globals_CurTime = globals.CurTime();
	local fps = 1 / globals.AbsoluteFrameTime();
	draw.SetFont(Font);
    draw.Color(210, 170, 160, 255);
    draw.TextShadow(x, y, "common_time: " ..tostring(common_time).. "");
	print("common_time: " ..common_time.. "")
    draw.TextShadow(x, y+25, "globals_CurTime: " ..tostring(globals_CurTime).. "");
	print("globals_CurTime: " ..globals_CurTime.. "")
	draw.TextShadow(x, y+50, "players_fps : " ..tostring(fps).. "");
	print("players_fps : " ..players_fps.. "")
end
callbacks.Register("Draw", "ExampleDrawingHook", ExampleDrawingHook);
--]]
--#########################


--########## REFERENCE ##########
local cgirl_reference		= gui.Reference("SETTINGS", "THEME"); 

	local cgirl_box				= gui.Groupbox(cgirl_reference, "Custom" , 330, 410, 295, 20);
		local cgirl_enable			= gui.Checkbox(cgirl_box, "cgirl_enable", "Enable Animated", true);
		--local cgirl_items = {"claw", "invisible", "soon"};
		local cgirl_tlogo			= gui.Combobox(cgirl_box, "cgirl_tlogo", 		"Type logo",	"Aimware", "Claw", "Catgirl", "Invisible");
		local cgirl_background		= gui.Combobox(cgirl_box, "cgirl_background",	"Background",	"Disabled", "Darkmode", "Bedroom", "Neko", "Rias");
		local cgirl_darkmode_rgb	= gui.ColorPicker(cgirl_box, "cgirl_darkmode_rgb", "Color Dark mode", 193, 154, 164, 255);  -- 193, 154, 164 RGB cyberpink

	local cgirl_box1				= gui.Groupbox(cgirl_reference, "Toggle" , 15, 510, 295, 20);
		local cgirl_center			= gui.Checkbox(cgirl_box1, "cgirl_center",		"Thousand Lover", false);
		local cgirl_speed_center	= gui.Combobox(cgirl_box1, "cgirl_speed_center", "Speed", 		"Slow", "Faster", "Fastest");
		local cgirl_tophold			= gui.Combobox(cgirl_box1, "cgirl_tophold",		"Top hold",		"Disable", "Always", "Rare");
		local cgirl_bottomhold		= gui.Combobox(cgirl_box1, "cgirl_bottomhold",	"Bottom hold",	"Disable", "Always", "Rare");
		local cgirl_righthold		= gui.Combobox(cgirl_box1, "cgirl_righthold",	"Tail hold",	"Disable", "Up", "Down", "Random");
		local cgirl_lefthold		= gui.Combobox(cgirl_box1, "cgirl_lefthold",	"Cat hold",		"Disable", "Always", "Rare");




--#########################


--########## TOP ##########
callbacks.Register("Draw", function()

local menuX, menuY = menu:GetValue()

	if not menu:IsActive()  then	
	
		randomtop = math.random (1,3)
		
	end

	if menu:IsActive() then
	
		if cgirl_tophold:GetValue() == 1 then --always
		
			draw.SetTexture(top);
			draw.FilledRect(menuX+250*dpi, menuY-200*dpi, menuX+800*dpi, menuY+100*dpi);
		
		--elseif cgirl_tophold:GetValue() == 1 then --hide
		elseif cgirl_tophold:GetValue() == 2 and randomtop == 1 then --rare
		
			draw.SetTexture(top);
			draw.FilledRect(menuX+250*dpi, menuY-200*dpi, menuX+800*dpi, menuY+100*dpi);
		
		end
	end
	
end)
--#########################


--##### BOTTOM #####
callbacks.Register("Draw", function()

local menuX, menuY = menu:GetValue()

	if menu:IsActive()  then
	
		randombottom = math.random (1,3)

	end	
	
	if not  menu:IsActive()  then
		if cgirl_bottomhold:GetValue() == 1 then --always	
	
			draw.SetTexture(bottom);
			draw.FilledRect( screenX-(screenX*0.18) , screenY-(screenX*0.17) , screenX , screenY );
		
		elseif cgirl_bottomhold:GetValue() == 2 and randombottom == 1 then --rare
	
			draw.SetTexture(bottom);
			draw.FilledRect( screenX-(screenX*0.18) , screenY-(screenX*0.17) , screenX , screenY );
		
		end
	end
	
end)
--#########################


--##### SIDE LEFT #####
callbacks.Register("Draw", function()

local menuX, menuY = menu:GetValue()

	if not menu:IsActive()  then
		randomleft = math.random (1,3)
	end

	if menu:IsActive() then

		if cgirl_lefthold:GetValue() == 1 then --always
		
			draw.SetTexture(sideleft);
			draw.FilledRect(menuX, menuY-100*dpi, menuX+200*dpi, menuY+50*dpi );
			
		elseif cgirl_lefthold:GetValue() == 2 and randomleft == 1 then --random
		
			draw.SetTexture(sideleft);
			draw.FilledRect(menuX, menuY-100*dpi, menuX+200*dpi, menuY+50*dpi );
		
		end
	end
end)
--#########################


--##### SIDE RIGHT #####
callbacks.Register("Draw", function()

local menuX, menuY = menu:GetValue()

	if not menu:IsActive()  then
		randomright = math.random (1,3)
	end
	
	if menu:IsActive() then
	
		if cgirl_righthold:GetValue() == 1 then --up
		
			draw.SetTexture(sideright);
			draw.FilledRect(menuX+710*dpi, menuY+100*dpi, menuX+990*dpi , menuY+600*dpi );
				
		elseif cgirl_righthold:GetValue() == 2 then --down
		
			draw.SetTexture(sideright1);
			draw.FilledRect(menuX+760*dpi, menuY+400*dpi, menuX+1040*dpi , menuY+900*dpi );
				
		elseif cgirl_righthold:GetValue() == 3 then --rare
		
			if randomright == 1 then
		
				draw.SetTexture(sideright);
				draw.FilledRect(menuX+710*dpi, menuY+100*dpi, menuX+990*dpi , menuY+600*dpi );
			
			elseif randomright == 2 then
		
				draw.SetTexture(sideright1);
				draw.FilledRect(menuX+760*dpi, menuY+400*dpi, menuX+1040*dpi , menuY+900*dpi );
			
			end
		end

	else
		randomright = math.random (1,3)
	end

end)
--#########################

--########## CENTER ##########
callbacks.Register("Draw", function()
	
	if cgirl_center:GetValue() then

		if cgirl_speed_center:GetValue() == 0 then
			speed_center = 0.25
			speed_center1 = 0.5
		elseif cgirl_speed_center:GetValue() == 1 then
			speed_center = 0.5
			speed_center1 = 1
		else
			speed_center = 1
			speed_center1 = 3
		end
	
		if menu:IsActive() then
			--print("acenter 0: speed " .. acenter1 .. " ")
			if acenter >= 255 then
				acy = 0.0
			elseif acenter <= 0 then
				acy = 255.0
			end
			if acy ~= acenter then
				if acy > acenter then
					acenter = acenter + speed_center
				else
					acenter = acenter - speed_center
				end
			end
		local menuX, menuY = menu:GetValue()
		draw.Color(255, 255, 255, acenter);
		draw.SetTexture(center);
		draw.FilledRect(menuX-600*dpi, menuY-300*dpi, menuX+1300*dpi , menuY+790*dpi);
		end
	
		if menu:IsActive() then
			if acy < 1 then
				acy1 = 255.0
			elseif acy >= 255 then
				acy1 = 0.0
			end
			if acy1 ~= acenter1 then
				if acy1 > acenter1 then
					acenter1 = acenter1 + speed_center1
				else
					acenter1 = acenter1 - speed_center1
				end
			end
			if acenter1 >= 256 then --fix bug?
				acenter1 = 255
			elseif acenter1 <= 0 then
				acenter1 = 0
			end
			--print("acenter 1: " ..acenter1.. " acy: " ..acy.. " - acy 1: " ..acy1.. "")
			local menuX, menuY = menu:GetValue()
			draw.Color(255, 255, 255, acenter1);
			draw.SetTexture(center1);
			draw.FilledRect(menuX-600*dpi, menuY-300*dpi, menuX+1300*dpi , menuY+790*dpi);
		end
		cgirl_speed_center:SetDisabled(false)
	else
		cgirl_speed_center:SetDisabled(true) --theme.cgirl_speed_center
	end
end)
--#########################


--##### BACKGROUND ##### credit: code basic LooseGod thank you 
--"Disabled", "Darkmode", "Bedroom", "Neko", "Rias")
callbacks.Register("Draw", function()

	local menux,menuy = menu:GetValue()
	
	--if not menu:IsActive() then return end
	
	if menu:IsActive() and cgirl_background:GetValue() == 1 then --theme darkmode --cyberarb -rgb 193 154 164
		
		local rdarkm, gdarkm, bdarkm, adarkm = cgirl_darkmode_rgb:GetValue() 
		local rdark1, gdark1, bdark1, adarkm1 = 21, 21, 21, 255
		local rdark2, gdark2, bdark2, adarkm2 = 25, 25, 25, 255
		local rdark3, gdark3, bdark3, adarkm3 = 31, 31, 31, 255
		
		cgirl_darkmode_rgb:SetDisabled(false)
		--cgirl_darkmode_rgb:SetInvisible(false)
		
		gui.SetValue("theme.footer.bg", rdarkm, gdarkm, bdarkm, adarkm)
		--gui.SetValue("theme.footer.text" 201 201 201 0
		gui.SetValue("theme.header.bg", rdarkm, gdarkm, bdarkm, adarkm)
		gui.SetValue("theme.header.line", rdarkm, gdarkm, bdarkm, adarkm)
		--gui.SetValue("theme.header.text" 201 201 201 255
		gui.SetValue("theme.nav.active", rdarkm, gdarkm, bdarkm, adarkm)
		gui.SetValue("theme.nav.bg", rdarkm, gdarkm, bdarkm, adarkm)
		gui.SetValue("theme.nav.shadow", rdark2, gdark2, bdark2, adarkm2)
		--gui.SetValue("theme.nav.text" 255 255 255 255
		gui.SetValue("theme.tablist.shadow", rdark3, gdark3, bdark3, adarkm3)
		gui.SetValue("theme.tablist.tabactivebg", rdark3, gdark3, bdark3, adarkm3)
		gui.SetValue("theme.tablist.tabdecorator", rdark3, gdark3, bdark3, adarkm3)
		--gui.SetValue("theme.tablist.text" 201 201 201 255
		--gui.SetValue("theme.tablist.text2" 201 201 201 255
		gui.SetValue("theme.ui2.border", rdark1, gdark1, bdark1, adarkm1)
		gui.SetValue("theme.ui2.lowpoly1", rdark1, gdark1, bdark1, adarkm1)
		gui.SetValue("theme.ui2.lowpoly2", rdark1, gdark1, bdark1, adarkm1)
		
		
		

		
	elseif menu:IsActive() and cgirl_background:GetValue() == 2 then --background bedroom
		
        draw.Color(255, 255, 255, abgmenu);
		draw.SetTexture(bgmenu)
		draw.FilledRect(menux,menuy, menux + (800*dpi) , menuy + (600*dpi) );
		
		cgirl_darkmode_rgb:SetDisabled(false)
		--cgirl_darkmode_rgb:SetInvisible(true)
		
		local rdarkm, gdarkm, bdarkm, adarkm = cgirl_darkmode_rgb:GetValue() 
		
		gui.SetValue("theme.footer.bg", rdarkm, gdarkm, bdarkm, adarkm)
		--gui.SetValue("theme.footer.text" 201 201 201 0
		gui.SetValue("theme.header.bg", rdarkm, gdarkm, bdarkm, adarkm)
		gui.SetValue("theme.header.line", rdarkm, gdarkm, bdarkm, adarkm)
		--gui.SetValue("theme.header.text" 201 201 201 255
		gui.SetValue("theme.nav.active", rdarkm, gdarkm, bdarkm, adarkm)
		gui.SetValue("theme.nav.bg", rdarkm, gdarkm, bdarkm, adarkm)
		
		gui.SetValue("theme.ui2.lowpoly1", r,g,b, atheme)
		gui.SetValue("theme.ui2.lowpoly2", r,g,b, atheme)
		gui.SetValue("theme.tablist.tabactivebg", r,g,b, atheme)
		--gui.SetValue("theme.footer.bg", r,g,b, atheme)
		--gui.SetValue("theme.nav.bg", r,g,b, atheme)
		--gui.SetValue("theme.nav.active", r,g,b, atheme)
		--gui.SetValue("theme.header.bg", r,g,b, atheme)
		--gui.SetValue("theme.header.line", r,g,b, atheme)
		
	elseif menu:IsActive() and cgirl_background:GetValue() == 3 then --background Neko
		
		local rdarkm, gdarkm, bdarkm, adarkm = cgirl_darkmode_rgb:GetValue() 
		
		draw.Color(255, 255, 255, abgmenu);
		draw.SetTexture(bgneko)
		draw.FilledRect(menux,menuy, menux + (800*dpi) , menuy + (600*dpi) );
		
		cgirl_darkmode_rgb:SetDisabled(false)
		--cgirl_darkmode_rgb:SetInvisible(true)
		
		
				gui.SetValue("theme.footer.bg", rdarkm, gdarkm, bdarkm, adarkm)
		--gui.SetValue("theme.footer.text" 201 201 201 0
		gui.SetValue("theme.header.bg", rdarkm, gdarkm, bdarkm, adarkm)
		gui.SetValue("theme.header.line", rdarkm, gdarkm, bdarkm, adarkm)
		--gui.SetValue("theme.header.text" 201 201 201 255
		gui.SetValue("theme.nav.active", rdarkm, gdarkm, bdarkm, adarkm)
		gui.SetValue("theme.nav.bg", rdarkm, gdarkm, bdarkm, adarkm)
		
		gui.SetValue("theme.ui2.lowpoly1", r,g,b, atheme)
		gui.SetValue("theme.ui2.lowpoly2", r,g,b, atheme)
		gui.SetValue("theme.tablist.tabactivebg", r,g,b, atheme)
		--gui.SetValue("theme.footer.bg", r,g,b, atheme)
		--gui.SetValue("theme.nav.bg", r,g,b, atheme)
		--gui.SetValue("theme.nav.active", r,g,b, atheme)
		--gui.SetValue("theme.header.bg", r,g,b, atheme)
		--gui.SetValue("theme.header.line", r,g,b, atheme)
		
		
	elseif menu:IsActive() and cgirl_background:GetValue() == 4 then --background rias
		
		local rdarkm, gdarkm, bdarkm, adarkm = cgirl_darkmode_rgb:GetValue() 
		
		draw.Color(255, 255, 255, abgmenu);
		draw.SetTexture(bgrias)
		draw.FilledRect(menux,menuy, menux + (800*dpi) , menuy + (600*dpi) );
		
		cgirl_darkmode_rgb:SetDisabled(false)
		--cgirl_darkmode_rgb:SetInvisible(true)
		
		
				gui.SetValue("theme.footer.bg", rdarkm, gdarkm, bdarkm, adarkm)
		--gui.SetValue("theme.footer.text" 201 201 201 0
		gui.SetValue("theme.header.bg", rdarkm, gdarkm, bdarkm, adarkm)
		gui.SetValue("theme.header.line", rdarkm, gdarkm, bdarkm, adarkm)
		--gui.SetValue("theme.header.text" 201 201 201 255
		gui.SetValue("theme.nav.active", rdarkm, gdarkm, bdarkm, adarkm)
		gui.SetValue("theme.nav.bg", rdarkm, gdarkm, bdarkm, adarkm)
		
		gui.SetValue("theme.ui2.lowpoly1", r,g,b, atheme)
		gui.SetValue("theme.ui2.lowpoly2", r,g,b, atheme)
		gui.SetValue("theme.tablist.tabactivebg", r,g,b, atheme)
		--gui.SetValue("theme.footer.bg", r,g,b, atheme)
		--gui.SetValue("theme.nav.bg", r,g,b, atheme)
		--gui.SetValue("theme.nav.active", r,g,b, atheme)
		--gui.SetValue("theme.header.bg", r,g,b, atheme)
		--gui.SetValue("theme.header.line", r,g,b, atheme)
		
	else
		

		cgirl_darkmode_rgb:SetDisabled(true)
		--cgirl_darkmode_rgb:SetInvisible(true)
		
	end

		if menu:IsActive() then
		
			aty = 0
		else 
			aty = 255
			
		end
	
		if aty ~= atheme then
	
			if aty > atheme then 
				atheme = atheme + 255
			else
				atheme = atheme - 1
			end
			
		end
	
		if menu:IsActive() then
			ay = 255
		else 
			ay = 0
		end
	
		if ay ~= abgmenu then
	
			if ay < abgmenu then 
				abgmenu = abgmenu - 255
			else
				abgmenu = abgmenu + 3
			end

		end
	
end)
--#########################


--##### CAT LOGO ##### "Aimware", "Claw", "Catgirl", "Invisible");
--SetIcon(texture, integer:scale) Sets the window icon.
callbacks.Register("Draw", function() 

	if cgirl_tlogo:GetValue() == 0 then 
	
		menu:SetIcon(aimwarelogo, 0.95) 
		
	elseif cgirl_tlogo:GetValue() == 1 then
	
		menu:SetIcon(clawlogo, 0.95) 
		
	elseif cgirl_tlogo:GetValue() == 2 then
	
		menu:SetIcon(catgirllogo, 0.95)
		
	else
	
		menu:SetIcon(invisible, 1)
		
	end
	
end)
--#########################
