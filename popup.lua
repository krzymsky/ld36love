Class = require 'lib.hump.class'
Timer = require 'lib.hump.timer'
require 'globals'

Popup = Class {}

function Popup:init(x, y)
  self.x = x
  self.y = y
  self.width = 200
  self.height = 120
  self.visible = false
  self.text = ""
end

function Popup:update(dt)
end

function Popup:draw()
  if self.visible then
    love.graphics.setColor(0, 0, 0)
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
    love.graphics.setColor(255, 255, 255)
    love.graphics.print(self.text, self.x + self.width/2, self.y + self.height/2)
  end
end

function Popup:show(text)
  self.text = text
  self.visible = true
end
