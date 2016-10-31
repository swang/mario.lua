require "constants"

World = {}

function World.get_num_enemies()
  return tonumber(memory.readbyte(0x000F)) +
    tonumber(memory.readbyte(0x0010)) +
    tonumber(memory.readbyte(0x0011)) +
    tonumber(memory.readbyte(0x0012)) +
    tonumber(memory.readbyte(0x0013))
end

function World.powerup_available()
  -- No = 0x00, Yes = 0x2E
  return memory.readbyte(0x001B) == 0x2E
end

function World.powerup_type()
  -- location in memory of what powerup type it is
  -- because mushroom is 0, and it defaults to 0
  -- you also have to check to see if there is a powerup
  -- on the screen
  local byte = memory.readbyte(0x0039)
  if World.powerup_available() then
    for k, v in pairs(POWERUP) do
      if v == byte then
        return k
      end
    end
  end
  return ""
end

-- 0 enables swimming, 1 disables swimming
function World.can_swim()
  return (memory.readbyte(0x0773) == 0x00)
end

function World.disable_swimming()
  memory.writebyte(0x0704, 0x01)
end

function World.enable_swimming()
  memory.writebyte(0x0704, 0x00)
end

function World.set_bubbles(state)
  if (state) then
    memory.writebyte(0x074e, 0x00)
  else
    memory.writebyte(0x074e, 0x01)
  end
end

function World.get_level_palette()
  return tonumber(memory.readbyte(0x0773)) or 0
end

function World.set_level_palette(level)
  if (type(level) == "string") then
    for k, v in pairs(LEVEL_PALETTE) do
      if k == level then
        memory.writebyte(0x0773, v)
      end
    end
  else
    memory.writebyte(0x0773, level)
  end
end

function World.noir(state)
  memory.writebyte(0x0779, state and 0x1F or 0x1E)
end

function World.get_time()
  return memory.readbyte(0x07F8) * 100 + memory.readbyte(0x07F9) * 10 + memory.readbyte(0x07FA)
end

function World.set_time(number)
  local number_str = string.format("%03d", number)

  memory.writebyte(0x07F8, string.sub(number_str, 1, 1))
  memory.writebyte(0x07F9, string.sub(number_str, 2, 2))
  memory.writebyte(0x07FA, string.sub(number_str, 3, 3))
end

function World.get_enemy_positions()
  -- $04b0-$04c7
  return {
    [0] = {
      x1 = memory.readbyte(0x04b0),
      y1 = memory.readbyte(0x04b1),
      x2 = memory.readbyte(0x04b2),
      y2 = memory.readbyte(0x04b3)
    },
    {
      x1 = memory.readbyte(0x04b4),
      y1 = memory.readbyte(0x04b5),
      x2 = memory.readbyte(0x04b6),
      y2 = memory.readbyte(0x04b7)
    },
    {
      x1 = memory.readbyte(0x04b8),
      y1 = memory.readbyte(0x04b9),
      x2 = memory.readbyte(0x04ba),
      y2 = memory.readbyte(0x04bb)
    },
    {
      x1 = memory.readbyte(0x04bc),
      y1 = memory.readbyte(0x04bd),
      x2 = memory.readbyte(0x04be),
      y2 = memory.readbyte(0x04bf)
    },
    {
      x1 = memory.readbyte(0x04c0),
      y1 = memory.readbyte(0x04c1),
      x2 = memory.readbyte(0x04c2),
      y2 = memory.readbyte(0x04c3)
    }
  }
end
