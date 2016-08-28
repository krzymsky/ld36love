globals = {
  screen_width = love.graphics.getWidth(),
  screen_height = love.graphics.getHeight(),
  width = 640,
  height = 320,
  block_size = 64,

  signals = {
    game_over = 'game_over',
    draw = 'draw',
    update = 'update',
    mouse_update = 'mouse_update',
    blocks_shift = 'blocks_shift',
    after_blocks_shift = 'after_blocks_shift'
  }
}
