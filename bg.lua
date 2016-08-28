Class = require 'lib.hump.class'
require 'globals'

Bg = Class {}

function Bg:init(x, y)
  self.x = x
  self.y = y
  self.container = {}

  table.insert(self.container, {x = 0})
  self:addImg()
  self:addImg()
  self:addImg()
  --self:addImg()
end

function Bg:update(dt, speed)
  for i=#self.container,1,-1 do
    self.container[i].x = self.container[i].x - speed*dt
    if self.container[i].x < -256 then
      table.remove(self.container, i)
      self:addImg()
    end
  end
end

function Bg:draw()
  for i=#self.container,1,-1 do
    love.graphics.draw(resources.bg_img, self.x + self.container[i].x, self.y)
  end
end

function Bg:addImg(x)
  table.insert(self.container, {x = self.container[#self.container].x + 256})
end
