Class = require 'lib.hump.class'
require 'globals'

FirstPlan = Class {}

function FirstPlan:init(x, y)
  self.x = x
  self.y = y
  self.container = {}

  table.insert(self.container, {x = 0})
  self:addImg()
  self:addImg()
  self:addImg()
  --self:addImg()
end

function FirstPlan:update(dt)
  for i=#self.container,1,-1 do
    self.container[i].x = self.container[i].x - 100*dt
    if self.container[i].x < -256 then
      table.remove(self.container, i)
      self:addImg()
    end
  end
end

function FirstPlan:draw()
  --love.graphics.setColor(255, 0, 0)
  --love.graphics.rectangle('fill', self.x, self.y, globals.block_size, globals.block_size)
  for i=#self.container,1,-1 do
    love.graphics.draw(resources.first_plan_img, self.x + self.container[i].x, self.y)
  end
end

function FirstPlan:addImg(x)
  table.insert(self.container, {x = self.container[#self.container].x + 256})
end
