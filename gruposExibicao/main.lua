-- Criando grupos de exibição

local backGroup = display.newGroup () -- Back usado para plano de fundo, decorações que não terão interação com o jogo.
local mainGroup = display.newGroup () -- Usado para os objetos que terão interação dentro do jogo, grupo principal.
local uiGroup = display.newGroup () -- Utilizado para placar, vidas, texto, que ficarão na frente do jogo, porém sem interação.

-- Método embutido:
-- Inclui o objeto no grupo já na sua criação.
local bg = display.newImageRect (backGroup, "imagens/bg.jpg", 509*2, 339*2)
bg.x = display.contentCenterX
bg.y = display.contentCenterY

-- Método direto:
-- Inclui o objeto depois da sua criação.
local chao = display.newImageRect ("imagens/chao.png", 4503/5, 613/5)
chao.x = display.contentCenterX
chao.y = 430
mainGroup:insert (chao)

local sol = display.newImageRect (backGroup, "imagens/sun.png", 256/2, 256/2)
sol.x = 250
sol.y = 90

local nuvem = display.newImageRect ("imagens/cloud.png", 2360/8, 984/8)
nuvem.x = 120
nuvem.y = 85
backGroup:insert (nuvem)

local arvore1 = display.newImageRect (mainGroup, "imagens/tree.png", 1024/6, 1024/6)
arvore1.x = 70
arvore1.y = 330

local arvore2 = display.newImageRect ("imagens/tree.png", 1024/7, 1024/7)
arvore2.x = 270
arvore2.y = 340
mainGroup:insert (arvore2)

chao:toFront ()
arvore1:toFront ()