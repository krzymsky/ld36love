mainmenu = {}

function mainmenu:init()
  self.min = 1
  self.max = 27
  self.player1_x = globals.screen_width/4 - 250
  self.player1_y = 160
  self.player2_x = globals.screen_width/4 + 120
  self.player2_y = 160
  self.delta = 0
  self.timer = 0
  self.canvas = love.graphics.newCanvas(globals.screen_width, globals.screen_height)
end

function mainmenu:enter()
end

function mainmenu:update(dt)
  self.timer = self.timer + dt
  self.delta = math.sin(love.timer.getTime() + self.timer)*0.1
end

function mainmenu:keypressed(key)
  if key == 'a' then
    globals.player1_master = self:changeMaster(globals.player1_master, -1)
  end
  if key == 'd' then
    globals.player1_master = self:changeMaster(globals.player1_master, 1)
  end

  if key == 'left' then
    globals.player2_master = self:changeMaster(globals.player2_master, -1)
  end
  if key == 'right' then
    globals.player2_master = self:changeMaster(globals.player2_master, 1)
  end
end

function mainmenu:draw()
  love.graphics.clear(143,86,59)
  love.graphics.setCanvas(self.canvas)
  love.graphics.clear()

  love.graphics.setColor(105, 106, 106)
  love.graphics.rectangle('fill', self.player1_x - 8, self.player1_y, 100, 100)
  love.graphics.setColor(255, 255, 255)
  love.graphics.draw(resources.slaves[globals.player1_master], self.player1_x + 40, self.player1_y + 90, 0, 3, 3, 16, 32, self.delta)

  love.graphics.setColor(105, 106, 106)
  love.graphics.rectangle('fill', self.player2_x - 8, self.player2_y, 100, 100)
  love.graphics.setColor(255, 255, 255)
  love.graphics.draw(resources.slaves[globals.player2_master], self.player2_x + 40, self.player2_y + 90, 0, 3, 3, 16, 32, -self.delta)

  love.graphics.draw(resources.button_a_img, self.player1_x - 55, self.player1_y + 35)
  love.graphics.draw(resources.button_d_img, self.player1_x + 100, self.player1_y + 35)
  love.graphics.draw(resources.button_s_img, self.player1_x + 25, self.player1_y + 110)

  love.graphics.draw(resources.button_left_img, self.player2_x - 55, self.player2_y + 35)
  love.graphics.draw(resources.button_right_img, self.player2_x + 100, self.player2_y + 35)
  love.graphics.draw(resources.button_down_img, self.player2_x + 25, self.player2_y + 110)

  love.graphics.draw(resources.button_enter_img, self.player1_x + 190, self.player1_y + 100)

  love.graphics.draw(resources.title_img, self.player1_x + 250, 80, self.delta*0.5, 1, 1, 128, 64)

  love.graphics.draw(resources.tutorial_img, self.player1_x + 230, 170, 0, 1, 1, 62, 25)

  love.graphics.setCanvas()
  love.graphics.draw(self.canvas, globals.screen_width, globals.screen_height, 0, 2, 2, globals.screen_width/2, globals.screen_height/2)
  --debugDraw()
end

function mainmenu:changeMaster(player, dir)
  id = player + dir
  if id > self.max then
    id = self.min
  end
  if id < self.min then
    id = self.max
  end
  return id
end
