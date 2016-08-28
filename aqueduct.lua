Class = require 'lib.hump.class'
Timer = require 'lib.hump.timer'
require 'globals'
require 'aqueductBlock'
require 'windupBar'
require 'slave'
require 'master'

Aqueduct = Class {}

function Aqueduct:init(game, x, y)
    self.game = game
    self.x = x
    self.y = y
    self.length = 0
    self.created_blocks = 0
    self.start_build_speed = 50
    self.build_speed = 50
    self.container = {}
    self.container_count = 0
    self.next_x = 0
    self.timer = 0
    self.windup_bar = WindupBar(self.x + 150, self.y - 50)
    self.target_build_speed = 150
    self.target_build_speed_time = 1
    self.current_build_speed = self.build_speed
    self.water_length = 0
    self.water_timer = 0

    self.slaves = {}
    self:generateSlaves(5)

    self.master = Master(self.game, self.x, self.y - 12)

    self.p = love.graphics.newParticleSystem(resources.dust_img, 5)
    self.p:setParticleLifetime(0.2, 1)
    self.p:setLinearAcceleration(love.math.random(-100, 0), 0)
    self.p:setAreaSpread('normal', 20, 10)
    --self.p:setColors(255, 255, 255, 255, 255, 255, 255, 0)
    self.p:setSizes(1,0)

    self:buildBlock(false)
    self:buildBlock(false)
    self.length = 256
  end

  function Aqueduct:update(dt)
    self.water_timer = self.water_timer * dt
    if not self.game.game_finish then
      self.water_length = self.game.winner.length - 100 + self.water_timer*10
      self.length = self.length + self.build_speed * dt
      if self.container_count*globals.block_size <= self.length then
        self:buildBlock(true)
      end
    end
    self.windup_bar:update(dt)

    for i=#self.container,1,-1 do
      self.container[i]:update(dt)
      if self.container[i].x < (game.camera_x - 256) then
        table.remove(self.container, i)
      end
    end

    for _,o in ipairs(self.slaves) do
      o:update(dt, self.length)
    end
    self.master:update(dt, self.length)

    self.p:update(dt)
  end

  function Aqueduct:drawWindupBar()
    self.windup_bar:draw()
    love.graphics.draw(self.p,0,0)
  end

  function Aqueduct:draw()
    for _,o in ipairs(self.container) do
      o:draw()
    end
    --love.graphics.setColor(255, 255, 255)
    --love.graphics.rectangle('fill', self.x, self.y, self.length, 4)
    love.graphics.setColor(99, 155, 255)
    love.graphics.rectangle('fill', self.x, self.y + 7, self.water_length, 17)
    love.graphics.setColor(255, 255, 255)

    for _,o in ipairs(self.slaves) do
      o:draw()
    end

    self.master:draw()
  end

  function Aqueduct:buildBlock(anim)
    block = AqueductBlock(self.x + self.next_x, self.y, anim)
    table.insert(self.container, block)
    self.container_count = self.container_count + 1
    self.next_x = self.next_x + globals.block_size
    self.p:setPosition(self.length - self.game.camera_x, self.y+20)
    self.p:emit(5)
    self.created_blocks = self.created_blocks + 1
    print(self.created_blocks)
  end

  function Aqueduct:keypressed()
    love.audio.play(resources.whip_snd)
    if self.windup_bar:isInGreenField() then
      self.game:cameraShake()
      self.current_build_speed = self.start_build_speed
      --Timer.clear()
      Timer.tween(0.3, self, {build_speed = self.target_build_speed}, 'linear',
        function()
          Timer.after(self.target_build_speed_time,
            function()
              Timer.tween(0.3, self, {build_speed = self.start_build_speed}, 'linear',
                function()
                end)
            end)
          end)
      end
      self.windup_bar:resetPointer()
  end

  function Aqueduct:generateSlaves(count)
    for i=1,count do
      slave = Slave(self.game, self.x + love.math.random(-50, 50), self.y - 12)
      table.insert(self.slaves, slave)
    end
  end
