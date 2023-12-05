--[[
#########################################################
			Script LUA Aimware v5.1.x CS:2
💗 Leave a +rep on my profile if you enjoy using this script! 💗
		UID: https://aimware.net/forum/user/61632
#########################################################
--]]
gui.Command("clear")



--##### AUTO UPDATER ##### credit: m0nsterJ
local local_version = "1.3"
---@diagnostic disable-next-line: undefined-global
local local_script_name = GetScriptName()
local github_version_url = "https://raw.githubusercontent.com/blurrydeaf/aimware/main/scripts/version_catgirl.txt"
local github_version = http.Get(github_version_url)
local github_source_url = "https://raw.githubusercontent.com/blurrydeaf/aimware/main/scripts/CATGIRL.lua"

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







--########## files saved in local data ##########
local file_found = 0
local theme_files = {"theme/bgmenu.png", "theme/sideright.png", "theme/sideright1.png", "theme/sideleft.png", "theme/top.png", "theme/center.png", "theme/center1.png", "theme/bottom.png"}

print("now checking files if existed")
file.Enumerate(function(files)

	for k,v in pairs(theme_files) do
		
		if v == files then
			file_found = file_found + 1
			print("file " .. v .. " found")
		end
		
	end
end)


if file_found == 8 then	
	print("all files found")
	
else
	print("file missing, downloading")
	file.Write("theme/bgmenu.png", http.Get("https://raw.githubusercontent.com/blurrydeaf/catware.aimware/main/imagens/menu.png"))
	file.Write("theme/bgmenu.png", http.Get("https://raw.githubusercontent.com/blurrydeaf/catware.aimware/main/imagens/menu.png"))
	file.Write("theme/sideright.png", http.Get("https://github.com/blurrydeaf/catware.aimware/blob/main/imagens/sideright.png?raw=true"))
	file.Write("theme/sideright1.png", http.Get("https://github.com/blurrydeaf/catware.aimware/blob/main/imagens/sideright1.png?raw=true"))
	file.Write("theme/sideleft.png", http.Get("https://raw.githubusercontent.com/blurrydeaf/catware.aimware/main/imagens/sideleft.png"))
	file.Write("theme/top.png", http.Get("https://github.com/blurrydeaf/catware.aimware/blob/main/imagens/top.png?raw=true"))
	file.Write("theme/center.png", http.Get("https://github.com/blurrydeaf/catware.aimware/blob/main/imagens/center.png?raw=true"))
	file.Write("theme/center1.png", http.Get("https://github.com/blurrydeaf/catware.aimware/blob/main/imagens/center1.png?raw=true"))
	file.Write("theme/bottom.png", http.Get("https://raw.githubusercontent.com/blurrydeaf/catware.aimware/main/imagens/bottom.png"))
end
--#########################


local bgmenu = draw.CreateTexture(common.DecodePNG(file.Read("theme/bgmenu.png")))
local sideright = draw.CreateTexture(common.DecodePNG(file.Read("theme/sideright.png")))
local sideright1 = draw.CreateTexture(common.DecodePNG(file.Read("theme/sideright1.png")))
local sideleft = draw.CreateTexture(common.DecodePNG(file.Read("theme/sideleft.png")))
local top = draw.CreateTexture(common.DecodePNG(file.Read("theme/top.png")))
local center = draw.CreateTexture(common.DecodePNG(file.Read("theme/center.png")))
local center1 = draw.CreateTexture(common.DecodePNG(file.Read("theme/center1.png")))
local bottom = draw.CreateTexture(common.DecodePNG(file.Read("theme/bottom.png")))


local screenX, screenY = draw.GetScreenSize();
local menu = gui.Reference("MENU")
local abgmenu = 255
local acenter = 255
local acenter1 = 255
local atheme = 0
local r,g,b = 20, 20, 20

--########## TOP ##########
callbacks.Register("Draw", function()

	if menu:IsActive() then
		local menuX, menuY = menu:GetValue()
		draw.SetTexture(top);
		draw.FilledRect(menuX+250, menuY-200, menuX+800, menuY+100);
	end
	
end)
--#########################

--##### BOTTOM #####
callbacks.Register("Draw", function()

	if menu:IsActive()  then
		randombottom = math.random (1,10)
	elseif randombottom == 1 then
		draw.SetTexture(bottom);
		draw.FilledRect(screenX-(screenX*0.18)-200, screenY-(screenX*0.17), screenX-200, screenY);
	end
	
end)
--#########################

--##### SIDE RIGHT #####
callbacks.Register("Draw", function()

	if menu:IsActive() then
	
		if randomright == 1 then
			local menuX, menuY = menu:GetValue()
			draw.SetTexture(sideright);
			draw.FilledRect(menuX+710, menuY+100, menuX+990 , menuY+600 );
		elseif randomright == 2 then
		 	local menuX, menuY = menu:GetValue()
			draw.SetTexture(sideright1);
			draw.FilledRect(menuX+760, menuY+400, menuX+1040 , menuY+900 );
		else 
			local menuX, menuY = menu:GetValue()
			draw.SetTexture(sideleft);
			draw.FilledRect(menuX, menuY-100, menuX+200, menuY+50 );
		end
		
	else
		randomright = math.random (1,3)
	end

end)
--#########################

--########## CENTER ##########
callbacks.Register("Draw", function()

	if menu:IsActive() then
	
		if acenter == 255 then
			acy = 0
		elseif acenter == 0 then
			acy = 255
		end
		
		if acy ~= acenter then
		
			if acy > acenter then
				acenter = acenter + 0.5
			else
				acenter = acenter - 0.5
			end
			
		end
		
		local menuX, menuY = menu:GetValue()
		draw.Color(255, 255, 255, acenter);
		draw.SetTexture(center);
		draw.FilledRect(menuX-600, menuY-300, menuX+1300 , menuY+790);
	end
	
	
	if menu:IsActive() then
	
		if acy == 0 then
			acy1 = 255
		elseif acy == 255 then
			acy1 = 0
		end
		
		if acy1 ~= acenter1 then
		
			if acy1 > acenter1 then
				acenter1 = acenter1 + 1
			else
				acenter1 = acenter1 - 1
			end
		end
		
		local menuX, menuY = menu:GetValue()
		draw.Color(255, 255, 255, acenter1);
		draw.SetTexture(center1);
		draw.FilledRect(menuX-600, menuY-300, menuX+1300 , menuY+790);
		
	end
	
end)
--#########################

--##### MENU ##### coded by LooseGod thank you 
callbacks.Register("Draw", function()

    if menu:IsActive() then
        local menux,menuy = menu:GetValue()
        draw.Color(255, 255, 255, abgmenu);
		gui.SetValue("theme.ui2.lowpoly1", r,g,b, atheme)
		gui.SetValue("theme.ui2.lowpoly2", r,g,b, atheme)
		gui.SetValue("theme.tablist.tabactivebg", r,g,b, atheme)
		gui.SetValue("theme.footer.bg", r,g,b, atheme)
		gui.SetValue("theme.nav.bg", r,g,b, atheme)
		gui.SetValue("theme.nav.active", r,g,b, atheme)
		gui.SetValue("theme.header.bg", r,g,b, atheme)
		gui.SetValue("theme.header.line", r,g,b, atheme)
        draw.SetTexture(bgmenu)
        draw.FilledRect(menux,menuy,menux+800,menuy+600);
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
