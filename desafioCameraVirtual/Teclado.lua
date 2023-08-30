local Teclado = {} -- ARmazena todos os dados do script

function Teclado.novo (player)

    local function verificarTecla (event)
        -- se a fase de evento for down (tecla pressionada) então vaos verificar 
        if event.phase == "down" then
            -- se a tecla pressionada for o "d" então
            if event.keyName == "d" then
                player.direcao = "direita"
                player:setSequence ("correndo")
                player:play()
                player.xScale = 1
            -- se a tecla pressionada for o "a" então
            elseif event.keyName == "a" then
                player.direcao = "esquerda"
                player:setSequence ("correndo")
                player:play()
                player.xScale = -1
            -- se a tecla pressionada for o "espaço" então
            elseif event.keyName == "space" then
                player.numeroPulo = player.numeroPulo + 1
                -- se numeroPulo for igual 1 então
                    if player.numeroPulo == 1 then
                        -- é aplicado impulso
                        player:applyLinearImpulse (0, -0.4, player.x, player.y)
                    -- se o numeroPulo for igual a 2 então
                    elseif player.numeroPulo == 2 then
                        -- aplica transição para o player gire 360 graus em torno do próprio eixo.
                        transition.to (player, {rotation=player.rotation+360, time=750})
                        player:applyLinearImpulse (0, -0.4, player.x, player.y)
                    end
            end
        -- quando a fase de evento for "up" (ou seja, quando soltar a tecla) então
        elseif event.phase == "up" then
            if event.keyName == "d" then
                player.direcao = "parado"
                player:setSequence ("parado")
                player:play()
            elseif event.keyName == "a" then
                player.direcao = "parado"
                player:setSequence ("parado")
                player:play()
            end
        end
    end
    -- Cria Runtime (significa que a função fica sempre rodando). "key": teclado
    Runtime:addEventListener ("key", verificarTecla)

    -- função para a movimentação
    local function verificarDirecao ()
        -- Retorna os valores de velocidade linear X e Y e armazena nas variáveis velocidadeX, velocidadeY respectivamente.
        local velocidadeX, velocidadeY = player:getLinearVelocity ()
        -- print () "Velocidade x: " .. velocidadeX .. ", velocidade Y: " .. velocidadeY
        -- Se a direção do player for direita e a velocidade x for menor ou igual a 200 then
        if player.direcao == "direita" and velocidadeX <= 200 then
            -- aplicado impulso linear para movimentação x direita.
            player:applyLinearImpulse (0.2, 0, player.x, player.y)
        elseif player.direcao == "esquerda" and velocidadeX >= -200 then
            player:applyLinearImpulse (-0.2, 0, player.x, player.y)
        end
    end
    -- "enterFrame": função executada 60 vezes por segundo
    Runtime:addEventListener ("enterFrame", verificarDirecao)
end

return Teclado -- fechar a string do teclado