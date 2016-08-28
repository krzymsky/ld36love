game = {}

Timer = require 'lib.hump.timer'
require 'aqueduct'
require 'firstPlan'
require 'bg'

function game:init()
  self.canvas = love.graphics.newCanvas(globals.width, globals.height)
  self.canvas:setFilter("nearest", "nearest")
  self.game_length = 100
  self.game_finish = false
  self.shake_x = 0
  self.winner = null
end

function game:enter()
  self.camera_x = 0
  self.aqueduct1 = Aqueduct(self, 0, 150)
  self.aqueduct2 = Aqueduct(self, 0, 240)
  --self.first_plan = FirstPlan(0, globals.height - 128)
  self.bg = Bg(self, 0, 0)
  self.game_finish = false
end

function game:update(dt)
  if self.aqueduct1.length > self.aqueduct2.length then
    self.winner = self.aqueduct1
  else
    self.winner = self.aqueduct2
  end
  self.camera_x = math.floor(self.winner.length - 256)
  self.aqueduct1:update(dt)
  self.aqueduct2:update(dt)
  --self.first_plan:update(dt)
  self.bg:update(dt, self.winner.build_speed)
  Timer.update(dt)
  self:checkGameFinish()
end

function game:draw()
  love.graphics.setCanvas(self.canvas)
  love.graphics.clear()
  self.bg:draw()
  love.graphics.push()
  if self.winner.length > 256 then
    love.graphics.translate(-self.camera_x, 0)
  end

  self.aqueduct1:draw()
  self.aqueduct2:draw()
  love.graphics.pop()
  self.aqueduct1:drawWindupBar()
  self.aqueduct2:drawWindupBar()
  --self.first_plan:draw()
  love.graphics.setCanvas()
  love.graphics.draw(self.canvas, 640, 320, self.shake_x, 3, 3, 320, 160)
  debugDraw()
end

function game:keypressed(key)
  if key == 'a' then
    self.aqueduct1:keypressed()
  end
  if key == 'l' then
    self.aqueduct2:keypressed()
  end
end

function game:checkGameFinish()
  if self.aqueduct1.created_blocks >= self.game_length then
    self:gameFinish(1)
  elseif self.aqueduct2.created_blocks >= self.game_length then
    self:gameFinish(2)
  end
end

function game:gameFinish()
  self.game_finish = true
end

function game:cameraShake()
  Timer.tween(0.1, self, {shake_x = math.pi*0.01}, 'bounce',
  function()
    Timer.tween(0.1, self, {shake_x = -math.pi*0.01}, 'bounce',
    function()
      Timer.tween(0.1, self, {shake_x = 0}, 'bounce')
    end)
  end)
end
