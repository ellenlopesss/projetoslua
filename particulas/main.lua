local physics = require ("physics")
physics.start()
physics.setDrawMode ("normal")

display.setStatusBar (display.HiddenStatusBar)

local chao = display.newRect (display.contentCenterX, 470, 500, 50)
physics.addBody (chao, "static")

local paredeEsq = display.newRect (-30, display.contentCenterY, 50, 500)
physics.addBody (paredeEsq, "static")

local paredeDir = display.newRect (350, display.contentCenterY, 50, 500)
physics.addBody (paredeDir, "static")

local testeParticula = physics.newParticleSystem (
    {
        -- Nome do arquivo de particula
        filename = "liquidParticle.png",
        -- radius físico da partícula
        radius = 2,
        -- radius da imagem (usar sempre valor maior que o radius da partícula para que elas se sobreponham e traga um efeito visual mais satisfatório.)
        imageRadius = 4
    }
)

local function onTimer (event)
    testeParticula:createParticle (
    { -- Determina onde a nova partícula é gerada.
        x= 0, 
        y= 0,
        -- Valores iniciais de velocidade para a partícula.
        velocityX= 256,
        velocityY= 480,
        -- Define a cor da partícula RGBA (A= alpha)
        color= {1, 0.2, 0.4, 1},
        -- Dedine-se o tempo de vida da partícula, quantos segundos ela permanece na tela antes de "morrer" (0 = infinito)
        lifeTime= 32.0,
        -- Define-se qual será o comportamento desta partícula
        flags= {"water", "colorMixing"} -- "colorMixing": misturar as cores
    })
end
timer.performWithDelay (20, onTimer, 0)

testeParticula:createGroup (
    {
        x= 50,
        y= 0,
        color= {0, 0.3, 1, 1},
        -- Metade da largura do grupo
        halfWidth= 64,
        -- Metade da altura do grupo
        halfHeight= 32,
        flags= {"water", "colorMixing"}
    }
)
testeParticula:applyForce (0, -9.8*testeParticula.particleMass)