module View.Color exposing
    ( ..
    )


import Element exposing (Color, rgba, rgb255, toRgb, rgb)

negro : Color
negro =
    rgb255 0 0 0


negroHex : String
negroHex =
    "#000000"


blanco : Color
blanco =
    rgb255 256 256 256


grisclaro : Color
grisclaro =
    rgb255 170 170 170


grisclaroHex : String
grisclaroHex =
    "#aaaaaa"


grisclaro20 : Color
grisclaro20 =
    rgba 0 0 0 0.2


grisclaro5 : Color
grisclaro5 =
    rgba 0 0 0 0.05


grisClaroFondo : Color
grisClaroFondo =
    rgb255 244 244 240


linkBlue : Color
linkBlue =
    rgb255 12 82 200



---  Colores chicle


limon : Color
limon =
    rgb255 241 243 51


azul : Color
azul =
    rgb255 144 168 237


chicle : Color
chicle =
    rgb255 255 144 232


chicleHex : String
chicleHex =
    "#ff90e8"


naranja : Color
naranja =
    rgb255 255 201 0


turquesa : Color
turquesa =
    rgb255 35 160 148


rojo : Color
rojo =
    rgb255 220 52 30




orange : Color
orange =
    rgb 1.0 0.7 0.0


blue : Color
blue =
    -- used
    rgb255 64 64 109


messageGreen : Color
messageGreen =
    rgb 0.2 0.7 0.2


yellow : Color
yellow =
    rgb 1.0 0.9 0.7


white : Color
white =
    rgb 255 255 255


offWhite : Color
offWhite =
    gray 0.9


lightGray : Color
lightGray =
    gray 0.8


medGray : Color
medGray =
    gray 0.6


darkGray : Color
darkGray =
    gray 0.2


black : Color
black =
    rgb 0 0 0


red : Color
red =
    rgb255 255 0 0


darkRed : Color
darkRed =
    rgb255 140 0 0


veryDarkBlue : Color
veryDarkBlue =
    gray 0.2


darkBlue : Color
darkBlue =
    rgb255 0 0 190


medBlue : Color
medBlue =
    rgb255 120 120 220


lightBlue : Color
lightBlue =
    rgb255 120 120 200


buttonHighlight : Color
buttonHighlight =
    rgb255 100 80 255


paleBlue : Color
paleBlue =
    rgb255 200 200 255


iconColor =
    rgb 0.45 0.4 0.9


darkGreen : Color
darkGreen =
    rgb255 50 130 55


veryPaleBlue : Color
veryPaleBlue =
    rgb255 140 140 150


transparentBlue : Color
transparentBlue =
    rgba 0.9 0.9 1 0.9


paleViolet : Color
paleViolet =
    rgb255 230 230 255


gray : Float -> Color
gray g =
    rgb g g g