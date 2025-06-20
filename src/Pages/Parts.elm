module Pages.Parts exposing
    ( generic
    , genericNoScrollBar
    , linkStyle
    )

import Element exposing (..)
import Element.Background as Background
import Element.Font as Font
import Route exposing (Route(..))
import Theme
import Types
import View.Paleta as Paleta
import View.Icons as Icon

genericNoScrollBar : Types.FrontendModel -> (Types.FrontendModel -> Element Types.FrontendMsg) -> Element Types.FrontendMsg
genericNoScrollBar model view =
    column
        [ width fill, height fill, clip ]
        [ header model model.route { window = model.window, isCompact = True }
        , column
            (padding 20
                :: height (px <| model.window.height - 95)
                :: width (px <| 500)
                :: Theme.contentAttributes
            )
            [ view model
            ]
        , footer model.route model
        ]


generic : Types.FrontendModel -> (Types.FrontendModel -> Element Types.FrontendMsg) -> Element Types.FrontendMsg
generic model view =
    column
        [ width fill, height fill ]
        [ header model model.route { window = model.window, isCompact = True }
        , column
            (padding 20
                :: scrollbarY
                :: height (px <| model.window.height - 95)
                :: Theme.contentAttributes
            )
            [ view model
            ]
        , footer model.route model
        ]


header : Types.FrontendModel -> Route -> { window : { width : Int, height : Int }, isCompact : Bool } -> Element Types.FrontendMsg
header model route config =
    let
        fontCol = Font.color Paleta.palette.primary.color
        
        leftMenu = row [ spacing 24, fontCol, alignLeft] [
             el [] <| Icon.menubars Paleta.palette.primary.hex
            ,  link
                (linkStyle route HomepageRoute)
                { url = Route.encode HomepageRoute, label = text "Home" }
            ]

        brandTitle = el [fontCol, centerX] <| text "Thousand 10"

        rightMenu =  row [ spacing 24, fontCol, alignRight] [
                Icon.user Paleta.palette.neutrals.midGray.hex
            ]
    in
    el
        [ Background.color Paleta.palette.shades.secondaryDark.color
        , paddingXY 24 16
        , width (px config.window.width)
        , alignTop
        ]
        (wrappedRow
            ([ spacing 24
             , Font.color (rgb 1 1 1)
             ]
            )
            [ leftMenu, 
              brandTitle, 
              rightMenu
            ]
        )


linkStyle : Route -> Route -> List (Attribute msg)
linkStyle currentRoute route =
    if currentRoute == route then
        [ Font.underline,  Font.color Paleta.palette.primary.color]

    else
        [ Font.color Paleta.palette.primary.color ]


footer : Route -> Types.FrontendModel -> Element msg
footer route model =
    el
        [ Background.color Paleta.palette.shades.secondaryDark.color
        , paddingXY 24 16
        , width fill
        , alignBottom
        ]
        (wrappedRow
            ([ spacing 32
             , Font.color Paleta.palette.primary.color
             ]
                ++ Theme.contentAttributes
            )
            [ link
                (linkStyle route HomepageRoute)
                { url = Route.encode HomepageRoute, label = text "Home" }
            ]
        )