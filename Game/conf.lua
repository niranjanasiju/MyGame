function love.conf(t)
--[[    t.identity = "data/saves"           --save file  'data/saves'
    t.version = "1.0"
    t.console = false
    t.externalstorage = true          --save file in sd card
    t.gammacorrect = true 
]]
    t.window.title = "platformer"
  --t.window.icon = path name for icon
    t.window.width = 1280
    t.window.height = 720
    t.window.vsync = 0
    
end
