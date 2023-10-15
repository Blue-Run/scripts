ENT.type = "anim"
ENT.Base = "base_gmodentity"

ENT.PrintName = "scrap_metal"
ENT.Spawnable = true
ENT.Category = "Blue's Factory System"


--AddCSLuaFile("init.lua")
AddCSLuaFile("imgui.lua")
local imgui = include("imgui.lua") -- imgui.lua should be in same folder and AddCSLuaFile'd


--local imgui = include("imgui.lua")
-- 3D2D UI should be rendered in translucent pass, so this should be either TRANSLUCENT or BOTH
ENT.RenderGroup = RENDERGROUP_TRANSLUCENT

function ENT:DrawTranslucent()
	self:DrawModel()
  -- While you can of course use the imgui.Start3D2D function for entities, IMGUI has some special syntax
  -- This function automatically calls LocalToWorld and LocalToWorldAngles respectively on position and angles 
  if imgui.Entity3D2D(self, Vector(-.5, -3.2,.2), Angle(0, 90, 0), 0.02) then
    -- render things
    --draw.SimpleText( LocalPlayer():GetName(), "bebas60", , 50, color_white)
    local col = HSVToColor( CurTime() % 6 * 60, 1, 1 )
    surface.SetDrawColor(0, 0, 0, 255)
    surface.DrawRect(-5,-5,220,60)
    --surface.SetDrawColor(65, 65, 65, 180)
    surface.SetDrawColor(col)
    surface.DrawRect(0,0,210,50)


    draw.SimpleText( "Scrap Metal", "bebas60", 0, 0, color_white)


    imgui.End3D2D()
  end
end

