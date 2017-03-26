--ayy lmoa
function love.load()
  HALF_WIDTH = love.graphics.getWidth() / 2
  HALF_HEIGHT = love.graphics.getHeight() / 2

  tiles = {}
  for i = 1, 2 do
    tiles[i] = love.graphics.newImage( "/Resources/Tiles/" .. "tiler" .. i .. ".png" )
  end

  require( "/Resources/Maps/mapOne" )


  map = {
        { 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2 },
        { 2, 1, 2, 2, 2, 2, 2, 2, 1, 2, 1, 2, 1, 1, 1, 2, 2, 2, 2, 2 },
        { 2, 1, 2, 2, 2, 2, 2, 2, 1, 2, 1, 2, 1, 2, 2, 2, 2, 2, 2, 2 },
        { 2, 1, 1, 2, 2, 2, 2, 2, 2, 1, 2, 2, 1, 1, 2, 2, 2, 2, 2, 2 },
        { 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 2, 2 },
        { 2, 1, 2, 1, 1, 1, 2, 2, 2, 2, 2, 2, 1, 1, 1, 2, 2, 2, 2, 2 },
        { 2, 1, 2, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2 },
        { 2, 1, 2, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2 },
        { 2, 1, 2, 2, 2, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2 },
        { 2, 1, 2, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2 },
        { 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2 },
        { 2, 2, 2, 2, 2, 1, 1, 1, 2, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 2 },
        { 2, 2, 2, 2, 2, 1, 2, 1, 2, 1, 2, 1, 2, 2, 2, 2, 2, 2, 2, 2 },
        { 2, 2, 2, 2, 2, 1, 2, 1, 2, 1, 2, 1, 2, 2, 2, 2, 2, 2, 2, 2 },
        { 2, 2, 2, 2, 2, 1, 1, 1, 2, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 2 },
        { 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2 },
        { 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2 },
        { 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2 },
        { 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2 },
        { 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2 },
      }

  --map = data
  --data = nil

  love.graphics.setNewFont( 12 )

  --  map params  --
  map_width = 20
  map_height = 20
  cam_map_x = map_width / 2
  cam_map_y = map_height / 2
  cam_screen_x = HALF_WIDTH
  cam_screen_y = HALF_HEIGHT
  FOV = 20

  --  tile params   --
  tile_width = 48
  tile_height = 48

  --  camera settings   --
  cam_map_dx = 0.0
  cam_map_dy = 0.0
  cam_map_ddx = 1
  cam_map_ddy = 1

  --  misc settings   --
  --love.keyboard.setKeyRepeat( enable )

end

function love.update( dt )
  checkKeyPresses( dt )

  cam_map_x = cam_map_x + cam_map_dx * dt
  cam_map_y = cam_map_y + cam_map_dy * dt

  checkCamIsInMapBounds()

end

function love.draw()
  drawMap()
  love.graphics.print("FPS: "..love.timer.getFPS(), 10, 20)

end

function checkKeyPresses( dt )
  if love.keyboard.isDown( "up" ) then
    cam_map_dy = cam_map_dy - cam_map_ddy * dt
  end
  if love.keyboard.isDown( "down" ) then
    cam_map_dy = cam_map_dy + cam_map_ddy * dt
  end
  if love.keyboard.isDown( "left" ) then
    cam_map_dx = cam_map_dx - cam_map_ddx * dt
  end
  if love.keyboard.isDown( "right" ) then
    cam_map_dx = cam_map_dx + cam_map_ddx * dt
  end
  if love.keyboard.isDown( "escape" ) then
    love.event.quit()
  end
end

--[[
function love.keypressed( key, scancode )
  if key == 'up' then
    cam_map_dy = cam_map_dy - cam_map_ddy
  end
  if key == 'down' then
    cam_map_dy = cam_map_dy + cam_map_ddy
  end
  if key == 'left' then
    cam_map_dx = cam_map_dx - cam_map_ddx
  end
  if key == 'right' then
    cam_map_dx = cam_map_dx + cam_map_ddx
  end
end
]]

function checkCamIsInMapBounds()
  --  check y lower bounds  --
  if cam_map_y < 0 then
    cam_map_y = 0
  end

  --  check y upper bounds  --
  if cam_map_y > map_height then
    cam_map_y = map_height
  end

  --  check x lower bounds  --
  if cam_map_x < 0 then
    cam_map_x = 0
  end

  --  check x upper bounds  --
  if cam_map_x > map_width then
    cam_map_x = map_width
  end
end

function drawMap()
  left_most_tile_type_x = cam_map_x - FOV
  right_most_tile_type_x = cam_map_x + FOV
  up_most_tile_type_y = cam_map_y - FOV
  down_most_tile_type_y = cam_map_y + FOV

  --  bounds checking   --
  left_most_tile_type_x = math.max( 1, left_most_tile_type_x )
  right_most_tile_type_x = math.min( right_most_tile_type_x, map_width )
  up_most_tile_type_y = math.max( 1, up_most_tile_type_y )
  down_most_tile_type_y = math.min( down_most_tile_type_y, map_height )

  for tile_map_y = up_most_tile_type_y, down_most_tile_type_y, 1 do
    for tile_map_x = left_most_tile_type_x, right_most_tile_type_x, 1 do
      tile_type = map[math.floor( tile_map_y )][math.floor( tile_map_x )]
      --tile_type = map[math.floor( tile_map_y ) * map_width + math.floor( tile_map_x ) % map_width ]

      tile_screen_x, tile_screen_y = getScreenCoordsOfTile( tile_map_x, tile_map_y )
      love.graphics.draw( tiles[tile_type], tile_screen_x, tile_screen_y )
    end
  end

end

function clamp(min, val, max)
    return math.max(min, math.min(val, max));
end

--  given coordinates of a tile relative to camera, calculate the screen coordinates  --
function getScreenCoordsOfTile( tile_map_x, tile_map_y )
  x_dif = cam_map_x - tile_map_x
  y_dif = cam_map_y - tile_map_y

  tile_screen_x = cam_screen_x - x_dif * tile_width
  tile_screen_y = cam_screen_y - y_dif * tile_height

  return tile_screen_x, tile_screen_y
end
