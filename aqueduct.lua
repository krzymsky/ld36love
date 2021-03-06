Class = require 'lib.hump.class'
Timer = require 'lib.hump.timer'
require 'globals'
require 'aqueductBlock'
require 'windupBar'
require 'slave'
require 'master'

Aqueduct = Class {}

function Aqueduct:init(game, x, y, snd, name, id)
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
    self.windup_bar = WindupBar(self.game, self.x + 150, self.y - 50)
    self.target_build_speed = 150
    self.target_build_speed_time = 1
    self.current_build_speed = self.build_speed
    self.water_length = 0
    self.water_timer = 0
    self.name = name
    self.id = id
    self.snd = snd

    self.slaves = {}
    self:generateSlaves(5)

    self.master = Master(self.game, self.x, self.y - 12, self.id)

    self.p = love.graphics.newParticleSystem(resources.dust_img, 5)
    self.p:setParticleLifetime(0.2, 1)
    self.p:setLinearAcceleration(love.math.random(-100, 0), 0)
    self.p:setAreaSpread('normal', 20, 10)
    --self.p:setColors(255, 255, 255, 255, 255, 255, 255, 0)
    self.p:setSizes(1,0)

    self.p_hammer = love.graphics.newParticleSystem(resources.hammer_img, 1)
    self.p_hammer:setParticleLifetime(0.2, 1)
    self.p_hammer:setAreaSpread('normal', 10, 20)
    self.p_hammer:setLinearAcceleration(-150, 50, -10, 150)
    self.p_hammer:setRotation(40, 100)
    self.p_hammer:setSpin(0, 20)
    self.p_hammer:setSpeed(-50, -20)

    self.p_axe = love.graphics.newParticleSystem(resources.axe_img, 1)
    self.p_axe:setParticleLifetime(0.2, 1)
    self.p_axe:setAreaSpread('normal', 10, 20)
    self.p_axe:setLinearAcceleration(-150, 50, -50, 100)
    self.p_axe:setRotation(60, 180)
    self.p_axe:setSpin(0, 20)
    self.p_axe:setSpeed(20, 60)

    self.p_pickaxe = love.graphics.newParticleSystem(resources.pickaxe_img, 1)
    self.p_pickaxe:setParticleLifetime(0.2, 1)
    self.p_pickaxe:setAreaSpread('normal', 10, 20)
    self.p_pickaxe:setLinearAcceleration(-120, 20, -20, 130)
    self.p_pickaxe:setRotation(40, 130)
    self.p_pickaxe:setSpin(0, 20)
    self.p_pickaxe:setSpeed(-20, 20)

    self:buildBlock(false)
    self:buildBlock(false)
    self:buildBlock(false)
    self.length = 350

    self.has_bonus = false
    self.bonus_timer = 0
  end

  function Aqueduct:update(dt)
    self.water_timer = self.water_timer + dt
    if not self.game.game_finish and self.game.game_started then
      if self.build_speed > self.start_build_speed then
        if self.water_length > 40 then
          self.water_length = self.water_length - 40*dt
        else
          self.water_length = 40
        end
      else
        self.water_length = self.water_length + 40*dt
      end
      if self.water_length > (self.length - self.game.camera_x) then
        self.water_length = self.length - self.game.camera_x
        self.game:gameFinish()
      end
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
    self.p_hammer:update(dt)
    self.p_axe:update(dt)
    self.p_pickaxe:update(dt)

    if self.has_bonus then
      self.bonus_timer = self.bonus_timer + dt
      if self.bonus_timer > 2 then
        self.bonus_timer = 0
        self:endBonus()
      end
    end
  end

  function Aqueduct:drawWindupBar()
    self.windup_bar:draw()
    love.graphics.draw(self.p,0,0)
    love.graphics.draw(self.p_hammer,0,0)
    love.graphics.draw(self.p_axe, 0,0)
    love.graphics.draw(self.p_pickaxe, 0,0)
  end

  function Aqueduct:draw()
    love.graphics.setColor(99, 155, 255)
    love.graphics.rectangle('fill', self.game.camera_x, self.y + 7, self.water_length, 17)
    love.graphics.setColor(255, 255, 255)

    for _,o in ipairs(self.slaves) do
      o:draw()
    end

    self.master:draw()

    love.graphics.draw(self.p,0,0)
  end

  function Aqueduct:drawBlocks()
    for _,o in ipairs(self.container) do
      o:draw()
    end
  end

  function Aqueduct:buildBlock(anim)
    block = AqueductBlock(self.game, self.x + self.next_x, self.y, anim)
    table.insert(self.container, block)
    self.container_count = self.container_count + 1
    self.next_x = self.next_x + globals.block_size
    self.p:setPosition(self.length - self.game.camera_x, self.y+20)
    self.p:emit(5)
    self.p_hammer:setPosition(self.length - self.game.camera_x, self.y+20)
    self.p_hammer:emit(1)
    self.p_axe:setPosition(self.length - self.game.camera_x, self.y+20)
    self.p_axe:emit(1)
    self.p_pickaxe:setPosition(self.length - self.game.camera_x, self.y+20)
    self.p_pickaxe:emit(1)
    self.created_blocks = self.created_blocks + 1
    print(self.created_blocks)
  end

  function Aqueduct:keypressed()

    love.audio.play(self.snd)
    if self.snd:isPlaying() then
        self.snd:rewind()
    end


    if self.windup_bar:isInGreenField() then
      self.game:cameraShake()
      --self.water_timer = self.water_timer - 10
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

  function Aqueduct:initBonus()
    self.has_bonus = true
    self.windup_bar:initBonus()
    love.audio.play(resources.bonus_snd)
  end

  function Aqueduct:endBonus()
    self.has_bonus = false
    self.windup_bar:endBonus()
  end
