local circuloAzul = display.newCircle( 200, 50, 30 )
circuloAzul:setFillColor( 0, 0, 1 )
transition.to( circuloAzul, { time=2000, y=400, transition=easing.continuousLoop } )



local retanguloArredondado = display.newRoundedRect (300, 200, 80, 50, 20)
retanguloArredondado:setFillColor( 0.1, 0.9, 1 )
transition.to( retanguloArredondado, { time=2000, y=400, transition=easing.outInQuint } )



local quadrado = display.newRect (100, 80, 50, 50)
quadrado:setFillColor( 0.3, 0.4, 0.7 )
transition.to( quadrado, { time=2000, y=400, transition=easing.outInElastic } )



local opcoes = {
    text = "Ellen",
    x = 250,
    y = 100,
    font = "Arial",
    fontSize = 30,
}

local textoRelevo = display.newEmbossedText (opcoes)
textoRelevo:setFillColor( 0.7, 0.5, 0.4 )
transition.to (textoRelevo, {time=6000, rotation=360, yScale=3, alpha=0.3})



local circuloRosa = display.newCircle (30, 70, 30)
circuloRosa:setFillColor( 1, 0.5, 1 )
transition.to (circuloRosa, {time=3000, x=400, y=200, iterations=6, transition=easing.inOutSine} )



local retanguloArredondado1 = display.newRoundedRect (200, 100, 80, 50, 20)
retanguloArredondado1:setFillColor( 0.5, 0.3, 0.7 )
transition.to( retanguloArredondado1, { time=2000, y=400, transition=easing.outElastic } )



local retangulo = display.newRect (180, 180, 150, 15)
retangulo:setFillColor( 0.2, 0.2, 0.4 )
transition.to (retangulo, {time=6000, rotation=180, yScale=5, xScale=3, alpha=1})