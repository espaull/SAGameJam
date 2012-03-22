require "tile"
require "map"
require "player"

function love.load()
	tile:load()
	map:load()
	player:load(60, 60)
	
	love.graphics.setBackgroundColor(71, 174, 255)
end

function love.draw()
	map:draw()
	player:draw()
	
	--Debug info.
	love.graphics.print("FPS: "..love.timer.getFPS(), 2, 2)
end

function love.update(dt)
	player:update(dt)
end