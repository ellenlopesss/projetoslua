local physics = require ("physics")
physics.start ()
physics.setGravity (0, 1)
physics.setDrawMode ("normal")

display.setStatusBar (display.HiddenStatusBar)

local joint

local bodies = {} -- String/tabela para armazenamento dos corpos.
local bodiesGroup = display.newGroup ()
local joints = {} -- String/tabela para armazenamento das juntas.


local cima = display.newRect (display.contentCenterX, 5, 500, 10)
physics.addBody (cima, "static")
cima.myName = "Teto"

local baixo = display.newRect (display.contentCenterX, 475, 500, 10)
physics.addBody (baixo, "static")
baixo.myName = "Chão"

-- local esquerda = display.newRect (-15, display.contentCenterY, 10, 500)
-- physics.addBody (esquerda, "static")
-- esquerda.myName = "Parede esquerda"

-- local direita = display.newRect (335, display.contentCenterY, 10, 500)
-- physics.addBody (direita, "static")
-- direita.myName = "Parede direita"

-- Junta do pistão
local staticBox = display.newRect (0, 0, 20, 20)
staticBox:setFillColor (1, 0.2, 1)
physics.addBody (staticBox, "static", {isSensor=true})
staticBox.x, staticBox.y = 320, display.contentCenterY

local shape = display.newRect (0, 0, 10, 100)
shape:setFillColor (1, 1, 0.4)
physics.addBody (shape, "dynamic", {bounce=1.2})
shape.x, shape.y = 20, display.contentCenterX
shape.myName = "Barreira"

-- Criação da junta de pistão ("tipo de junta", objA, objB, ancoraX, ancoraY, limite de movimentaçãoX, limite de movimentaçãoY)
local jointPiston = physics.newJoint ("piston", staticBox, shape, 20, staticBox.y, 0, 0)

jointPiston.isMotorEnabled = true -- Habilita o motor da junta
jointPiston.motorSpeed = 50 -- Define a velocidade do motor (valor negativo faz a movimentação inversa)
jointPiston.maxMotorForce = 100 -- Define o valor máximo da força do motor
jointPiston.isLimitEnabled = true -- Define que a junta possui limites de movimentação
jointPiston:setLimits (-140, 0) -- O primeiro valor (-140) tem que ser menor ou igual ao segundo (0)

local botaoTiro = display.newImageRect ("imagens/tiro.png", 536/10, 466/10)
botaoTiro.x = display.contentCenterX
botaoTiro.y = 440

local function atirar ()
    local jogarBola = display.newImageRect ("imagens/bola.png", 500*0.07, 500*0.07)
    jogarBola.x = staticBox.x -20
    jogarBola.y = staticBox.y -10
    physics.addBody (jogarBola, "dynamic", {isSensor=true}) 
    transition.to (jogarBola, {x=-200, y=200, time=1100, 
                    onComplete = function ()                
                    display.remove (jogarBola)
                    end})
    jogarBola.myName = "Bola"
end

botaoTiro:addEventListener ("tap", atirar)


















-- local function onCollision (event)
--     if (event.phase == "began") then
--         local obj1 = event.object1
--         local obj2 = event.object2

--         if ((obj1.myName == "Bola" and obj2.myName == "Barreira")) then
--         display.remove (obj1)
--         end 
--     end 
-- end 

-- Runtime:addEventListener ("collision", onCollision)