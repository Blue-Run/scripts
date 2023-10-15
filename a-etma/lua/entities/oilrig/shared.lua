ENT.Type = "anim"
ENT.Base = "base_anim"
ENT.PrintName = "Oil Rig"
ENT.Author = "Bluerunner"
ENT.Spawnable = true
ENT.Category = "Blue's Oil System"



function ENT:SetupDataTables()
    self:NetworkVar("Int", 0, "Battery")
    self:NetworkVar("Int", 1, "MaxBattery")
    self:NetworkVar("Int", 2, "BatteryDrainRate")
    self:NetworkVar("Float", 0, "BarrelSpawnRate")
end

--AddCSLuaFile("init.lua")
AddCSLuaFile("imgui.lua")
local imgui = include("imgui.lua") -- imgui.lua should be in same folder and AddCSLuaFile'd

ENT.RenderGroup = RENDERGROUP_TRANSLUCENT


function ENT:DrawTranslucent()
    self:DrawModel()

    if imgui.Entity3D2D(self, Vector(0, 0, 78), Angle(LocalPlayer():EyeAngles().z, LocalPlayer():EyeAngles().y- 180, 80), 0.1) then
        local col = HSVToColor(CurTime() % 6 * 60, 1, 1)
       draw.RoundedBox(8, 0, 0, 230, 50, col)
        draw.SimpleText("Oil Rig", "DermaLarge", 115, 25, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

        imgui.End3D2D()
    end
end

/* 
AddCSLuaFile("imgui.lua")
local imgui = include("imgui.lua") -- imgui.lua should be in same folder and AddCSLuaFile'd


--local imgui = include("imgui.lua")
-- 3D2D UI should be rendered in translucent pass, so this should be either TRANSLUCENT or BOTH
ENT.RenderGroup = RENDERGROUP_TRANSLUCENT
local ang = v:GetAngles();
function ENT:DrawTranslucent()
	self:DrawModel()
  -- While you can of course use the imgui.Start3D2D function for entities, IMGUI has some special syntax
  -- This function automatically calls LocalToWorld and LocalToWorldAngles respectively on position and angles 
  if imgui.Entity3D2D(self, Vector(24.1, -10, 5), Angle(0, 90, 90), 0.1) then
    -- render things
    --draw.SimpleText( LocalPlayer():GetName(), "bebas60", , 50, color_white)
    local col = HSVToColor( CurTime() % 6 * 60, 1, 1 )
    surface.SetDrawColor(0, 0, 0, 255)
    surface.DrawRect(-5,-5,120,60)
    --surface.SetDrawColor(65, 65, 65, 180)
    surface.SetDrawColor(col)
    surface.DrawRect(0,0,230,50)


    draw.SimpleText( "Vat Of Grapes", "bebas60", 0, 0, color_white)


    imgui.End3D2D()
  end
end



