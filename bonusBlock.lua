Class = require 'lib.hump.class'
Timer = require 'lib.hump.timer'
require 'globals'

BonusBlock = Class {}

function BonusBlock:init(game, x, y)
  self.game = game
  self.x = x
  self.y = y
end

function BonusBlock:update(dt)
end

function BonusBlock:draw()
  --love.graphics.setColor(255, 0, 0)
  --love.graphics.rectangle('fill', self.x, self.y, globals.block_size, globals.block_size)
  love.graphics.draw(resources.bonus_block_img, self.x, self.y)
end
