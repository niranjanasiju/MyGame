Enemy_1 = {}
Enemy_1.__index = Enemy_1
local Player = require("Game.player")

local ActiveEnemies = {}

function Enemy_1.removeAll()
   for i,v in ipairs(ActiveEnemies) do
      table.remove(ActiveEnemies, i)
      v.physics.body:destroy()
      
   end

   ActiveEnemies = {}
end

function Enemy_1.new(x,y)
   local instance = setmetatable({}, Enemy_1)
   instance.x = x
   instance.y = y
   instance.r = 0
   instance.speed = 50
   instance.xVel = instance.speed
   instance.damage = 1
   instance.directionTimer = 0

   instance.state = "crawl"

   instance.animation = {timer = 0, rate = 0.1}
   instance.animation.crawl = {total = 4, current = 1, img = Enemy_1.crawlAnim}
   instance.animation.draw = instance.animation.crawl.img[1]
   instance.facingRight = true
   instance.physics = {}
   instance.physics.body = love.physics.newBody(World, instance.x, instance.y, "dynamic")
   instance.physics.body:setFixedRotation(true)
   instance.physics.shape = love.physics.newRectangleShape(instance.width * 0.4, instance.height * 0.75)
   instance.physics.fixture = love.physics.newFixture(instance.physics.body, instance.physics.shape)
   instance.physics.body:setMass(25)
   table.insert(ActiveEnemies, instance)
end

function Enemy_1.loadAssets()
    Enemy_1.crawlAnim = {}
    for i=1,4 do
        Enemy_1.crawlAnim[i] = love.graphics.newImage("Game/sprites/enemy/crawl/"..i..".png")
    end

    Enemy_1.width = Enemy_1.crawlAnim[1]:getWidth()
    Enemy_1.height = Enemy_1.crawlAnim[1]:getHeight()

end

function Enemy_1:update(dt)
   self:animate(dt)
   self:syncPhysics()
   self:changeDirection(dt)
   
end

function Enemy_1:flipDirection()
   self.facingRight = not self.facingRight
   self.xVel = -self.xVel
 end

function Enemy_1:animate(dt)
   self.animation.timer = self.animation.timer + dt
   if self.animation.timer > self.animation.rate then
      self.animation.timer = 0
      self:setNewFrame()
   end
end

function Enemy_1:setNewFrame()
   local anim = self.animation[self.state]
   if anim.current < anim.total then
      anim.current = anim.current + 1
   else
      anim.current = 1
   end
   self.animation.draw = anim.img[anim.current]
end

function Enemy_1:syncPhysics()
   self.x, self.y = self.physics.body:getPosition()
   self.physics.body:setLinearVelocity(self.xVel , 100)
end

function Enemy_1:draw()
   local scaleX = 1
   if self.xVel < 0 then
      scaleX = -1
   end
   love.graphics.draw(self.animation.draw, self.x, self.y-15, self.r, 2*scaleX, 2, self.width / 2, self.height / 2)
end

function Enemy_1.updateAll(dt)
   for i,instance in ipairs(ActiveEnemies) do
      instance:update(dt)
   end
end

function Enemy_1.drawAll()
   for i,instance in ipairs(ActiveEnemies) do
      instance:draw()
   end
end

function Enemy_1.beginContact(a, b, collision)
   local playerFixture = Player.physics.fixture
   for i,instance in ipairs(ActiveEnemies) do
      if (a == instance.physics.fixture and b == playerFixture) or (a == playerFixture and b == instance.physics.fixture) then
         Player:takeDamage(instance.damage)
      end
   end
end

function Enemy_1:changeDirection(dt)
   self.directionTimer = self.directionTimer + dt
   if self.directionTimer >= 4 then
      self:flipDirection()
      self.directionTimer = 0
   end
end
return Enemy_1