local debugGraph = require 'lib.debugGraph'
local GameState = require 'lib.hump.gamestate'

resources = {
  smallFont = love.graphics.newFont(10),
  aqueduct_block_img = love.graphics.newImage("res/aqueduct_block.png"),
  first_plan_img = love.graphics.newImage("res/first_plan.png"),
  bg_img = love.graphics.newImage("res/bg.png"),
  slave1_img = love.graphics.newImage("res/slave1.png"),
  master_img = love.graphics.newImage("res/master.png"),
  dust_img = love.graphics.newImage("res/dust.png"),
  whip_img = love.graphics.newImage("res/whip.png"),
  whip_snd = love.audio.newSource("res/s_whip.wav")
}

function debugDraw()
  local r,g,b,a = love.graphics.getColor()
  love.graphics.setColor(255, 255, 255)
  fpsGraph:draw()
  memGraph:draw()
  local stats = love.graphics.getStats()
  love.graphics.setFont(font)
  love.graphics.print("DRAWCALLS: "..stats.drawcalls, 100, 20)
  love.graphics.setColor(r,g,b,a)
end

require 'states.mainmenu'
require 'states.game'

function love.load()
  fpsGraph = debugGraph:new('fps', 10, 0)
  memGraph = debugGraph:new('mem', 10, 30)
  font = love.graphics.newFont(8)

  GameState.registerEvents()
  GameState.switch(game)
end

function love.update(dt)
  fpsGraph:update(dt)
  memGraph:update(dt)
end

function love.draw()
  --love.graphics.scale(2, 2)
end

function love.keypressed(key)
  if key == 'escape' then
    love.event.quit()
  end
  if key == '1' then
    GameState.switch(mainmenu)
  end
  if key == '2' then
    GameState.switch(game)
  end
end
