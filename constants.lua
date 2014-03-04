function readonlytable(table)
   return setmetatable({}, {
     __index = table,
     __newindex = function(table, key, value)
                    error("Attempt to modify read-only table")
                  end,
     __metatable = false
   });
end

Direction = readonlytable {
  RIGHT = 1,
  LEFT = 2
}

-- BUTTON_A = 0x80
-- BUTTON_B = 0x40

BUTTON = readonlytable {
  A = 0x80,
  B = 0x40,
  UP = 0x80,
  DOWN = 0x40
}

POWERUP = readonlytable {
  MUSHROOM = 0,
  FLOWER = 1,
  STAR = 2,
  ONEUP = 3
}

LEVEL_PALETTE = readonlytable {
  NORMAL = 0,
  UNDERWATER = 1,
  NIGHT = 2,
  UNDERGROUND = 3,
  CASTLE = 4
}
