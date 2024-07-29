_G.love = require("love")
local STI = require("Game.libraries/sti")
local player = require ("Game.player")
local Coin = require("Game.coin")
love.graphics.setDefaultFilter("nearest", "nearest")
local GUI = require("Game.gui")
local Camera = require ("Game.camera")
local Enemy_1 = require ("Game/enemy/enemy_1")
local Enemy_2 = require ("Game/enemy/enemy_2")
local Enemy_3 = require ("Game/enemy/enemy_3")
local Enemy_4 = require ("Game/enemy/enemy_4")

function love.load()
    love.graphics.setBackgroundColor(0, 0.5, 0.5)
    Map = STI("Game/maps/final.lua", {"box2d"})
    World = love.physics.newWorld(0,2000)
    World:setCallbacks(beginContact, endContact)
    Map:box2d_init(World)
    Map.layers.solids.visible = false
    Map.layers.entity.visible = false
    MapWidth = Map.layers.elements.width  * 16
    love.graphics.setBackgroundColor(0, 0.5, 0.5)
    player:load()
    Enemy_1.loadAssets()
    Enemy_2.loadAssets()
    Enemy_3.loadAssets()
    Enemy_4.loadAssets()
    GUI:load()

    Coin.new(408, 367)
    Coin.new(552, 109)
    Coin.new(773, 410)
    Coin.new(875, 141)
    Coin.new(1084, 32)
    Coin.new(1308, 144)
    Coin.new(1194, 400)
    Coin.new(1372, 312)
    Coin.new(1502, 445)
    Coin.new(1697, 449)
    Coin.new(1828, 329)
    Coin.new(2169.5, 432.5)
    Coin.new(2416.67, 172)
    Coin.new(2558.67, 432.67)
    Coin.new(3052, 420)
    Coin.new(3071, 104)
    Coin.new(3599.33, 104)
    Coin.new(3529, 472)
    Coin.new(3903.33, 302.67)
    Coin.new(3982.67, 476.67)
    Coin.new(4278.67, 410.67)
    Coin.new(4629, 314)

    Enemy_1.new(650,430)
    Enemy_1.new(1070,40)
    Enemy_1.new(2560,455)
    Enemy_1.new(3100,120)
    Enemy_2.new(1600,505)
    Enemy_3.new(610,123)
    Enemy_3.new(3105,446)
    Enemy_4.new(3624,120)
    Enemy_4.new(2456,456)

end

function love.update(dt)
    World:update(dt)
    player:update(dt)
    Coin: updateAll(dt)
    Enemy_1.updateAll(dt)
    Enemy_2.updateAll(dt)
    Enemy_3.updateAll(dt)
    Enemy_4.updateAll(dt)
    GUI:update(dt)
    Camera:setPosition(player.x, 0)
end

function love.draw()
    Map:draw(-Camera.x, -Camera.y, Camera.scale, Camera.scale)
    Camera:apply()   
    player:draw()
    Coin: drawAll()
    Enemy_1.drawAll()
    Enemy_2.drawAll()
    Enemy_3.drawAll()
    Enemy_4.drawAll()
    Camera:clear()
    GUI:draw()
end

function love.keypressed(key)
    player:jump(key)
end

function love.mousepressed(x, y, button, istouch, presses)

    if button == 1 and x >= soundButton.x and x <= soundButton.x + soundButton.width and
    y >= soundButton.y and y <= soundButton.y + soundButton.height then
        GUI.toggleSound()
    end
end

function beginContact(a, b, collision)
    if Coin.beginContact(a, b, collision) then return end
    Enemy_1.beginContact(a, b, collision)
    Enemy_2.beginContact(a, b, collision)
    Enemy_3.beginContact(a, b, collision)
    Enemy_4.beginContact(a, b, collision)
    player:beginContact(a, b, collision)
end

function endContact(a, b, collision)
    player:endContact(a, b, collision)
end

