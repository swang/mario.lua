package.path =  "../?.lua;" .. package.path

require "../mario"
require "../world"

local mouse

clicked = false

while(true) do

  World.set_time(999)

  pos = Mario.get_position()
  gui.drawbox(pos.x1, pos.y1, pos.x2, pos.y2, nil, 'blue')

  mouse = input.get()

  if mouse.leftclick then
    if Mario.in_position(mouse.xmouse, mouse.ymouse) then
      clicked = true
    end

    if clicked then
      Mario.set_position(mouse.xmouse, mouse.ymouse)
    end
  else
    clicked = false
  end

  FCEU.frameadvance()
end
