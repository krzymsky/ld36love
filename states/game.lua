game = {}

Timer = require 'lib.hump.timer'
require 'aqueduct'
require 'firstPlan'
require 'bg'

function game:init()
  self.canvas = love.graphics.newCanvas(globals.width, globals.height)
  self.canvas:setFilter("nearest", "nearest")
end

function game:enter()
  self.camera_x = 0
  self.aqueduct1 = Aqueduct(self, 0, 150)
  self.aqueduct2 = Aqueduct(self, 0, 240)
  --self.first_plan = FirstPlan(0, globals.height - 128)
  self.bg = Bg(0, 0)
end

function game:update(dt)
  self.camera_x = math.floor(self.aqueduct1.length - 256)
  self.aqueduct1:update(dt)
  self.aqueduct2:update(dt)
  --self.first_plan:update(dt)
  self.bg:update(dt, self.aqueduct1.build_speed)
  Timer.update(dt)
end

function game:draw()
  love.graphics.setCanvas(self.canvas)
  love.graphics.clear()
  self.bg:draw()
  love.graphics.push()
  if self.aqueduct1.length > 256 then
    love.graphics.translate(-self.camera_x, 0)
  end

  self.aqueduct1:draw()
  self.aqueduct2:draw()
  love.graphics.pop()
  self.aqueduct1:drawWindupBar()
  self.aqueduct2:drawWindupBar()
  --self.first_plan:draw()
  love.graphics.setCanvas()
  love.graphics.draw(self.canvas, 0, 0, 0, 2, 2)
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
