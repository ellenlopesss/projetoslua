
local composer = require( "composer" )

local scene = composer.newScene()

local somRecordes

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

local json = require ("json") -- Chama a biblioteca json para a cena
local pontosTable = {} -- String/tabela que irá conter as pontuações guardadas.
local filePath = system.pathForFile ("pontos.json", system.DocumentsDirectory) -- Cria o arquivo pontos.json e juntamente um caminho para a pasta. (filePath == caminho do arquivo)

local function carregaPontos ()
	-- Verifica se o arquivo existe abrindo-o somente para leitura.
	local pasta = io.open (filePath, "r") -- "r" == somente leitura

	if pasta then -- Se o arquivo existir então...
		local contents = pasta:read ("*a") -- Extrai os dados do arquivo e guarda na variável contents (fomato JSON)
		io.close (pasta) -- fecha o arquivo pontos.json
		pontosTable = json.decode (contents) --Decodificar os valores da varável contents de json para Lua e armazena-los na tabela.
	end
	-- Se a tabela não exixtir ou estiver vazia (# == índice da tabela ou total de dados)
	if (pontosTable == nil or #pontosTable == 0) then
		pontosTable = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0} -- Define as pontuações iniciais.
	end
end

local function salvaPontos ()
	for i = #pontosTable, 11, -1 do -- Define que apenas 10 valores podem ser salvos na pontosTable.
		table.remove (pontosTable, i) -- remove os dados 11 acima
	end
	-- Abre o arquivo pontos.json para alterações.
	local pasta = io.open (filePath, "w") -- ("w" == acesso de gravação)

	if pasta then
		-- Inclui os dados da pontosTable no arquivo pontos.json codificada para JSON
		pasta:write (json.encode(pontosTable))
		io.close (pasta) -- Fecha o arquivo pontos.json
	end

end

local function gotoMenu ()
	composer.gotoScene ("menu", {time=800, effect="crossFade"})
end

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

	local sceneGroup = self.view
	-- O código aqui é executado quando a cena é criada pela primeira vez, mas ainda não apareceu na tela
	carregaPontos() -- Executar a função que extrai as pontuações anteriores.

	-- Acrescenta a pontuação da partida na tabela.
	table.insert (pontosTable, composer.getVariable("scoreFinal"))

	composer.setVariable ("scoreFinal", 0) -- Redefine o valor da variável.

	local function compare (a, b)
		-- Organiza os valores da tabela (pontosTable) em ordem descrescente.
		return a > b
	end

	table.sort (pontosTable, compare) -- Classifica a ordem definida na function compare para a pontosTable.

	salvaPontos() -- Salva os dados atualizados no arquivo JSON.

	local bg = display.newImageRect (sceneGroup, "imagens/bg.png", 800, 1400)
	bg.x, bg.y = display.contentCenterX, display.contentCenterY

	local cabecalho = display.newText (sceneGroup, "Recordes", display.contentCenterX, 100, native.systemFont, 80)
	cabecalho:setFillColor (0.75, 0.78, 1)
-- Cria um loop de 1 a 10
	for i = 1, 10 do
		-- Atribui os valores da pontosTable como os do loop.
		if (pontosTable[i]) then
			-- Define que o espaçamento das pontuações seja uniforme de acordo com o número.
			local yPos = 150 + (i*56)

			local ranking = display.newText (sceneGroup, i .. ")", display.contentCenterX-50, yPos, native.systemFont, 44)
			ranking:setFillColor (0.8)

			ranking.anchorX = 1 -- Alinha o texto à direita por meio da alteração da âncora.

			local finalPontos = display.newText (sceneGroup, pontosTable[i], display.contentCenterX-30, yPos, native.systemFont, 44)
			finalPontos.anchorX = 0 -- Alinha o texto à esquerda.
		end -- Fecha o if 
	end	-- Fecha o for

	local menu = display.newText (sceneGroup, "Menu", display.contentCenterX, 810, native.systemFont, 50)
	menu:setFillColor (0.75, 0.78, 1)
	menu:addEventListener ("tap", gotoMenu)

	somRecordes = audio.loadStream ("audio/Midnight-Crawlers_Looping.wav")
end


-- show()
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)

	elseif ( phase == "did" ) then
		-- Code here runs when the scene is entirely on screen
		audio.play (somRecordes, {channel=1, loops=-1})
	end
end

-- hide()
function scene:hide( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- O código aqui é executado quando a cena está na tela (mas está prestes a sair da tela)

	elseif ( phase == "did" ) then
		-- Code here runs immediately after the scene goes entirely off screen
		composer.removeScene ("recordes")
		audio.stop (1)
	end
end


-- destroy()
function scene:destroy( event )

	local sceneGroup = self.view
	-- Code here runs prior to the removal of scene's view
	audio.dispose (somRecordes)
end


-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------

return scene