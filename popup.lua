Class = require 'lib.hump.class'
Timer = require 'lib.hump.timer'
require 'globals'

Popup = Class {}

function Popup:init(x, y)
  self.x = x
  self.y = y
  self.width = 128
  self.height = 128
  self.visible = false
  self.text = ""
  self.show_r = false
end

function Popup:update(dt)
end

function Popup:draw()
  if self.visible then
    love.graphics.setColor(0, 0, 0, 190)
    love.graphics.rectangle('fill', 0, 0, globals.screen_width, globals.screen_height)
    love.graphics.setColor(255, 255, 255)
    love.graphics.draw(resources.popup_img, self.x - 64, self.y - 64)
    love.graphics.setFont(resources.times_fnt)
    love.graphics.setColor(0, 0, 0)
    love.graphics.printf(self.text, self.x - 64, self.y - 30, 128, "center")
    love.graphics.setColor(255, 255, 255)
    if self.show_r then
      love.graphics.draw(resources.button_r_img, self.x - 50, self.y + 8)
    end
  end
end

function Popup:show(text, show_r)
  self.text = text
  self.visible = true
  self.show_r = show_r or false
end

function Popup:hide()
  self.visible = false
  self.show_r = false
end
