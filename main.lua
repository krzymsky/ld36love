local debugGraph = require 'lib.debugGraph'
local GameState = require 'lib.hump.gamestate'

resources = {
  font = love.graphics.newFont(10),
  aqueduct_block_img = love.graphics.newImage("res/aqueduct_block.png"),
  first_plan_img = love.graphics.newImage("res/first_plan.png"),
  bg_img = love.graphics.newImage("res/bg.png"),
  master_img = love.graphics.newImage("res/master.png"),
  dust_img = love.graphics.newImage("res/dust.png"),
  whip_img = love.graphics.newImage("res/Whip.png"),
  arrow_img = love.graphics.newImage("res/arrow.png"),
  bar_img = love.graphics.newImage("res/bar.png"),
  bonus_block_img = love.graphics.newImage("res/BonusBlock.png"),
  bonus_guy_img = love.graphics.newImage("res/BonusGuy.png"),
  bonus_chest_img = love.graphics.newImage("res/BonusChest.png"),
  hammer_img = love.graphics.newImage("res/hammer.png"),
  axe_img = love.graphics.newImage("res/axe.png"),
  pickaxe_img = love.graphics.newImage("res/pickaxe.png"),
  popup_img = love.graphics.newImage("res/popup.png"),

  whip_snd1 = love.audio.newSource("res/s_whip.wav", "stream"),
  whip_snd2 = love.audio.newSource("res/s_whip.wav", "stream"),
  bonus_snd = love.audio.newSource("res/s_bonus.wav"),
  work_snd = love.audio.newSource("res/s_WorkAmbience.wav"),

  times_fnt = love.graphics.newFont("res/TimesNewPixel.ttf", 200),

  slaves = {
  love.graphics.newImage("res/slave1.png"),
  love.graphics.newImage("res/slave2.png"),
  love.graphics.newImage("res/slave3.png"),
  love.graphics.newImage("res/slave4.png"),
  love.graphics.newImage("res/slave5.png"),
  love.graphics.newImage("res/slave6.png"),
  love.graphics.newImage("res/slave7.png"),
  love.graphics.newImage("res/slave8.png"),
  love.graphics.newImage("res/slave9.png"),
  love.graphics.newImage("res/slave10.png"),
  love.graphics.newImage("res/slave11.png"),
  love.graphics.newImage("res/slave12.png"),
  love.graphics.newImage("res/slave13.png"),
  love.graphics.newImage("res/slave14.png"),
  love.graphics.newImage("res/slave15.png"),
  love.graphics.newImage("res/slave16.png"),
  love.graphics.newImage("res/slave17.png"),
  love.graphics.newImage("res/slave18.png"),
  love.graphics.newImage("res/slave19.png"),
  love.graphics.newImage("res/slave20.png"),
  love.graphics.newImage("res/slave21.png"),
  }
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

  resources.whip_snd1:setVolume(0.5)
  resources.whip_snd2:setVolume(0.5)
  resources.work_snd:setVolume(0.3)

  fullscreen_mode = false
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
  if key == 'f' then
    fullscreen_mode = not fullscreen_mode
    love.window.setFullscreen(fullscreen_mode)
  end
end
