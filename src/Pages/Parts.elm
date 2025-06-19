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
import View.Color

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
    el
        [ Background.color View.Color.blue
        , paddingXY 24 16
        , width (px config.window.width)
        , alignTop
        ]
        (wrappedRow
            ([ spacing 24
             , Background.color View.Color.blue
             , Font.color (rgb 1 1 1)
             ]
                ++ Theme.contentAttributes
            )
            [ link
                (linkStyle route HomepageRoute)
                { url = Route.encode HomepageRoute, label = text "Lamdera Kitchen Sink" }
            ]
        )


linkStyle : Route -> Route -> List (Attribute msg)
linkStyle currentRoute route =
    if currentRoute == route then
        [ Font.underline, Font.color View.Color.yellow ]

    else
        [ Font.color View.Color.white ]


footer : Route -> Types.FrontendModel -> Element msg
footer route model =
    el
        [ Background.color View.Color.blue
        , paddingXY 24 16
        , width fill
        , alignBottom
        ]
        (wrappedRow
            ([ spacing 32
             , Background.color View.Color.blue
             , Font.color (rgb 1 1 1)
             ]
                ++ Theme.contentAttributes
            )
            [ link
                (linkStyle route HomepageRoute)
                { url = Route.encode HomepageRoute, label = text "Home" }
            , el [ Background.color View.Color.black, Font.color View.Color.white ] (text "some text message")
            ]
        )