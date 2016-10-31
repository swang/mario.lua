package.path =  "../?.lua;" .. package.path

require "../world"

local enable_swim_world = true

World.set_level_palette(1)

while (true) do

  local key = input.get()

  if key["Z"] then
    enable_swim_world = not enable_swim_world --> toggle swim world
  end

  if (enable_swim_world) then
    World.set_time(999)
    World.set_bubbles(true)
    World.enable_swimming()
  else
    World.set_bubbles(false)
    World.disable_swimming()
  end

  FCEU.frameadvance()
end
