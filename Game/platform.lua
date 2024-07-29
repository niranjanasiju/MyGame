local STI = require("Game.libraries/sti")

_G.platform = {}

function platform.load()
    love.graphics.setBackgroundColor(0, 0.5, 0.5)

    platform.map = STI("Game.maps/final.lua", {"box2d"})

    platform.World = love.physics.newWorld(0,0)
    platform.map:box2d_init(platform.World)
    platform.map.layers.solid.visible = false
end

function platform:update(dt)
    platform.World:update(dt)
end

function DRAW_PLATFORM()
    platform.map:draw(0, -125, 2, 2)
    love.graphics.push()
    love.graphics.scale(2,2)
    love.graphics.pop()
end