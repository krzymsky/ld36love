Class = require 'lib.hump.class'
Timer = require 'lib.hump.timer'
require 'globals'

Hud = Class {}

function Hud:init(game, x, y)
  self.game = game
  self.x = x
  self.y = y
  self.width = 620
  self.player1 = 0
  self.player2 = 0
  self.offset = -3*(self.width/self.game.game_length) -- 3 block created in aqueduct at start
end

function Hud:update(dt)
  self.player1 = self.game.aqueduct1.created_blocks*(self.width/self.game.game_length)
  self.player2 = self.game.aqueduct2.created_blocks*(self.width/self.game.game_length)
end

function Hud:draw()
  love.graphics.setColor(0, 0, 0)
  love.graphics.rectangle('fill', self.x, self.y, self.width + self.offset, 2)
  love.graphics.rectangle('fill', self.x, self.y + 10, self.width + self.offset, 2)
  love.graphics.setColor(255, 0, 0)
  love.graphics.circle('fill', self.x + self.player1 + self.offset, self.y, 4)
  love.graphics.setColor(0, 255, 0)
  love.graphics.circle('fill', self.x + self.player2 + self.offset, self.y + 10, 4)
  love.graphics.setColor(255, 255, 255)
end
