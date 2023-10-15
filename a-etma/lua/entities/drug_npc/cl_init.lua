include("shared.lua")
function ENT:Initialize()
surface.CreateFont( "textDefaultFont3", {
	font = "Roboto-Regular", -- Use the font-name which is shown to you by your operating system Font Viewer, not the file name
	extended = false,
	size = 60,
	weight = 50,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
} )
end
function ENT:Draw()
	self:DrawModel()
end
net.Receive("notiNPC",function(len, ply) 
	local notiString = net.ReadString()
	local notiSound = net.ReadString()
	local notiType = net.ReadInt(3)
	notification.AddLegacy( notiString, notiType, 5 )
	surface.PlaySound( notiSound )
	end )
hook.Add("PostDrawOpaqueRenderables", "drug_npc", function()
	for k, v in pairs (ents.FindByClass("drug_npc")) do
		if (v:GetPos():Distance(LocalPlayer():GetPos()) < HR_CrystalMeth.DrawDistance) then
			local ang = v:GetAngles();

			ang:RotateAroundAxis(ang:Forward(), 90);
			ang:RotateAroundAxis(ang:Right(), -90);
		
			cam.Start3D2D(v:GetPos()+v:GetUp()*78, Angle(0, LocalPlayer():EyeAngles().y-90, 90), 0.075);
				draw.SimpleTextOutlined("Bread Buyer", "HR_CR_BuyerFont", 0, 0, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_LEFT, 1, Color(25, 25, 25, 100));	
			cam.End3D2D()
		end
	end
end)