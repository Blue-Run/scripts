--took this text from another script liked the look of it idk dont judge me lol or do
surface.CreateFont("HR_CR_BuyerFont", {
	font = "Arial",
	size = 48,
	weight = 600,
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
});


----------------------------
resource.AddFile("resource/fonts/Roboto-Regular.ttf")
print("[Bread]Font is included")
function clearInv(ply)
	if ply.numberOfBread != nil or ply.numberOfWine != nil or ply.numberOfOil or ply.numberOfScrap != nil then
		ply.numberOfBread = 0
		ply.numberOfWine = 0
		ply.numberOfOil = 0
		ply.numberOfScrap = 0
	end
end
hook.Add("DoPlayerDeath","clearBreadDeath",function(ply)
	clearInv(ply)
end )

HR_CrystalMeth = {}

HR_CrystalMeth.DrawDistance = 256; 
