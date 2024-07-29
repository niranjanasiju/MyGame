local Camera = {
    x = 0,
    y = 0,
    scale = 1,
}
function Camera:apply()
    love.graphics.push()
    love.graphics.scale(self.scale,self.scale)
    love.graphics.translate(-self.x, -self.y)
end

function Camera:clear()
    love.graphics.pop()
end

function Camera:setPosition(x, y)
    self.x = x - love.graphics.getWidth() / 2 / self.scale
    self.y = y
    local Right_side = self.x + love.graphics.getWidth() / 2
    local MapWidth = 4400
    if self.x < 0 then
        self.x = 0
    elseif Right_side > MapWidth then
        self.x = MapWidth - love.graphics.getWidth() / 2
     end
end
 

return Camera