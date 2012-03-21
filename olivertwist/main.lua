require "tile"
require "map"
require "player"

function love.load()
	tile:load()
	map:load()
	player:load(60, 60)
end

function love.draw()
	map:draw()
	player:draw()
	
	--Debug info.
	love.graphics.print("FPS: "..love.timer.getFPS(), 2, 2)
	love.graphics.print("yVel: "..player.yVel, 2, 17)
	love.graphics.print("onGround: "..tostring(player.onGround), 2, 32)
end

function love.update(dt)
	player:update(dt)
end