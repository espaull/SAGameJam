require "map"
require "tile"

player = {}

function player:load(x, y)
	player.image = love.graphics.newImage("images/characters/oliver.png")
	
	player.x = x
	player.y = y
	player.width = 20
	player.height = 20
	
	player.xSpawn = 50
	player.ySpawn = 600
	
	player.speed = 3
	
	player.yVel = 0
	player.jumpSpeed = -14
	player.gravity = 1
	
	player.onGround = false
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
	player:applyGravity()
	player:checkFalling()
end

function player:getCorners(x, y)
	player.upY = math.ceil((y - (player.height / 2)) / tile.height)
	player.bottomY = math.ceil((y + (player.height / 2)) / tile.height)
	player.leftX = math.ceil((x - (player.width / 2)) / tile.width)
	player.rightX = math.ceil((x + (player.width / 2)) / tile.width)
	
	if tile[map.level1[player.upY][player.leftX]] ~= nil then
		player.upLeft = tile[map.level1[player.upY][player.leftX]].walkable
	else
		player.upLeft = false --We're out of bounds.
	end
	
	if tile[map.level1[player.upY][player.rightX]] ~= nil then
		player.upRight = tile[map.level1[player.upY][player.rightX]].walkable
	else
		player.upRight = false
	end
	
	if tile[map.level1[player.bottomY][player.leftX]] ~= nil then
		player.bottomLeft = tile[map.level1[player.bottomY][player.leftX]].walkable
	else
		player.bottomLeft = false
	end
	
	if tile[map.level1[player.bottomY][player.rightX]] ~= nil then
		player.bottomRight = tile[map.level1[player.bottomY][player.rightX]].walkable
	else
		player.bottomRight = false
	end
	
	--FIX THIS. Going out of bounds at the top and bottom of the map still crashes the game!
end

function player:handleKeys()	
	if love.keyboard.isDown("a") then
		player:getCorners(player.x - player.speed, player.y)
		
		if player.upLeft and player.bottomLeft then
			player.x = player.x - player.speed
		else
			player.x = (player.x / tile.width) * tile.width
		end
		
		if player.x <= 0 then
			player.x = player.x + player.width / 2
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
	
	if love.keyboard.isDown(" ") then
		if player.onGround == true then
			player.yVel = player.jumpSpeed
			--player.onGround = false
		end
	end
	
	if love.keyboard.isDown("f") then
		player.x = player.xSpawn
		player.y = player.ySpawn
	end
end

function player:applyGravity()
	player.yVel = player.yVel + player.gravity
	
	if player.yVel > 10 then
		player.yVel = 10
	end
	
	if player.yVel < 0 then
		player:getCorners(player.x, player.y + player.yVel)
		
		if player.upLeft and player.upRight then
			--Whatever
		else
			player.y = math.floor(player.y / tile.height) * tile.height + player.height / 2
			player.yVel = 0
		end
	end
	
	player:getCorners(player.x, player.y + player.yVel)
	
	if player.bottomLeft and player.bottomRight then
		player.y = player.y + player.yVel
	else
		player.y = math.ceil(player.y / tile.height) * tile.height - player.height / 2
		--player.onGround = true
	end
end

function player:checkFalling()
	player:getCorners(player.x, player.y + player.speed)
	
	if player.bottomLeft and player.bottomRight then
		player.onGround = false
	else
		player.onGround = true
		player.yVel = 0
	end
end

function love.mousepressed(x, y, button)
	if button == "l" then
		player.xSpawn = x
		player.ySpawn = y
	end
end