module Theme exposing
    ( contentAttributes
    , css
    , panel
    , spinnerWhite
    , submitButtonAttributes
    )

import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import Html exposing (Html)
import Html.Attributes
import MarkdownThemed


contentAttributes : List (Element.Attribute msg)
contentAttributes =
    [ Element.width (maximum 800 fill), centerX ]


css : Html msg
css =
    Html.node "style"
        []
        [ Html.text <|
            """
/* Spinner */
@-webkit-keyframes spin { 0% { -webkit-transform: rotate(0deg); transform: rotate(0deg); } 100% { -webkit-transform: rotate(360deg); transform: rotate(360deg); } }
@keyframes spin { 0% { -webkit-transform: rotate(0deg); transform: rotate(0deg); } 100% { -webkit-transform: rotate(360deg); transform: rotate(360deg); } }

.spin {
  -webkit-animation: spin 1s infinite linear;
          animation: spin 1s infinite linear;
}
"""
        ]


colors =
    { green = rgb255 92 176 126
    , lightGrey = rgb255 200 200 200
    }


colorWithAlpha : Float -> Color -> Color
colorWithAlpha alpha color =
    let
        { red, green, blue } =
            toRgb color
    in
    rgba red green blue alpha


fontFace : Int -> String -> String -> String
fontFace weight name fontFamilyName =
    """
@font-face {
  font-family: '""" ++ fontFamilyName ++ """';
  font-style: normal;
  font-weight: """ ++ String.fromInt weight ++ """;
  font-stretch: normal;
  font-display: swap;
  src: url(/fonts/""" ++ name ++ """.ttf) format('truetype');
  unicode-range: U+0000-00FF, U+0131, U+0152-0153, U+02BB-02BC, U+02C6, U+02DA, U+02DC, U+2000-206F, U+2074, U+20AC, U+2122, U+2191, U+2193, U+2212, U+2215, U+FEFF, U+FFFD, U+2192, U+2713;
}"""


panel attrs x =
    column
        ([ width fill
         , alignTop
         , spacing 16
         , Background.color (rgb 1 1 1)
         , Border.shadow { offset = ( 0, 1 ), size = 0, blur = 4, color = rgba 0 0 0 0.25 }
         , height fill
         , Border.rounded 16
         , padding 16
         ]
            ++ attrs
        )
        x


submitButtonAttributes : List (Attribute msg)
submitButtonAttributes =
    [ width fill
    , Background.color
        (rgb255
            92
            176
            126
        )
    , padding 16
    , Border.rounded 8
    , alignBottom
    , Border.shadow { offset = ( 0, 1 ), size = 0, blur = 2, color = rgba 0 0 0 0.1 }
    , Font.semiBold
    , Font.color (rgb 1 1 1)
    ]


toggleButtonAttributes : Bool -> List (Attribute msg)
toggleButtonAttributes isActive =
    [ Background.color
        (if isActive then
            colors.green

         else
            colors.lightGrey
        )
    , padding 16
    , Border.rounded 8
    , alignBottom
    , Border.shadow { offset = ( 0, 1 ), size = 0, blur = 2, color = rgba 0 0 0 0.1 }
    , Font.semiBold
    , Font.color (rgb 1 1 1)
    ]


rowToColumnWhen width model attrs children =
    if model.window.width > width then
        row attrs children

    else
        column attrs children


spinnerWhite =
    el
        [ width (px 16)
        , height (px 16)
        , htmlAttribute <| Html.Attributes.class "spin"
        , htmlAttribute <| Html.Attributes.style "border" "2px solid #fff"
        , htmlAttribute <| Html.Attributes.style "border-top-color" "transparent"
        , htmlAttribute <| Html.Attributes.style "border-radius" "50px"
        ]
        none


glow =
    Font.glow (colorWithAlpha 0.25 MarkdownThemed.lightTheme.defaultText) 4