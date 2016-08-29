mainmenu = {}

function mainmenu:init()
end

function mainmenu:enter()
end

function mainmenu:update(dt)
end


function mainmenu:draw()
  debugDraw()
  love.graphics.setFont(resources.times_fnt)
  love.graphics.print("Hello, Motherfuckers", 100, 200)
end
