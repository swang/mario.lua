package.path =  "../?.lua;" .. package.path

require "../world"

while(true) do
  World.set_time(999)
  FCEU.frameadvance()
end
