--[[

  @Author:            Eoussama
  @Version:           v0.0.1
  @Creation date:     6/12/2019 - 11:24PM

]]

local rarity = {}



--[[
  @description Calculates the rarity given a specific input
  @param {Table<Number>} rarity: The rarity table
]]
function rarity.calculate(rarity)

  -- Initializing the rarity table
  local rarityTable = {}

  -- Initializing the history object for the generated numbers
  local generatedNumbers = {}

  -- Sorting the rarity values
  table.sort(rarity)

  for i = 1, #rarity do
    local j = 1
    local rarityLevel = {
      rarity = rarity[i],
      values = {}
    }

    while j <= rarityLevel.rarity do
      local rand = math.random(1, 100)

      if true then
        table.insert(generatedNumbers, rand)
        rarityLevel.values[j] = rand
        j = j + 1
      end
    end

    table.insert(rarityTable, rarityLevel)
  end

  print('\n-----\n')
  for i = 1, #rarityTable do
    print(rarityTable[i].rarity, table.concat(rarityTable[i].values, ' - '))
  end
  print('Count: ', #generatedNumbers)

  return rarityTable
end



return rarity
