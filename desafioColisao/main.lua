local physics = require ("physics")
physics.start ()
physics.setGravity (2, 9.8)
physics.setDrawMode ("normal")

display.setStatusBar (display.HiddenStatusBar)

local cima = display.newRect (display.contentCenterX, 0, 500, 50)
physics.addBody (cima, "static")
cima.myName = "Teto"

local baixo = display.newRect (display.contentCenterX, 480, 500, 50)
physics.addBody (baixo, "static")
baixo.myName = "Chão"

local esquerda = display.newRect (-15, display.contentCenterY, 50, 500)
physics.addBody (esquerda, "static")
esquerda.myName = "Parede esquerda"

local direita = display.newRect (330, display.contentCenterY, 50, 500)
physics.addBody (direita, "static")
direita.myName = "Parede direita"

local martelo = display.newImageRect ("imagens/martelo.png", 523*0.2, 477*0.2)
martelo.x = 100
martelo.y = 100
physics.addBody (martelo, "dynamic", {bounce=1, friction=0, density=0.7})
martelo.myName = "Martelo"

local quadrado = display.newRect (50, 300, 70, 70)
quadrado:setFillColor (1, 0, 0.3)
quadrado.x = display.contentCenterX
quadrado.y = display.contentCenterY
physics.addBody (quadrado, "static", {bounce=1, friction=0, density=0.5})
quadrado.myName = "Quadrado"

local function colisaoLocal (event)
    if (event.phase == "began") then
        quadrado:setFillColor (0, 0, 1)
    else
        print ("Fim da colisão")
    end
end
quadrado:addEventListener ("collision", colisaoLocal)

local function colisaoLocal (event)
    if (event.phase == "began") then
        cima:setFillColor (0.4, 1, 0.1)
    else
        print ("Fim da colisão")
    end
end
cima:addEventListener ("collision", colisaoLocal)

local function colisaoLocal (event)
    if (event.phase == "began") then
        baixo:setFillColor (0.4, 1, 0.1)
    else
        print ("Fim da colisão")
    end
end
baixo:addEventListener ("collision", colisaoLocal)

local function colisaoLocal (event)
    if (event.phase == "began") then
        esquerda:setFillColor (0.4, 1, 0.1)
    else
        print ("Fim da colisão")
    end
end
esquerda:addEventListener ("collision", colisaoLocal)

local function colisaoLocal (event)
    if (event.phase == "began") then
        direita:setFillColor (0.4, 1, 0.1)
    else
        print ("Fim da colisão")
    end
end
direita:addEventListener ("collision", colisaoLocal)