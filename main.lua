local Player = require 'cls.player'
local Vector = require 'lib.vector2'

local player
local enemy

function love.load()
    love.graphics.setBackgroundColor(0, 0.6, 0.3)
    player = Player.new(Vector.new(164, 256))
    enemy = Player.new(Vector.new(364, 256))
    player.combat_ready = true
    enemy.combat_ready = true
end

function love.keypressed(key)
    if key == "space" then
        player.combat_ready = not player.combat_ready
    end
end

function love.update(dt)
    if player.combat_ready then
        local mass_dx, mass_dy = 0, 0
        if love.keyboard.isDown("w") or love.keyboard.isDown("up") then
            mass_dy = mass_dy - 1
        end
        if love.keyboard.isDown("a") or love.keyboard.isDown("left") then
            mass_dx = mass_dx - 1
        end
        if love.keyboard.isDown("s") or love.keyboard.isDown("down") then
            mass_dy = mass_dy + 1
        end
        if love.keyboard.isDown("d") or love.keyboard.isDown("right") then
            mass_dx = mass_dx + 1
        end
        local weight_shift = Vector.new(mass_dx, mass_dy):normalise()
        player.centre_of_mass = player.centre_of_mass + weight_shift
    end
    player:update(dt)
    enemy:update(dt)
end

function love.draw()
    player:draw()
    enemy:draw()
end
