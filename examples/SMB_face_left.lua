package.path =  "../?.lua;" .. package.path

require "../world"
require "../mario"

while (true) do
  Mario.face_left()

  FCEU.frameadvance()
end
