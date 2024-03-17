--[[

	 $$$$$$\  $$\      $$\ $$$$$$$\  $$$$$$\ $$$$$$$$\ $$\   $$\  $$$$$$\  $$$$$$$$\ 
	$$  __$$\ $$$\    $$$ |$$  __$$\ \_$$  _|$$  _____|$$$\  $$ |$$  __$$\ $$  _____|
	$$ /  $$ |$$$$\  $$$$ |$$ |  $$ |  $$ |  $$ |      $$$$\ $$ |$$ /  \__|$$ |      
	$$$$$$$$ |$$\$$\$$ $$ |$$$$$$$\ |  $$ |  $$$$$\    $$ $$\$$ |$$ |      $$$$$\    
	$$  __$$ |$$ \$$$  $$ |$$  __$$\   $$ |  $$  __|   $$ \$$$$ |$$ |      $$  __|   
	$$ |  $$ |$$ |\$  /$$ |$$ |  $$ |  $$ |  $$ |      $$ |\$$$ |$$ |  $$\ $$ |      
	$$ |  $$ |$$ | \_/ $$ |$$$$$$$  |$$$$$$\ $$$$$$$$\ $$ | \$$ |\$$$$$$  |$$$$$$$$\ 
	\__|  \__|\__|     \__|\_______/ \______|\________|\__|  \__| \______/ \________|
                                                                                 
	Lighting Management Plugin by CDX (@cdx_ on Discord)
	- Uses Repr by Ozzypig (https://devforum.roblox.com/t/repr-function-for-printing-tables/276575)

]]

-----------------------------------------------------------------------

local ChangeHistoryService = game:GetService("ChangeHistoryService")
local Selection = game:GetService("Selection")

local Ambience = plugin:CreateToolbar("Ambience")
local GeneratePresetButton = Ambience:CreateButton("Generate Preset", "Generate a preset using current lighting", "rbxassetid://16261872997")
local LoadPresetButton = Ambience:CreateButton("Load Preset", "Load a preset", "rbxassetid://16261872997")
local ManagePresetButton = Ambience:CreateButton("Manage Preset", "Manage your current preset and lighting", "rbxassetid://16261872997")

-----------------------------------------------------------------------

local ServerStorage = game:GetService("ServerStorage")
local Lighting = game:GetService("Lighting")
local Restrictions = require(script.Restrictions)
local Repr = require(script.Repr)

-----------------------------------------------------------------------

local function getOrCreateAmbienceFolder(): Folder
	local ambience = ServerStorage:FindFirstChild("Ambience")
	if not ambience then
		ambience = Instance.new("Folder")
		ambience.Name = "Ambience"
		ambience.Parent = ServerStorage
	end
	return ambience
end

local function generateElement(element: Instance, propertyRestrictions: { string: string }): { string: any }
	local preset = {}
	for property, propertyType in propertyRestrictions do
		if element[property] then
			if typeof(element[property]) == propertyType then
				preset[property] = element[property]
			end
		end
	end
	return preset
end

local function generatePreset(): { string: { string: any } }
	local preset = {}
	preset[Lighting.ClassName] = generateElement(Lighting, Restrictions.Lighting)
	for _, child in Lighting:GetChildren() do
		preset[child.ClassName] = generateElement(child, Restrictions[child.ClassName])
	end
	return preset
end

local function loadElement(name: string, element: { any: any }, propertyRestrictions: { string: string })
	local target = Lighting
	if name ~= "Lighting" then
		target = Instance.new(name)
		target.Parent = Lighting
	end
	for property, value in element do
		if propertyRestrictions[property] then
			if typeof(value) == propertyRestrictions[property] then
				target[property] = value
			end
		end
	end
end

local function loadPreset(preset: { string: { string: any } })
	for name, element in preset do
		loadElement(name, element, Restrictions[name])
	end
end

-----------------------------------------------------------------------

GeneratePresetButton.Click:Connect(function()
	local presetSource = Repr(generatePreset())
	local preset = Instance.new("ModuleScript")
	preset.Name = "Generated Preset"
	preset.Source = "return " .. presetSource
	preset.Parent = getOrCreateAmbienceFolder()
end)

LoadPresetButton.Click:Connect(function()
	local selected = Selection:Get()
	if #selected <= 0 then
		print("No preset is selected!")
		return
	end
	local first = selected[1]
	if not first:IsA("ModuleScript") then
		print("Selected preset is not valid!")
		return
	end
	loadPreset(require(first))
end)

ManagePresetButton.Click:Connect(function()
  -- Coming soon
end)
