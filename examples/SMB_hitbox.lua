require "world"
require "mario"

local pos, enemy_pos

while true do

  World.set_time(999)
  pos = Mario.get_position()
  enemy_pos = World.get_enemy_positions()
  gui.drawbox(pos.x1, pos.y1, pos.x2, pos.y2, nil, 'blue')
  for i = 0, 4 do
    gui.drawbox(enemy_pos[i].x1, enemy_pos[i].y1, enemy_pos[i].x2, enemy_pos[i].y2, nil, 'red' )
  end
  FCEU.frameadvance()
end
