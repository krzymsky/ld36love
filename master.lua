Class = require 'lib.hump.class'
Timer = require 'lib.hump.timer'
anim8 = require 'lib.anim8'
require 'globals'
require 'whip'

Master = Class {}

function Master:init(game, x, y)
  self.game = game
  self.x = x
  self.y = y
  self.delta = 0
  self.delta2 = 0
  self.randseed = love.math.random(0, globals.block_size)
  self.whip = Whip(self.x,self.y)
  --self.anim = anim
  --local g = anim8.newGrid(64,64,resources.aqueduct_block_img:getWidth(), resources.aqueduct_block_img:getHeight())
  --self.animation = anim8.newAnimation(g('1-4', 1), 0.15, 'pauseAtEnd')
  --self.animationLast = anim8.newAnimation(g(4, 1), 0.15, 'pauseAtEnd')
end

function Master:update(dt, x)
  self.delta = math.sin(love.timer.getTime() + self.randseed) * 5
  self.delta2 = math.sin(love.timer.getTime() + self.x*0.5) * 5
  --if self.anim then
  --  self.animation:update(dt)
  --end
  if not self.game.game_finish then
    self.x = x + self.delta - 100
    self.whip:update(dt, self)
  end
  --self.y = self.y + self.delta
end

function Master:draw()
  --love.graphics.setColor(255, 0, 0)
  --love.graphics.rectangle('fill', self.x, self.y, globals.block_size, globals.block_size)
  --if self.anim then
  --  self.animation:draw(resources.aqueduct_block_img, self.x, self.y)
  --else
  --  self.animationLast:draw(resources.aqueduct_block_img, self.x, self.y)
  love.graphics.draw(resources.master_img, self.x, self.y + self.delta2*0.5)
  self.whip:draw()
end
