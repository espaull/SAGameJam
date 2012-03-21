require "map"
require "tile"

player = {}

function player:load(x, y)
	player.image = love.graphics.newImage("images/characters/oliver.png")
	
	player.x = x
	player.y = y
	player.width = 20
	player.height = 20
	
	player.speed = 5
end

function player:draw()
	love.graphics.draw(
	player.image,
	player.x,
	player.y,
	0, 1, 1,
	player.width / 2,
	player.height / 2)
end

function player:update(dt)
	player:handleKeys()
end

function player:getCorners(x, y)
	player.upY = math.ceil((y - (player.height / 2)) / tile.height)
	player.bottomY = math.ceil((y + (player.height / 2)) / tile.height)
	player.leftX = math.ceil((x - (player.width / 2)) / tile.width)
	player.rightX = math.ceil((x + (player.width / 2)) / tile.width)
	
	player.upLeft = tile[map.level1[player.upY][player.leftX]].walkable
	player.upRight = tile[map.level1[player.upY][player.rightX]].walkable
	player.bottomLeft = tile[map.level1[player.bottomY][player.leftX]].walkable
	player.bottomRight = tile[map.level1[player.bottomY][player.rightX]].walkable
end

function player:handleKeys()
	if love.keyboard.isDown("w") then
		player:getCorners(player.x, player.y - player.speed)
		
		if player.upLeft and player.upRight then
			player.y = player.y - player.speed
		else
			player.y = (player.y / tile.height) * tile.height
		end
	end
	
	if love.keyboard.isDown("s") then
		player:getCorners(player.x, player.y + player.speed)
		
		if player.bottomLeft and player.bottomRight then
			player.y = player.y + player.speed
		else
			player.y = (player.y / tile.height) * tile.height
		end
	end
	
	if love.keyboard.isDown("a") then
		player:getCorners(player.x - player.speed, player.y)
		
		if player.upLeft and player.bottomLeft then
			player.x = player.x - player.speed
		else
			player.x = (player.x / tile.width) * tile.width
		end
	end
	
	if love.keyboard.isDown("d") then
		player:getCorners(player.x + player.speed, player.y)
		
		if player.upRight and player.bottomRight then
			player.x = player.x + player.speed
		else
			player.x = (player.x / tile.width) * tile.width
		end
	end
end