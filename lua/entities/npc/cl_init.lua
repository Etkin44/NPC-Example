
include("shared.lua")

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

local color_gray = Color(100, 100, 100, 255)
local color_background = Color(0, 0, 0, 200)
local function OpenNPCBaseMenuFunction()
    local NPCBaseMenu = vgui.Create("DFrame")
    NPCBaseMenu:SetSize(ScrW() * 0.25, ScrH() * 0.25)
    NPCBaseMenu:Center()
    NPCBaseMenu:SetDraggable(false)
    NPCBaseMenu:SetBackgroundBlur(5)
    NPCBaseMenu:MakePopup()
    NPCBaseMenu:SetTitle("NPC Example Menu")
    
    local BGPanel = vgui.Create("DPanel", NPCBaseMenu)
    BGPanel:Dock(FILL)
    BGPanel.Paint = function(self, w, h)
        surface.SetDrawColor(0, 0, 0, 200)
        surface.DrawRect(0, 0, w, h)
    end

    local DModelPanel = vgui.Create("DModelPanel", NPCBaseMenu)
    DModelPanel:SetSize(200, 200)
    DModelPanel:Center()
    DModelPanel:SetModel("models/gman_high.mdl")
    DModelPanel:SetAnimated(true)
end

function ENT:Draw()
    self:DrawModel()
    local ang = LocalPlayer():EyeAngles()
    ang = Angle(0, ang.y, 0)
    ang:RotateAroundAxis(ang:Forward(), 180)
    ang:RotateAroundAxis(ang:Right(), 90)
    ang:RotateAroundAxis(ang:Up(), 90)
    cam.Start3D2D(self:WorldSpaceCenter(), ang, 0.1)
    draw.RoundedBox(0, -125, -430, 250, 40, color_background)

    if LocalPlayer():GetEyeTrace().Entity:GetClass() == "npc" then
        draw.SimpleText("NPC Example", "NPC_F1", -90, -430, color_white)
    else
        draw.SimpleText("NPC Example", "NPC_F1", -90, -430, color_gray)
    end

    cam.End3D2D()
end

net.Receive("OpenNPCBaseMenu", function(len, ply)
    OpenNPCBaseMenuFunction()
end)
