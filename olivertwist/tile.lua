tile = {}

function tile:load()
	tile.width = 32
	tile.height = 32
	
	for i = 0, 3 do
		tile[i] = {}
		tile[i].image = love.graphics.newImage("images/tiles/tile"..i..".png")
	end
	
	tile:setProperties()
end

function tile:setProperties()
	--Air
	tile[0].walkable = true
	
	--Rock
	tile[1].walkable = false
	
	--Dirt
	tile[2].walkable = false
	
	--Grass Top
	tile[3].walkable = false
end