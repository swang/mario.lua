require 'mario'
require 'game'
require 'world'



local last_veloc = 0x00;
local highest = 0;
local veloc;
local jumped_flag = false
while (true) do
  World.set_time(999)

  veloc = Mario.get_vertical_velocity()
  if not Game.is_button_pressed(BUTTON.A) then
    jumped_flag = false
  end

  if not jumped_flag and Game.is_button_pressed(BUTTON.A) then
    -- if veloc == 0x00 and last_veloc >= 0xF0 and last_veloc <= 0xFF then
    if (not jumped_flag and not (veloc >= 0x00 and veloc <= 0x05)) then
      Mario.set_vertical_velocity(0xF8)
      jumped_flag = true
    else
      Mario.set_vertical_velocity(veloc)
    end
  elseif jumped_flag and veloc == 0xF8 then
    jumped_flag = false
    --if veloc > 0xff then
    --end
  
  end

  if veloc > highest then
    highest = veloc
  end
  
  -- gui.text(0, 80, table.val_to_str(input.read()) .. " " .. highest .. " ".. Mario.get_vertical_velocity() )
  -- gui.text(0, 80, tostring(jumped_flag) .. " ".. veloc)
  last_veloc = veloc
  FCEU.frameadvance()
end