Class = require 'lib.hump.class'
Timer = require 'lib.hump.timer'
require 'globals'

WindupBar = Class {}

function WindupBar:init(x, y)
  self.x = x
  self.y = y
  self.width = 110
  self.height = 19
  self.ratios = {0.6, 0.2, 0.2}
  self.pointer = 0
end

function WindupBar:update(dt)
  self.pointer = self.pointer + 80*dt
  if self.pointer >= self.width then
    self.pointer = self.width
  end
end

function WindupBar:draw()
  love.graphics.setColor(251, 242, 54)
  love.graphics.rectangle('fill', self.x, self.y, self.width*self.ratios[1], self.height)
  love.graphics.setColor(106, 190, 48)
  love.graphics.rectangle('fill', self.x+self.width*self.ratios[1], self.y, self.width*self.ratios[2], self.height)
  love.graphics.setColor(172, 50, 50)
  love.graphics.rectangle('fill', self.x+self.width*(self.ratios[1]+self.ratios[2]), self.y, self.width*self.ratios[3], self.height)
  love.graphics.setColor(255, 255, 255)
  love.graphics.draw(resources.bar_img, self.x - 7,self.y - 7)
  love.graphics.draw(resources.arrow_img, self.x - 8+self.pointer, self.y - 23)
  --love.graphics.rectangle('fill', self.x+self.pointer, self.y - 10, 3, self.height)
end

function WindupBar:isInGreenField()
  if (self.pointer > self.ratios[1]*self.width) and (self.pointer < (self.ratios[1]+self.ratios[2])*self.width) then
    return true
  else
    return false
  end
end

function WindupBar:resetPointer()
  self.pointer = 0
end
