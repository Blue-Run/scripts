include("shared.lua")

function ENT:Draw( )
	self:DrawModel()


end
/*
hook.Add("PostDrawOpaqueRenderables", "oilrig", function()
	for k, v in pairs (ents.FindByClass("oilrig")) do
		if (v:GetPos():Distance(LocalPlayer():GetPos()) < HR_CrystalMeth.DrawDistance) then
			local ang = v:GetAngles();

			ang:RotateAroundAxis(ang:Forward(), 90);
			ang:RotateAroundAxis(ang:Right(), -90);
		
			cam.Start3D2D(v:GetPos()+v:GetUp()*78, Angle(0, LocalPlayer():EyeAngles().y-90, 90), 100);
				draw.SimpleTextOutlined("Oil Rig", "HR_CR_BuyerFont", 0, 0, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_LEFT, 1, Color(25, 25, 25, 100));	
			cam.End3D2D()
		end
	end
end)