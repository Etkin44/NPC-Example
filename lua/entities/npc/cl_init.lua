include("shared.lua") --including entity informations

surface.CreateFont("NPC_F1", {
    font = "Arial",
    size = 35,
    antialias = true,
})

surface.CreateFont("NPC_F2", {
    font = "Arial",
    size = 16,
    antialias = true,
})

--Creating fonts(it should on top of code)

local color_fadeblack = Color(0, 0, 0, 200)
local color_white = Color(255, 255, 255)
local color_grey = Color(100, 100, 100)

--Load Menu and hide it
local NPCBaseMenu = vgui.Create("DFrame") --Creating menu
NPCBaseMenu:SetSize(ScrW() / 4, ScrH() / 4) --Set this size
NPCBaseMenu:Center() --Center of screen
NPCBaseMenu:SetDraggable(false) --Should menu moveable ?
NPCBaseMenu:SetBackgroundBlur(5) --Menu Background Blur
NPCBaseMenu:SetDeleteOnClose(false) --When you close button it's removing by default.But we don't want this.
NPCBaseMenu:MakePopup() --Fuck keyboards.Only mouse :D
NPCBaseMenu:SetTitle("NPC Example Menu") --Title of menu
local BGPanel = vgui.Create("DPanel", NPCBaseMenu) --Background Panel for DModelPanel
BGPanel:Dock(FILL) --Size is NPCBaseMenu Size

BGPanel.Paint = function(self, w, h) --Painting
    surface.SetDrawColor(color_fadeblack)
    surface.DrawRect(0, 0, w, h)
end

local DModelPanel = vgui.Create("DModelPanel", NPCBaseMenu) --DModelPanel
DModelPanel:SetSize(200, 200) --Size
DModelPanel:Center() --You know what is this no longer
DModelPanel:SetModel("models/gman_high.mdl") --Set Model to DModelPanel
DModelPanel:SetAnimated(true) --Run animation(walk)?

NPCBaseMenu:Hide() --Created and let's hide it.When we need to see menu,we will use Show() function.
--Loaded Menu and hided.Now we can show and hide.We don't removed and recreated.Because it's bad idea.(Narim#9557 thx for advice)

local function OpenNPCBaseMenuFunction() --Custom and only for this file
    NPCBaseMenu:Show() --Show Menu
end

function ENT:Draw() --NPC Draw
    local ply = LocalPlayer()
    self:DrawModel()
    local ang = ply:EyeAngles()
    ang = Angle(0, ang.y, 0)
    ang:RotateAroundAxis(ang:Forward(), 180)
    ang:RotateAroundAxis(ang:Right(), 90)
    ang:RotateAroundAxis(ang:Up(), 90)
    cam.Start3D2D(self:WorldSpaceCenter(), ang, 0.1)
    draw.RoundedBox(0, -125, -430, 250, 40, color_fadeblack)

    if ply:GetEyeTrace().Entity == self then --What player on eyes? If it's our npc change color.If not make this grey.
        draw.SimpleText("NPC Example", "NPC_F1", -90, -430, color_white)
    else
        draw.SimpleText("NPC Example", "NPC_F1", -90, -430, color_grey)
    end

    cam.End3D2D()
end

net.Receive("OpenNPCBaseMenu", function(len, ply) --Network on received
    OpenNPCBaseMenuFunction() --Run Menu
end)
