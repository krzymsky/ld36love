Class = require 'lib.hump.class'
Timer = require 'lib.hump.timer'
require 'globals'

BonusBlock = Class {}

function BonusBlock:init(game, x, y)
  self.game = game
  self.x = x
  self.y = y
  self.bonus_guy_y = 90
  self.delta = 0
  self.guy_visible = true
end

function BonusBlock:update(dt)
  self.delta = math.sin(love.timer.getTime() + self.game.winner.length*0.2)*0.1
end

function BonusBlock:draw()
  --love.graphics.setColor(255, 0, 0)
  --love.graphics.rectangle('fill', self.x, self.y, globals.block_size, globals.block_size)
  love.graphics.draw(resources.bonus_block_img, self.x, self.y)
end

function BonusBlock:drawGuy()
  if self.guy_visible then
    love.graphics.draw(resources.bonus_chest_img, self.x + 30, self.y + self.bonus_guy_y, 0, -1, 1, 16, 32, -self.delta)
    love.graphics.draw(resources.bonus_guy_img, self.x + 30, self.y + self.bonus_guy_y -26, 0, -1, 1, 16, 32, self.delta)
  end
end

function BonusBlock:initBonus(winner)
  Timer.tween(0.6, self, {bonus_guy_y = winner.y - 85}, 'bounce', function() self.guy_visible = false; end)
  winner:initBonus()
end
