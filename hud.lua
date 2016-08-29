Class = require 'lib.hump.class'
Timer = require 'lib.hump.timer'
require 'globals'

Hud = Class {}

function Hud:init(game, x, y)
  self.game = game
  self.x = x
  self.y = y
  self.width = 500
  self.player1 = 0
  self.player2 = 0
end

function Hud:update(dt)
  
end

function Hud:draw()
  love.graphics.setColor(0, 0, 0)
  love.graphics.rectangle('fill', self.x, self.y, self.width, 2)
  love.graphics.rectangle('fill', self.x, self.y + 10, self.width, 2)
  love.graphics.setColor(255, 0, 0)
  love.graphics.circle('fill', self.x + self.player1, self.y, 4)
  love.graphics.setColor(0, 255, 0)
  love.graphics.circle('fill', self.x + self.player2, self.y + 10, 4)
  love.graphics.setColor(255, 255, 255)
end
