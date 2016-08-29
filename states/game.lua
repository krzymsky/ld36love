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
  self.game_length = 100
  self.shake_x = 0
end

function game:enter()
  Timer.clear()
  self.camera_x = 0
  self.aqueduct1 = Aqueduct(self, 0, 120, resources.whip_snd1, "Player 1", globals.player1_master)
  self.aqueduct2 = Aqueduct(self, 0, 260, resources.whip_snd2, "Player 2", globals.player2_master)
  self.hud = Hud(self, 20, 20)
  self.popup = Popup(320, 160)
  --self.first_plan = FirstPlan(0, globals.height - 128)
  self.bg = Bg(self, 0, 0)
  self.game_finish = false
  self.bonus_block = null
  self.bonus_block_timer = 0
  self.bonus_taken = false
  self.winner = null
  self.is_shaking = false
  self.game_finish = false
  self.game_started = false
  self.game_start_timer = 0

  self.popup:show("2...")
  love.audio.stop(resources.work_snd)
end

function game:startGame()
  self.game_started = true
  love.audio.play(resources.work_snd)
  resources.work_snd:setLooping(true)
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

  if self.bonus_block then
    self.bonus_block:update(dt)
    if (not self.bonus_taken) and self.winner.length >= self.bonus_block.x then
      self.bonus_taken = true
      self.bonus_block:initBonus(self.winner)
    end
  end

  self.bonus_block_timer = self.bonus_block_timer + dt
  if self.bonus_block_timer > 0.5 then
    self.bonus_block_timer = 0
    self:generateBonusBlock()
  end

  if not self.game_started then
    self.game_start_timer = self.game_start_timer + dt
    if self.game_start_timer > 1 then
      self.popup:show("2... 1...")
    end
    if self.game_start_timer > 2 then
      self.game_start_timer = 0
      self:startGame()
      self.popup:hide()
    end
  end

  if self.bonus_block and self.bonus_block.x < (self.camera_x - 256) then
    self.bonus_block = null
    self.bonus_taken = false
  end
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

  self.aqueduct1:drawBlocks()
  self.aqueduct2:drawBlocks()
  if self.bonus_block then
    self.bonus_block:draw()
  end
  self.aqueduct1:draw()
  self.aqueduct2:draw()
  if self.bonus_block then
    self.bonus_block:drawGuy()
  end
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
  if key == 's' then
    self.aqueduct1:keypressed()
  end
  if key == 'down' then
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
  self.popup:show("THE WINNER IS\n"..self.winner.name.."\n\npress R to restart")
  love.audio.stop(resources.work_snd)
end

function game:cameraShake()
  if not self.is_shaking then
    self.is_shaking = true
    Timer.tween(0.1, self, {shake_x = math.pi*0.005}, 'bounce',
    function()
      Timer.tween(0.1, self, {shake_x = -math.pi*0.005}, 'bounce',
      function()
        Timer.tween(0.1, self, {shake_x = 0}, 'bounce', function() self.is_shaking = false; end)
      end)
    end)
  end
end

function game:generateBonusBlock()
  if not self.bonus_block then
    self.bonus_block = BonusBlock(self, self.camera_x + globals.screen_width/2, self.aqueduct1.y)
  end
end
