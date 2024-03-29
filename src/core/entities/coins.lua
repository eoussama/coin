--[[

  @Author:            Eoussama
  @Version:           v0.0.1
  @Creation date:     6/12/2019 - 11:24PM

]]

local UtilTimer = require("core.utils.timer")
local UtilRarity = require("core.utils.rarity")

local coins = {
  coins = {},
  definitions = {
    {
      id = 1,
      rarity = 50,
      value = 1,
      name = 'coin_1'
    },
    {
      id = 2,
      rarity = 30,
      value = 2,
      name = 'coin_2'
    },
    {
      id = 3,
      rarity = 15,
      value = 3,
      name = 'coin_3'
    },
    {
      id = 4,
      rarity = 5,
      value = 5,
      name = 'coin_5'
    },
  }
}



--[[
  @description Initializes the coins module
  @param {Table} self: The table that invokes the function call
]]
function coins.init(self)

  -- Seeding the random function
  math.randomseed(love.timer.getTime())

  -- Initializing the coins' dimentions
  self.width = global.assets.gfx.entities.coins['coin_1']:getWidth()
  self.height = global.assets.gfx.entities.coins['coin_1']:getHeight()
  self.scale = 0.6
  self.coins = {}

  -- Starting a coins timer
  UtilTimer:start("coins_timer", 1000, true, self.spawn)
end



--[[
  @description Spawns a random coin
]]
function coins.spawn()

  -- Checking if the game is not paused
  if global.paused == false then

    -- Calculating the rarity
    local input = math.random(1, 100)

    -- Getting the coin ID
    local coinId = UtilRarity.calculate(input, { { id = 1, rarity = coins.definitions[1].rarity }, { id = 2, rarity = coins.definitions[2].rarity }, { id = 3, rarity = coins.definitions[3].rarity }, { id = 4, rarity = coins.definitions[4].rarity } })

    -- Calculating a random x position
    local x = math.random(love.graphics.getWidth(), 0)

    -- Calculating a random y position
    local y = math.random(0, love.graphics.getHeight())

    -- Creating a coin
    coins:create(x, y, coinId)
  end
end



--[[
  @description Creates a new coin
  @param {Table} self: The table that invokes the function call
]]
function coins.create(self, x, y, id)

  local _id = id or 1
  local width = love.graphics.getWidth()
  local height = love.graphics.getHeight()
  local coinWidth = global.assets.gfx.entities.coins['coin_1']:getWidth()
  local coinHeight = global.assets.gfx.entities.coins['coin_1']:getHeight()

  -- Sanitizing the input values
  if x == nil then x = coinWidth end
  if x > width - coinWidth then x = width - coinWidth end
  if y == nil then y = coinHeight end
  if y < global.ui.header.height then y = global.ui.header.height + coinHeight end
  if y > height - coinHeight then y = height - coinHeight end

  -- Inserting the created coin into the coins collection
  table.insert(self.coins, { x = x, y = y, id = _id })
end



--[[
  @description Removes a coin
  @param {Table} self: The table that invokes the function call
  @param {Number} index: The index of the coin to remove
]]
function coins.remove(self, index)
  table.remove(self.coins, index)
end



--[[
  @description The coins' updating life-cycle event handler
  @param {Table} self: The table that invokes the function call
  @param {Number} dt: Delta time
]]
function coins.update(self, dt) end



--[[
  @description The coins' drawing life-cycle event handler
  @param {Table} self: The table that invokes the function call
]]
function coins.draw(self)

  -- Checking if the game is paused
  if global.paused == true then

    -- Changing the overlay color when the game is paused
    love.graphics.setColor(0.4, 0.4, 0.4)
  end

  for i = 1, #self.coins, 1 do
    local coin = self.coins[i]
    love.graphics.draw(global.assets.gfx.entities.coins[self.definitions[coin.id].name], coin.x, coin.y, 0, self.scale, self.scale)
  end
end



--[[
  @description Resets the coins' timer
]]
function coins:resetTimer()

  -- Stopping the active timers
  UtilTimer:finish("coins_timer")
end



--[[
  @description Gets the collision object for the coin entity
  @param {Table} self: The table that invokes the function call
]]
function coins.getCol(self, index)
  return {
    x = self.coins[index].x,
    y = self.coins[index].y,
    width = self.width * self.scale,
    height = self.height * self.scale
  }
end



return coins