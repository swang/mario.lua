package.path =  "../?.lua;" .. package.path

require "constants"

Mario = {}

function Mario:score()
  -- return memory.readbyterange(0x07dd, 7)
  return table.concat({
      memory.readbyte(0x07dd)
    , memory.readbyte(0x07de)
    , memory.readbyte(0x07df)
    , memory.readbyte(0x07e0)
    , memory.readbyte(0x07e1)
    , memory.readbyte(0x07e2)
    , memory.readbyte(0x07e3)
  })
end

function Mario.is_ducking()
  return memory.readbyte(0x0714) == 0x04
end

function Mario.state()
  return memory.readbyte(0x0754)
end

function Mario.is_big()
  return memory.readbyte(0x0754) == 0
end

function Mario.is_small()
  return memory.readbyte(0x0754) == 1
end

function Mario.set_big()
  memory.writebyte(0x0754, 0)
end

function Mario.set_small()
  memory.writebyte(0x0754, 1)
end

function Mario.is_facing_left()
  return memory.readbyte(0x0003) == Direction.LEFT
end

function Mario.is_facing_right()
  return memory.readbyte(0x0003) == Direction.RIGHT
end

function Mario.set_state(st)
  st = st or 1
  memory.writebyte(0x0754, st)
end

function Mario:power_up_state()
  return memory.readbyte(0x0756)
end

function Mario.set_vertical_velocity(speed)
  memory.writebyte(0x009F, speed)
end

function Mario.get_vertical_velocity()
  return memory.readbyte(0x009F)
end

function Mario.face_left()
  memory.writebyte(0x0033, 02)
end

function Mario.face_right()
  memory.writebyte(0x0033, 01)
end

function Mario.in_position(x, y)
  pos = Mario.get_position()
  return pos.x1 <= x and pos.x2 >= x and pos.y1 <= y and pos.y2 >= y
end

function Mario.get_position()
  return {
    x1 = memory.readbyte(0x4ac),
    y1 = memory.readbyte(0x4ad),
    x2 = memory.readbyte(0x4ae),
    y2 = memory.readbyte(0x4af)
  }
end

function Mario.set_position(x, y)
  -- 0x071A -- first screen number
  -- 0x071B -- second screen number

  -- 0x071C -- offset of left most location on the screen
  -- 0x03AD -- offset of amount moved past 0x071C
  -- 0x0086 -- the sum of 0x071C + 0x03AD
  -- 0x006D -- either the value at 0x071A or 0x071B
            -- left hand side of the screen probably is 0x071A
            -- right hand side of the screen probably is 0x071B

  if (x ~= nil) then
    current_offset = memory.readbyte(0x071C)
    current_screen = memory.readbyte(0x006D)
    first_screen = memory.readbyte(0x071A) -- current screen number
    new_cursor_pos = tonumber(x) - 10 + current_offset

    -- do current_screen <= first_screen rather than current_screen = first_screen
    -- this prevents warping where current_screen (0x006D)  becomes bigger)

    if (new_cursor_pos >= 0xFF and current_screen <= first_screen) then
      memory.writebyte(0x0086, (new_cursor_pos % 0xFF) + 1)
      memory.writebyte(0x006D, current_screen + math.floor(new_cursor_pos / 0xFF))
    else
      memory.writebyte(0x0086, new_cursor_pos % 0xFF)
    end
  end

  if (y ~= nil) then
    -- y position
    memory.writebyte(0x00CE, math.max(2, tonumber(y) - 31))
  end

end
