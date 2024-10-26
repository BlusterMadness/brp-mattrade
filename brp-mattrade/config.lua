Config = {}

Config.PedLocation = vector4(-482.07, -1705.69, 18.73, 252.48)
Config.PedModel = 'u_m_m_streetart_01'

Config.Materials = {
    'steel',
    'copper',
    'iron',
    'glass',
    'plastic',
    'rubber',
    'aluminum',
    'metalscrap'
}

Config.RecyclableMaterial = 'recyclablematerial'
Config.RequiredAmount = 100
Config.RewardRange = {105, 125} -- Minimum and Maximum random reward amount

-- Blip settings
Config.ShowBlip = false -- Toggle blip on or off
Config.BlipSettings = {
    BlipId = 365, -- Blip icon (make it whatever you want)
    BlipColor = 1, -- Blip color (change according to your needs)
    BlipScale = 0.8, -- Blip size
    BlipText = "Material Trader" -- Text that appears on the map
}