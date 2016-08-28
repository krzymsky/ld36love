Class = require 'lib.hump.class'
Timer = require 'lib.hump.timer'
require 'globals'

WindupBar = Class {}

function WindupBar:init(x, y)
  self.x = x
  self.y = y
  self.width = 50
  self.height = 10
  self.ratios = {0.6, 0.2, 0.2}
  self.pointer = 0
end

function WindupBar:update(dt)
  self.pointer = self.pointer + 60*dt
  if self.pointer >= self.width then
    self.pointer = self.width
  end
end

function WindupBar:draw()
  love.graphics.setColor(255, 200, 0)
  love.graphics.rectangle('fill', self.x, self.y, self.width*self.ratios[1], self.height)
  love.graphics.setColor(0, 150, 0)
  love.graphics.rectangle('fill', self.x+self.width*self.ratios[1], self.y, self.width*self.ratios[2], self.height)
  love.graphics.setColor(255, 0, 0)
  love.graphics.rectangle('fill', self.x+self.width*(self.ratios[1]+self.ratios[2]), self.y, self.width*self.ratios[3], self.height)
  love.graphics.setColor(255, 255, 255)
  love.graphics.rectangle('fill', self.x+self.pointer, self.y - 10, 3, self.height)
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
