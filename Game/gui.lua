local GUI = {}
local Player = require("Game.player")

function GUI:load()
   self.coins = {}
   self.coins.img = love.graphics.newImage("Game/sprites/Coin1.png")
   self.coins.width = self.coins.img:getWidth()
   self.coins.height = self.coins.img:getHeight()
   self.coins.scale = 1
   self.coins.x = love.graphics.getWidth() - 100
   self.coins.y = 40
   self.font = love.graphics.newFont(36)
   
   self.hearts = {}
   self.hearts.img = love.graphics.newImage("assets/heart.png")
   self.hearts.width = self.hearts.img:getWidth()
   self.hearts.height = self.hearts.img:getHeight()
   self.hearts.x = 0
   self.hearts.y = 40
   self.hearts.scale = 0.8
   self.hearts.spacing = self.hearts.width * self.hearts.scale +20

    soundOnIcon = love.graphics.newImage("assets/sound-on.png")
    soundOffIcon = love.graphics.newImage("assets/sound-off.png")


   soundButton = {
    x = love.graphics.getWidth() - soundOnIcon:getWidth() - 20,  
    y = 20,
    width = 24,  
    height = 24,  
    on = true,
    backgroundMusic:play()  
}


end

function GUI:update(dt)
    
end

function GUI:draw()
    self:displayCoins()
    self:displayHearts()
    self.soundIcon()
end

function GUI:displayCoins()
    love.graphics.draw(self.coins.img, self.coins.x, self.coins.y, 0, self.coins.scale, self.coins.scale )
    love.graphics.print(" : "..Player.coins, self.coins.x + self.coins.width * self.coins.scale, self.coins.y )
end

function GUI:displayHearts()
    for i=1,Player.health.current do
       local x = self.hearts.x + self.hearts.spacing * i
       
       
       love.graphics.draw(self.hearts.img, x, self.hearts.y, 0, self.hearts.scale, self.hearts.scale)
    end
end

function GUI.soundIcon()
    local soundIconX = love.graphics.getWidth() - soundOnIcon:getWidth() - 20
    love.graphics.draw(soundButton.on and soundOnIcon or soundOffIcon, soundIconX, 40, 0, soundButton.width / soundOnIcon:getWidth(), soundButton.height / soundOnIcon:getHeight())
end

function GUI.toggleSound()
    soundButton.on = not soundButton.on
    if soundButton.on then
        backgroundMusic:play() 
    else
        backgroundMusic:stop()  
    end
end

return GUI