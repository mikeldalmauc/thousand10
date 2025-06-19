module View.Main exposing (view)

import Browser exposing (UrlRequest(..))
import Element exposing (..)
import Element.Font as Font
import MarkdownThemed
import Pages.Home
import Route exposing (Route(..))
import Theme
import Types exposing (FrontendModel, FrontendMsg(..))
import Pages.Parts
import Html.Lazy

noFocus :FocusStyle
noFocus =
    { borderColor = Nothing
    , backgroundColor = Nothing
    , shadow = Nothing
    }


view : FrontendModel -> Browser.Document FrontendMsg
view model =
    { title = "Thousand 10"
    , body =
        [ Theme.css
        , Html.Lazy.lazy (\ _ -> 
            
            layoutWith { options = [focusStyle noFocus ] }
            [width fill
            ,Font.color MarkdownThemed.lightTheme.defaultText
            ,Font.size 16
            ,Font.medium
            ]
            (loadedView model
            )
        ) model
        ]
    }


loadedView : FrontendModel -> Element FrontendMsg
loadedView model =
    case model.route of
        HomepageRoute ->
            -- Pages.Home.view model
            Pages.Parts.generic model Pages.Home.view

      