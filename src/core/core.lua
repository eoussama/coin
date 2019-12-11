--[[

  @Author:            Eoussama
  @Version:           v0.0.1
  @Creation date:     6/12/2019 - 11:24PM

]]

local UtilLoader = require("core.utils.loader")
local UtilScene = require("core.utils.scene")
local UtilTimer = require("core.utils.timer")

local SceneTitle = require("core.scenes.title")
local SceneGame = require("core.scenes.game")
local SceneGame = require("core.scenes.game")

local core = {}

function core.init()
  UtilLoader:loadAssets()
  UtilScene:init()
end

function core.update(self, dt)
  UtilTimer:update(dt)
  UtilScene:update(dt)
end

function core.draw()
  UtilScene:draw()
end

function love.keypressed(key)
  if key == 'p' then
    global.paused = not global.paused
    print(global.paused)
  end
end

return core
