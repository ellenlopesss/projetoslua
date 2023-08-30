local scriptPlayer = require ("Player")
local perspective = require ("perspective")
local physics = require ("physics")

physics.start ()
physics.setGravity (0, 9.8)
physics.setDrawMode ("normal")

-- Cria a camera
local camera = perspective.createView()
camera:prependLayer () -- prepara os layers da camera.

display.setStatusBar (display.HiddenStatusBar)

local bg = display.newImageRect ("imagens/bg.png", 1080*0.4, 1920*0.4)
bg.x = display.contentCenterX 
bg.y = display.contentCenterY
camera:add (bg, 8)

local plataforma1 = display.newImageRect ("imagens/plataforma.png", 310*0.3, 162*0.3)
plataforma1.x = 80
plataforma1.y = 400
physics.addBody (plataforma1, "static")
camera:add (plataforma1, 1)

local plataforma2 = display.newImageRect ("imagens/plataforma.png", 310*0.3, 162*0.3)
plataforma2.x = 180 
plataforma2.y = 350
physics.addBody (plataforma2, "static")
camera:add (plataforma2, 1)

local plataforma3 = display.newImageRect ("imagens/plataforma.png", 310*0.3, 162*0.3)
plataforma3.x = 280
plataforma3.y = 320
physics.addBody (plataforma3, "static")
camera:add (plataforma3, 1)

local plataforma4 = display.newImageRect ("imagens/plataforma.png", 310*0.3, 162*0.3)
plataforma4.x = 200
plataforma4.y = 170
physics.addBody (plataforma4, "static")
camera:add (plataforma4, 1)

local plataforma5 = display.newImageRect ("imagens/plataforma.png", 310*0.3, 162*0.3)
plataforma5.x = 120
plataforma5.y = 150
physics.addBody (plataforma5, "static")
camera:add (plataforma5, 1)

local plataforma6 = display.newImageRect ("imagens/plataforma.png", 310*0.3, 162*0.3)
plataforma6.x = 30
plataforma6.y = 100
physics.addBody (plataforma6, "static")
camera:add (plataforma6, 1)

local chao = display.newImageRect ("imagens/chao.png", 4503*0.15, 613*0.15)
chao.x = display.contentCenterX
chao.y = 490
physics.addBody (chao, "static")
camera:add (chao, 1)

for i = 0, 4 do
    local chuva1 = display.newImageRect ("imagens/chuva.png", 1080*0.4, 1920*0.4)
    chuva1.x = 128*i 
    chuva1.y = math.random (-100, 100)
    chuva1.alpha = 0.8
    camera:add (chuva1, 7)
end

for i = 0, 3 do
    local chuva2 = display.newImageRect ("imagens/chuva.png", 1080*0.4, 1920*0.4)
    chuva2.x = 128*i 
    chuva2.y = math.random (-250, 250)
    chuva2.alpha = 0.7
    camera:add (chuva2, 6)
end

for i = 0, 6 do
    local chuva3 = display.newImageRect ("imagens/chuva.png", 1080*0.4, 1920*0.4)
    chuva3.x = 140 
    chuva3.y = -256 + (128*i)
    camera:add (chuva3, 6)
end

for i = 0, 4 do
    local chuva4 = display.newImageRect ("imagens/chuva.png", 1080*0.4, 1920*0.4)
    chuva4.x = 250 
    chuva4.y = -256 + (chuva4.width*i)
    camera:add (chuva4, 4)
end

local player = scriptPlayer.novo (240, 0)
player.x = 30
player.y = 100
camera:add (player, 1)

-- Efeito Parallax trás a ilusão de profundidade ao jogo.
-- As posições das vírgulas representam os números dos layers
          -- layer (1,  2,   3,   4,   5,   6,   7,  8)
camera:setParallax (1, 0.9, 0.8, 0.7, 0.6, 0.5, 0.1, 0)

camera.damping = 10 -- Controla a fluidez da camera ao seguir o player.
camera:setFocus (player) -- Define que o player é o foco da câmera.
camera:track() -- Inicia a perseguição da câmera