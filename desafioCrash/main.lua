local physics = require ("physics")
physics.start ()
physics.setGravity (0, 0)
physics.setDrawMode ("normal")

display.setStatusBar (display.HiddenStatusBar)

local grupoBg = display.newGroup ()
local grupoMain = display.newGroup () 
local grupoUI = display.newGroup () 

-- Áudio fundo
local backgroundMusic
backgroundMusic = audio.loadStream ("music/musiccrash.MP3")
audio.reserveChannels (1)
audio.setVolume (0.3, { channel=1})
audio.play (backgroundMusic, {channel=1, loops=-1})

-- Áudio tiro
local audioTiro = audio.loadSound ("music/fruit.MP3")
local parametros = {time = 2000, fadein = 200}

local pontos = 0
local vidas = 10

local bg = display.newImageRect (grupoBg, "imagens/background.jpg", 1635*0.25, 2160*0.25)
bg.x = display.contentCenterX 
bg.y = display.contentCenterY 

local pontosImagem = display.newImageRect (grupoUI, "imagens/pontos.png", 624*0.1, 159*0.1)
pontosImagem.x = 60
pontosImagem.y = 25
local pontosText = display.newText (grupoUI, ": " .. pontos, 105, 24, native.systemFont, 15)
pontosText:setFillColor (0, 0, 0)

local vidasImagem = display.newImageRect (grupoUI, "imagens/vidas.png", 515*0.1, 154*0.1)
vidasImagem.x = 180
vidasImagem.y = 25
local vidasText = display.newText (grupoUI, ": " .. vidas, 215, 24, native.systemFont, 15)
vidasText:setFillColor (0, 0, 0)

local player = display.newImageRect (grupoMain, "imagens/crash.png", 479*0.2, 521*0.2)
player.x = 280
player.y = 400
player.rotation = 30
player.myName = "Crash"
physics.addBody (player, "kinematic") 

local botaoDireita = display.newImageRect ("imagens/botao.png", 1280/35, 1279/35)
botaoDireita.x = 215
botaoDireita.y = 450

local botaoEsquerda = display.newImageRect ("imagens/botao.png", 1280/35, 1279/35)
botaoEsquerda.x = 105
botaoEsquerda.y = 450
botaoEsquerda.rotation = 180

local function direita ()
    player.x = player.x +30
    player.xScale = -1
    player.rotation = -30
end

local function esquerda ()
    player.x = player.x -30
    player.xScale = 1
    player.rotation = 30
end

botaoDireita:addEventListener ("tap", direita)
botaoEsquerda:addEventListener ("tap", esquerda)

local botaoTiro = display.newImageRect (grupoMain, "imagens/tiro.png", 536/8, 466/8)
botaoTiro.x = display.contentCenterX
botaoTiro.y = 450

local function atirar ()
    local tiroPlayer = display.newImageRect (grupoMain, "imagens/fruta.png", 377*0.07, 381*0.07)
    tiroPlayer.x = player.x -20
    tiroPlayer.y = player.y -10
    physics.addBody (tiroPlayer, "dynamic", {isSensor=true}) 
    transition.to (tiroPlayer, {x=-100, y=10, time=1100, 
                    onComplete = function ()                
                    display.remove (tiroPlayer)
                    end})
    tiroPlayer.myName = "Fruta"
end

botaoTiro:addEventListener ("tap", atirar)

local inimigo = display.newImageRect (grupoMain, "imagens/cortex.png", 483*0.2, 493*0.2)
inimigo.x = 130
inimigo.y = 180
inimigo.myName = "Cortex"
physics.addBody (inimigo, "kinematic")
local direcaoInimigo = "esquerda"

local function inimigoAtirar ()
    local tiroInimigo = display.newImageRect (grupoMain, "imagens/raio.png", 499*0.08, 500*0.08)
    tiroInimigo.x = inimigo.x
    tiroInimigo.y = inimigo.y
    physics.addBody (tiroInimigo, "dynamic", {isSensor=true})
    transition.to (tiroInimigo, {x=250, y=600, time=900,
                    onComplete = function () 
                        display.remove (tiroInimigo)
                    end})
    tiroInimigo.myName = "Raio"
end

inimigo.timer = timer.performWithDelay (math.random (1000, 1500), inimigoAtirar, 0)

local function movimentarInimigo ()
        if not (inimigo.y == nil) then
            if (direcaoInimigo == "esquerda") then
                inimigo.x = inimigo.x - 1
                inimigo.y = inimigo.y + 1
                if (inimigo.x <= 20) then
                    direcaoInimigo = "direita"
                end 
            elseif (direcaoInimigo == "direita") then
                inimigo.x = inimigo.x + 1
                inimigo.y = inimigo.y - 1
                if (inimigo.x >= 260) then
                    direcaoInimigo = "esquerda"
                end 
            end 
        else
            print ("Inimigo morreu!")
            Runtime:removeEventListener ("enterFrame", movimentarInimigo)
        end
end

Runtime:addEventListener ("enterFrame", movimentarInimigo)

local function onCollision (event)
        if (event.phase == "began") then
            local obj1 = event.object1
            local obj2 = event.object2
    
            if ((obj1.myName == "Fruta" and obj2.myName == "Cortex") or (obj1.myName == "Cortex" and obj2.myName == "Fruta")) then
                if (obj1.myName == "Fruta") then
                    display.remove (obj1)
                else 
                    display.remove (obj2)
                end
                audio.play (audioTiro, parametros)
                pontos = pontos + 5
             pontosText.text = ": " .. pontos
            elseif ((obj1.myName == "Crash" and obj2.myName == "Raio") or (obj1.myName == "Raio" and obj2.myName == "Crash")) then
                if (obj1.myName == "Raio") then
                    display.remove (obj1)
                else
                    display.remove (obj2)
                end
            vidas = vidas - 1
            vidasText.text = ": " .. vidas
                if (vidas <= 0) then
                    Runtime:removeEventListener ("collision", onCollision)
                    Runtime:removeEventListener ("enterFrame", movimentarInimigo)
                    timer.pause (inimigo.timer) -- Colocar sempre o nome que foi criado o timerWithDelay
                    botaoDireita:removeEventListener ("tap", direita)
                    botaoEsquerda:removeEventListener ("tap", esquerda)
                    botaoTiro:removeEventListener ("tap", atirar)

                    local gameOver = display.newImageRect (grupoUI, "imagens/gameover.png", 1080/5, 1080/5)
                    gameOver.x = display.contentCenterX
                    gameOver.y = display.contentCenterY
                end -- fecha o if vidas
            end 
            if (pontos >= 100) then 
            vidas = vidas + 1
            end
            if (pontos >= 100) then
            pontos = 0
            end
        end 
end 
    
Runtime:addEventListener ("collision", onCollision)


-- if (vidas == 0 ) then
   -- print (puts acabaou)
-- end




