game = {}

Timer = require 'lib.hump.timer'
require 'globals'
require 'aqueduct'
require 'firstPlan'
require 'bg'
require 'hud'
require 'popup'
require 'bonusBlock'

function game:init()
  self.canvas = love.graphics.newCanvas(globals.screen_width, globals.screen_height)
  self.canvas:setFilter("nearest", "nearest")
  self.game_length = 100
  self.game_finish = false
  self.shake_x = 0
  self.winner = null
  self.is_shaking = false
end

function game:enter()
  self.camera_x = 0
  self.aqueduct1 = Aqueduct(self, 0, 120, resources.whip_snd1, "1")
  self.aqueduct2 = Aqueduct(self, 0, 258, resources.whip_snd2, "2")
  self.hud = Hud(self, 20, 20)
  self.popup = Popup(320, 160)
  --self.first_plan = FirstPlan(0, globals.height - 128)
  self.bg = Bg(self, 0, 0)
  self.game_finish = false
  love.audio.play(resources.work_snd)
  resources.work_snd:setLooping(true)
  self.bonusBlocks = {}
end

function game:update(dt)
  if self.aqueduct1.length > self.aqueduct2.length then
    self.winner = self.aqueduct1
  else
    self.winner = self.aqueduct2
  end
  self.camera_x = math.floor(self.winner.length - 300)
  self.aqueduct1:update(dt)
  self.aqueduct2:update(dt)
  --self.first_plan:update(dt)
  self.bg:update(dt, self.winner.build_speed)
  Timer.update(dt)
  self:checkGameFinish()
  self.hud:update(dt)
  self.popup:update(dt)
end

function game:draw()
  love.graphics.clear(138,111,48)
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
  self.hud:draw()
  self.popup:draw()
  love.graphics.setCanvas()
  love.graphics.draw(self.canvas, globals.screen_width, globals.screen_height, self.shake_x, 2, 2, globals.screen_width/2, globals.screen_height/2)
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
  self.popup:show("WYGRAL "..self.winner.name)
end

function game:cameraShake()
  if not self.is_shaking then
    self.is_shaking = true
    Timer.tween(0.1, self, {shake_x = math.pi*0.01}, 'bounce',
    function()
      Timer.tween(0.1, self, {shake_x = -math.pi*0.01}, 'bounce',
      function()
        Timer.tween(0.1, self, {shake_x = 0}, 'bounce', function() self.is_shaking = false; end)
      end)
    end)
  end
end
