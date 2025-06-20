module View.Icons exposing
    ( ..
    )

import Svg
import Svg.Attributes as SvgA
import Element exposing (Element, html)

type alias HexColor = String


user : HexColor -> Element msg
user color = 
    html 
        <| Svg.svg
            [ SvgA.width "24"
            , SvgA.height "24"
            , SvgA.viewBox "0 0 24 24"
            , SvgA.fill "none"
            , SvgA.strokeWidth "1.5"
            , SvgA.stroke color
            ]
            [ Svg.path [ SvgA.d "M5 20V19C5 15.134 8.13401 12 12 12V12C15.866 12 19 15.134 19 19V20"
                , SvgA.strokeLinecap "round"
                , SvgA.strokeLinejoin "round"] []
            , Svg.path [ SvgA.d "M12 12C14.2091 12 16 10.2091 16 8C16 5.79086 14.2091 4 12 4C9.79086 4 8 5.79086 8 8C8 10.2091 9.79086 12 12 12Z"
                , SvgA.strokeLinecap "round"
                , SvgA.strokeLinejoin "round"] []
            ] 


menubars : HexColor -> Element msg
menubars color =
    html
        <| Svg.svg
            [ SvgA.width "24"
            , SvgA.height "24"
            , SvgA.viewBox "0 0 24 24"
            , SvgA.fill "none"
            , SvgA.strokeWidth "2" -- Un poco más grueso para que se vea bien
            , SvgA.stroke color
            ]
            [ -- Barra superior
              Svg.path
                [ SvgA.d "M4 6L24 6"
                -- Usamos "butt" para asegurar bordes rectos y no redondeados
                , SvgA.strokeLinecap "butt"
                ]
                []
            , -- Barra del medio
              Svg.path
                [ SvgA.d "M4 12L24 12"
                , SvgA.strokeLinecap "butt"
                ]
                []
            , -- Barra inferior
              Svg.path
                [ SvgA.d "M4 18L24 18"
                , SvgA.strokeLinecap "butt"
                ]
                []
            ]