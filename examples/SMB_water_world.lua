require "world"

World.set_level_palette(1)
while (true) do
  World.set_time(999)
  World.set_bubbles(true)
  World.enable_swimming(true)
  FCEU.frameadvance()
end
