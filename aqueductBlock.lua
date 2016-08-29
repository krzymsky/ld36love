Class = require 'lib.hump.class'
Timer = require 'lib.hump.timer'
anim8 = require 'lib.anim8'
require 'globals'

AqueductBlock = Class {}

function AqueductBlock:init(game, x, y, anim)
  self.game = game
  self.x = x
  self.y = y
  self.anim = anim
  self.delta = 0
  local g = anim8.newGrid(64,64,resources.aqueduct_block_img:getWidth(), resources.aqueduct_block_img:getHeight())
  self.animation = anim8.newAnimation(g('1-4', 1), 0.15, 'pauseAtEnd')
  self.animationLast = anim8.newAnimation(g(4, 1), 0.15, 'pauseAtEnd')
end

function AqueductBlock:update(dt)
  if self.anim then
    self.animation:update(dt)
  end
  self.delta = math.sin(love.timer.getTime() + self.game.winner.length*0.2)*0.1
end

function AqueductBlock:draw()
  --love.graphics.setColor(255, 0, 0)
  --love.graphics.rectangle('fill', self.x, self.y, globals.block_size, globals.block_size)
  if self.anim then
    self.animation:draw(resources.aqueduct_block_img, self.x + 32, self.y + 64, 0, 1, 1, 32, 64, self.delta)
  else
    self.animationLast:draw(resources.aqueduct_block_img, self.x + 32, self.y + 64, 0, 1, 1, 32, 64, self.delta)
  end
end
