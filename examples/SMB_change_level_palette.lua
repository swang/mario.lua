package.path =  "../?.lua;" .. package.path
require "../world"

local current_world = 0x00 -- LEVEL_PALETTE.NORMAL

while (true) do
  key = input.get()
  reset = false

  if key["T"] then
     current_world = LEVEL_PALETTE.NORMAL
     reset = true
  end

  if key["Y"] then
     current_world = LEVEL_PALETTE.UNDERWATER
     reset = true
  end

  if key["U"] then
    current_world = LEVEL_PALETTE.NIGHT
    reset = true
  end

  if key["H"] then
     current_world = LEVEL_PALETTE.UNDERGROUND
     reset = true
  end

  if key["J"] then
     current_world = LEVEL_PALETTE.CASTLE
     reset = true
  end

  if (reset and tonumber(World.get_level_palette()) ~= tonumber(current_world)) then
    World.set_level_palette(current_world)
    -- print("changed", reset, World.get_level_palette(), current_world)
    reset = false
  end

  FCEU.frameadvance()
end
