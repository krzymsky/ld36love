Class = require 'lib.hump.class'
Timer = require 'lib.hump.timer'
require 'globals'

WindupBar = Class {}

function WindupBar:init(game, x, y)
  self.game = game
  self.x = x
  self.y = y
  self.width = 110
  self.height = 19
  self.ratios = {0.6, 0.2, 0.2}
  self.pointer = 0
  self.pointer_speed = 80
end

function WindupBar:update(dt)
  if not self.game.game_finish and self.game.game_started then
    self.pointer = self.pointer + self.pointer_speed*dt
    if self.pointer >= self.width then
      self.pointer = self.width
    end
  end
end

function WindupBar:draw()
  --love.graphics.push()
  --love.graphics.translate(-self.width/2, -self.height)
  --love.graphics.scale(1.5, 1.5)
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
  --love.graphics.pop()
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

function WindupBar:initBonus()
  self.pointer_speed = 200
end

function WindupBar:endBonus()
  self.pointer_speed = 80
end
