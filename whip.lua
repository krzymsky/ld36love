Class = require 'lib.hump.class'
Timer = require 'lib.hump.timer'
anim8 = require 'lib.anim8'
require 'globals'

Whip = Class {}

function Whip:init(x, y)
  self.x = x
  self.y = y
  local g = anim8.newGrid(80,32,resources.whip_img:getWidth(), resources.whip_img:getHeight())
  self.animation = anim8.newAnimation(g('1-5', 1), 0.05)
end

function Whip:update(dt, master)
  self.animation:update(dt)
  self.x = master.x -5
  self.y = master.y -8
end

function Whip:draw()
  self.animation:draw(resources.whip_img, self.x, self.y)
end
