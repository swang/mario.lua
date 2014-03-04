require "mario"
require "world"

function table.val_to_str ( v )
  if "string" == type( v ) then
    v = string.gsub( v, "\n", "\\n" )
    if string.match( string.gsub(v,"[^'\"]",""), '^"+$' ) then
      return "'" .. v .. "'"
    end
    return '"' .. string.gsub(v,'"', '\\"' ) .. '"'
  else
    return "table" == type( v ) and table.tostring( v ) or
      tostring( v )
  end
end

function table.key_to_str ( k )
  if "string" == type( k ) and string.match( k, "^[_%a][_%a%d]*$" ) then
    return k
  else
    return "[" .. table.val_to_str( k ) .. "]"
  end
end

function table.tostring( tbl )
  local result, done = {}, {}
  for k, v in ipairs( tbl ) do
    table.insert( result, table.val_to_str( v ) )
    done[ k ] = true
  end
  for k, v in pairs( tbl ) do
    if not done[ k ] then
      table.insert( result,
        table.key_to_str( k ) .. "=" .. table.val_to_str( v ) )
    end
  end
  return "{" .. table.concat( result, "," ) .. "}"
end

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

  -- gui.text(0, 20, table.val_to_str(input.read()))
  -- gui.text(0, 30, tostring(pos.x1) .. " " ..  tostring(pos.y1) .. " " ..   tostring(pos.x2).. " " .. tostring(pos.y2))  
  FCEU.frameadvance()
end
