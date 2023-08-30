-- Chamar a biblioteca de fisica
local physics = require ("physics")
-- Iniciar o motor de física
physics.start ()
-- Definir a gravidade.
physics.setGravity (0, 0)
-- Definir o modo de renderização
physics.setDrawMode ("normal") -- normal, hybrid, debug

-- Remover a barra de notificações.
display.setStatusBar (display.HiddenStatusBar)

-- Criar os grupos de exibição.
local grupoBg = display.newGroup () -- Objetos decorativos, cenário (não tem interação)
local grupoMain = display.newGroup () -- Bloco principal (tudo que precisar interagir com o player fica nesse grupo)
local grupoUI = display.newGroup () -- Interface do usuário (placares, botões...)

-- Criar variáveis de pontos e vidas para atribuição de valor.
local pontos = 0
local vidas = 5

-- Adicionar o background
-- Para adicionar a imagem: (grupo, "nome da pasta/nome do arquivo.formato do arquivo", largura, altura)
local bg = display.newImageRect (grupoBg, "imagens/background.jpg", 745*0.5, 1080*0.5)
-- localização da imagem
bg.x = display.contentCenterX -- localização horizontal
bg.y = display.contentCenterY -- localização vertical

-- Adicionar placar na tela.
-- Criar uma variável para poder atribuir o valor do objeto/texto (grupo, "escreve o que irá aparecer na tela" .. localizaçãoX, localizaçãoY, fonte, tamanho da fonte)
local pontosText = display.newText (grupoUI, "Pontos: " .. pontos, 100, 25, native.systemFont, 15)
-- Altera a cor da variável
pontosText:setFillColor (0, 0, 0)

local vidasText = display.newText (grupoUI, "Vidas: " .. vidas, 230, 25, native.systemFont, 15)
vidasText:setFillColor (0, 0, 0)

-- Adicionar herói
local player = display.newImageRect (grupoMain, "imagens/donkeykong.png", 470*0.2, 531*0.2)
player.x = 30
player.y = 380
player.myName = "Donkey Kong"
-- Adicionar corpo físico a imagem.
physics.addBody (player, "kinematic") --> Kinematic (tipo de corpo) (ele colidi só com o dinâmico e não tem interferência da gravidade) é que faz o objeto interagir

-- Criar botões:
local botaoCima = display.newImageRect ("imagens/button.png", 1280/35, 1279/35)
botaoCima.x = 215
botaoCima.y = 450
botaoCima.rotation = 270 -- faz a rotação da imagem em x graus.

local botaoBaixo = display.newImageRect ("imagens/button.png", 1280/35, 1279/35)
botaoBaixo.x = 105
botaoBaixo.y = 450
botaoBaixo.rotation = 90

-- Adicionar funções de movimentação:
local function cima ()
    player.y = player.y -10
end

local function baixo ()
    player.y = player.y +10
end

-- Adicionar o ouvinte e a função ao botão.
botaoCima:addEventListener ("tap", cima)
botaoBaixo:addEventListener ("tap", baixo)

-- Adicionar botão de tiro:
local botaoTiro = display.newImageRect (grupoMain, "imagens/tiro.png", 536/8, 466/8)
botaoTiro.x = display.contentCenterX
botaoTiro.y = 450

-- Função para atirar:
local function atirar ()
    -- Toda vez que a função for executada cria-se um novo "tiro"
    local barrilPlayer = display.newImageRect (grupoMain, "imagens/barril.png", 500*0.1, 500*0.1)
    -- a localização do "tiro" é a mesma do player
    barrilPlayer.x = player.x +20
    barrilPlayer.y = player.y
    barrilPlayer.rotation = 45
    physics.addBody (barrilPlayer, "dynamic", {isSensor=true}) -- determinamos que o projétil é um sensor, o que ativa a detecção contínua de colisão.
    -- Transição do projétil para linha x=500 em 900 milisegundos
    transition.to (barrilPlayer, {x=500, time=1100, 
    -- Quando a transição for completa
                    onComplete = function () 
    -- Removemos o projétil do display.                  
                    display.remove (barrilPlayer)
                    end})
    barrilPlayer.myName = "Jogar o barril"
    -- barrilPlayer:toBack () -- Joga o elemento pra trás dentro do grupo de exibição dele.
end

botaoTiro:addEventListener ("tap", atirar)

-- Adicionando o inimigo:
local inimigo = display.newImageRect (grupoMain, "imagens/kritter.png", 462*0.2, 460*0.2)
inimigo.x = 250
inimigo.y = 400
inimigo.myName = "Kritter"
physics.addBody (inimigo, "kinematic")
local direcaoInimigo = "cima"

-- Função para o inimigo atirar:
local function inimigoAtirar ()
    local tiroInimigo = display.newImageRect (grupoMain, "imagens/boladeferro.png", 494*0.07, 505*0.07)
    tiroInimigo.x = inimigo.x -20
    tiroInimigo.y = inimigo.y
    tiroInimigo.rotation = 180
    physics.addBody (tiroInimigo, "dynamic", {isSensor=true})
    transition.to (tiroInimigo, {x=-200, time=900,
                    onComplete = function () 
                        display.remove (tiroInimigo)
                    end})
    tiroInimigo.myName = "Jogar a Bola"
end

-- Criando o timer de disparo do inimigo:
-- Comandos timer: (tempo repetição, quantidade de repetições)
inimigo.timer = timer.performWithDelay (math.random (1000, 1500), inimigoAtirar, 0)

-- Movimentação do inimigo:
local function movimentarInimigo ()
-- se a localização x não for igual a nulo então
    if not (inimigo.x == nil) then
-- Quando a direção do inimigo for "cima" então
        if (direcaoInimigo == "cima") then
            inimigo.y = inimigo.y - 1
-- Se a localização y do inimigo for menor ou igual a 50 então
            if (inimigo.y <= 50) then
            -- altera a variável para "baixo"
                direcaoInimigo = "baixo"
            end -- if (inimigo.y.....)
-- Se a direção do inimigo for igual a "baixo" então
        elseif (direcaoInimigo == "baixo") then
            inimigo.y = inimigo.y + 1
-- Se a localização y do inimigo for maior ou igual a 400 então
            if (inimigo.y >= 400) then
                direcaoInimigo = "cima"
            end -- if (inimigo.y ....)
        end -- if (direaoInimigo....)
-- Se não
    else
        print ("Inimigo morreu!")
-- Runtime: representa todo o jogo (evento é executado para todos), enterframe: está ligado ao valor de FPS do jogo (frames por segundo), no caso, a função vai ser executada 60 vezes por segundo.
        Runtime:removeEventListener ("enterFrame", movimentarInimigo)
    end
end

Runtime:addEventListener ("enterFrame", movimentarInimigo)

-- Função de colisão:
local function onCollision (event)
    -- Quando a fase de vento for began então
        if (event.phase == "began") then
    -- Variáveis criadas para facilitar a escrita do código.
            local obj1 = event.object1
            local obj2 = event.object2
    -- Quando o myName do objeto 1 for ... e o myName do objeto 2 for ... vai acontecer determinada situação.
            if ((obj1.myName == "Jogar o barril" --[[projétil player]] and obj2.myName == "Kritter" --[[inimigo]]) or (obj1.myName == "Kritter" --[[inimigo]] and obj2.myName == "Jogar o barril" --[[projétil player]])) then
            -- Se o obj1 for .. then
                if (obj1.myName == "Jogar o barril") then
            -- Remove o projétil do jogo.
                    display.remove (obj1)
                else 
                    display.remove (obj2)
                end
    -- Somar 10 pontos a cada colisão.
                pontos = pontos + 10
    -- Atualizo os pontos na tela.
             pontosText.text = "Pontos: " .. pontos
    -- Se o ojt1 for o player e o 2 for o projétil do inimigo ou vice versa, então vai acontecer determinada situação.
            elseif ((obj1.myName == "Donkey Kong" --[[player]] and obj2.myName == "Jogar a Bola" --[[projétil inimigo]]) or (obj1.myName == "Jogar a Bola" --[[projétil inimigo]] and obj2.myName == "Donkey Kong" --[[player]])) then
                if (obj1.myName == "Jogar a Bola") then
                    display.remove (obj1)
                else
                    display.remove (obj2)
                end
    -- Reduz uma vida do player a cada colisão
            vidas = vidas - 1
            vidasText.text = "Vidas: " .. vidas
            end -- fecha o if myName
        end -- fecha o if event.phase
    end -- fecha a function
    
    Runtime:addEventListener ("collision", onCollision)
    
    
    -- if (pontos >= 200) then vidas = vidas + 1





    local function movimentarInimigo ()
        if not (inimigo.y == nil) then
            if (direcaoInimigo == "esquerda") then
                inimigo.x = inimigo.x - 1
                if (inimigo.x <= 50) then
                    direcaoInimigo = "direita"
                end 
            elseif (direcaoInimigo == "direita") then
                inimigo.x = inimigo.x + 1
                if (inimigo.x >= 300) then
                    direcaoInimigo = "esquerda"
                end 
            end 
        else
            print ("Inimigo morreu!")
            Runtime:removeEventListener ("enterFrame", movimentarInimigo)
        end
    end