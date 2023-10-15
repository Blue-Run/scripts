ENT.type = "anim"
ENT.Base = "base_gmodentity"

ENT.PrintName = "Fermenter"
ENT.Spawnable = true
ENT.Category = "Blue's Wine System"

--AddCSLuaFile("init.lua")
AddCSLuaFile("imgui.lua")
local imgui = include("imgui.lua") -- imgui.lua should be in same folder and AddCSLuaFile'd

ENT.RenderGroup = RENDERGROUP_TRANSLUCENT

function ENT:DrawTranslucent()
  self:DrawModel()

  if imgui.Entity3D2D(self, Vector(-0.5, 7, 20), Angle(0, 180, 45), 0.1) then
    local col = HSVToColor(CurTime() % 6 * 60, 1, 1)
    surface.SetDrawColor(0, 0, 0, 255)
    surface.DrawRect(-5, -5, 320, 100)

    surface.SetDrawColor(col)
    surface.DrawRect(0, 0, 310, 90)

    draw.SimpleText("Fermenter", "bebas60", 0, 0, color_white)

    -- check if sugar is needed

    imgui.End3D2D()
  end
end