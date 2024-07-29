_G.love = require("love")
local Player = require ("Game.player")
local Coin = {}
Coin.__index = Coin

CollectableCoins={}
function Coin.new(x, y)
    local instance = setmetatable({}, Coin)  
    instance.x = x
    instance.y = y
    instance.img = love.graphics.newImage("Game/sprites/Coin1.png")
    instance.width = instance.img:getWidth()
    instance.height = instance.img:getHeight()
    instance.rotationValue=1
    instance.toRemove = false
    instance.timeOffset = math.random(1,100)
    instance.physics ={}
        instance.physics.body = love.physics.newBody(World, instance.x, instance.y, "static")
        instance.physics.shape = love.physics.newRectangleShape(instance.width, instance.height)
        instance.physics.fixture= love.physics.newFixture(instance.physics.body, instance.physics.shape)
    
    instance.physics.fixture: setSensor(true)
    table.insert(CollectableCoins, instance)
end

function Coin:update(dt)
    self:rotate(dt)
    self:checkRemove()
end

function Coin:checkRemove()
    if self.toRemove then
        self:collect()
    end
end

function Coin:draw()
    love.graphics.draw(self.img, self.x, self.y, 0, self.rotationValue,1, self.width/2, self.height/2)
end

function Coin:rotate(dt)
    self.rotationValue=math.sin(love.timer.getTime() *2 + self.timeOffset)
end

function Coin.updateAll(dt)
    for i, instance in ipairs(CollectableCoins) do
        instance:update(dt)
    end
end

function Coin.drawAll()
    for i, instance in ipairs(CollectableCoins) do
        instance:draw()
    end
end

function Coin.removeAll()
    for i,v in ipairs(CollectableCoins) do
       v.physics.body:destroy()
    end
 
    CollectableCoins = {}
 end
 

function Coin.beginContact(a,b,collision)
    for i, instance in ipairs(CollectableCoins) do
        if a==instance.physics.fixture or b== instance.physics.fixture then
            if a==Player.physics.fixture or b==Player.physics.fixture then
                instance.toRemove = true
                return true
            end
        end
    end
end

function Coin: collect()
    for i, instance in ipairs(CollectableCoins) do
        if instance == self then
            Player: incrementCoins()
            print(Player.coins)
            self.physics.body:destroy()
            table.remove(CollectableCoins, i)
        end
    end
end

return Coin