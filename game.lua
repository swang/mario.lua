package.path =  "../?.lua;" .. package.path

require "constants"

Game = {}

function Game.is_button_a_pressed()
  return bit.band(memory.readbyte(0x000A), BUTTON.A) ~= 0
end

function Game.is_button_b_pressed()
  return bit.band(memory.readbyte(0x000A), BUTTON.B) ~= 0
end

function Game.is_button_pressed(button)
  if button ~= BUTTON.A and button ~= BUTTON.B and button ~= BUTTON.UP and button ~= BUTTON.DOWN then
    return nil
  end
  return bit.band(memory.readbyte(0x000A), button) ~= 0
end

function Game.ram2pixel(coord)
  local screenpos = memory.readbyte(0x071a) * 0x100 + memory.readbyte(0x071c)
  coord = coord - 0x500
  if coord < 0 or coord >= 0x1A0 then
    return false
  end

  local px = (math.fmod(coord, 0x10) + math.floor(coord / 0xD0) * 0x10) * 0x10
  px = px - math.fmod(screenpos, 0x200);
  if px < 0 then
    px = px + 0x200
  end

  local py  = math.floor(math.fmod(coord, 0xD0) / 0x10)
  return {x = px, y = py}
end
