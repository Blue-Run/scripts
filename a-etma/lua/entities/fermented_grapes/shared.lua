ENT.type = "anim"
ENT.Base = "base_gmodentity"

ENT.PrintName = "fermented_grapes"
ENT.Spawnable = true
ENT.Category = "Blue's Wine System"


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
  if imgui.Entity3D2D(self, Vector(24.1, -21.2, 5), Angle(0, 90, 90), 0.1) then
    -- render things
    --draw.SimpleText( LocalPlayer():GetName(), "bebas60", , 50, color_white)
    local col = HSVToColor( CurTime() % 6 * 60, 1, 1 )
    surface.SetDrawColor(0, 0, 0, 255)
    surface.DrawRect(-5,-5,430,60)
    --surface.SetDrawColor(65, 65, 65, 180)
    surface.SetDrawColor(col)
    surface.DrawRect(0,0,420,50)


    draw.SimpleText( "Vat Of Fermented Grapes", "bebas60", 0, 0, color_white)


    imgui.End3D2D()
  end
end

