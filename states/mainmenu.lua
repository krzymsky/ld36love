mainmenu = {}

function mainmenu:init()
  self.min = 1
  self.max = 22
  self.player1_x = globals.screen_width/2 - 450
  self.player1_y = 350
  self.player2_x = globals.screen_width/2 + 240
  self.player2_y = 350
  self.delta = 0
  self.timer = 0
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

  love.graphics.setColor(105, 106, 106)
  love.graphics.rectangle('fill', self.player1_x - 8, self.player1_y, 180, 180)
  love.graphics.setColor(255, 255, 255)
  love.graphics.draw(resources.slaves[globals.player1_master], self.player1_x + 85, self.player1_y + 170, 0, 5, 5, 16, 32, self.delta)

  love.graphics.setColor(105, 106, 106)
  love.graphics.rectangle('fill', self.player2_x - 8, self.player2_y, 180, 180)
  love.graphics.setColor(255, 255, 255)
  love.graphics.draw(resources.slaves[globals.player2_master], self.player2_x + 85, self.player2_y + 170, 0, 5, 5, 16, 32, -self.delta)
  debugDraw()
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
