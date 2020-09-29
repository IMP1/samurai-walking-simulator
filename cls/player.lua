local Vector = require 'lib.vector2'

local player = {}
player.__index = player

player.SIZE = Vector.new(64, 128)
player.FOOT = Vector.new(-player.SIZE.x / 2, -player.SIZE.y / 2)
player.WEIGHT_RADIUS = 64
player.SAFE_WEIGHT_RADIUS = 32

function player.new(position)
    local self = {}
    setmetatable(self, player)

    self.position = position
    self.centre_of_mass = Vector.new(0, 0)
    self.combat_ready = false

    return self
end

function player:update(dt)
    if self.centre_of_mass:magnitudeSquared() > player.WEIGHT_RADIUS ^ 2 then
        self.centre_of_mass = self.centre_of_mass:normalise() * player.WEIGHT_RADIUS
    end
end

function player:draw()
    love.graphics.setColor(1, 1, 1)
    if self.combat_ready then
        love.graphics.setColor(1, 0.2, 0.2)
    end
    local x, y = unpack(self.position.data)
    love.graphics.circle("line", x, y, 1)
    love.graphics.circle("line", x, y, player.WEIGHT_RADIUS)
    love.graphics.circle("line", x, y, player.SAFE_WEIGHT_RADIUS)
    local x, y = unpack((self.position + player.FOOT).data)
    love.graphics.rectangle("line", x, y, player.SIZE.x, player.SIZE.y)
    local mass = self.position + self.centre_of_mass
    local mx, my = unpack(mass.data)
    love.graphics.circle("line", mx, my, 8)
end

return player
