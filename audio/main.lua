-- Carregando o audio de fundo (Stream indicado para audios longos)
--                               ("pasta/arquivo.formato")
local bgAudio = audio.loadStream ("Audio/audio_bg.mp3")
-- Reservando um canal de audio para o som de fundo
audio.reserveChannels (1)
-- Especificar o volume 
audio.setVolume (0.6, {channel=1})
-- Reproduzir o audio
--         (audio a reproduzir, {canal, loopins (-1 aoinfinito)})
audio.play (bgAudio, {channel=1, loops=-1})

-- AUDIO TIRO
-- loadSound é melhor utilizado com sons curtos.
local audioTiro = audio.loadSound ("Audio/tiro.wav")
-- Informações de como o áudio deve ser reproduzido.
local parametros = {time = 2000, fadein = 200}

local botaoTiro = display.newCircle (60, 300, 32)
botaoTiro:setFillColor (1, 0, 0)

local function tocarTiro ()
    audio.play (audioTiro, parametros)
end

botaoTiro:addEventListener ("tap", tocarTiro)

-- AUDIO MOEDA
local audioMoeda = audio.loadSound ("Audio/moeda.wav")
-- Informações de como o áudio deve ser reproduzido.
local parametros = {time = 2000, fadein = 200}

local botaoMoeda = display.newCircle (250, 300, 32)
botaoMoeda:setFillColor (1, 0.5, 0.8)

local function tocarMoeda ()
    audio.play (audioMoeda, parametros)
end

botaoMoeda:addEventListener ("tap", tocarMoeda)