module Frontend exposing (..)

import Browser exposing (UrlRequest(..))
import Browser.Navigation as Nav
import Html
import Html.Lazy
import Html.Attributes as Attr
import Lamdera
import Types exposing (..)
import Url
import Element exposing (..)
import Browser.Dom
import Browser.Events
import Task
import Element.Font as Font
import MarkdownThemed
import View.Main
import Route

app =
    Lamdera.frontend
        { init = init
        , onUrlRequest = UrlClicked
        , onUrlChange = UrlChanged
        , update = update
        , updateFromBackend = updateFromBackend
        , subscriptions = subscriptions
        , view = View.Main.view
        }

subscriptions : FrontendModel -> Sub FrontendMsg
subscriptions _ =
    Sub.batch
        [ Browser.Events.onResize GotWindowSize
        ]


init : Url.Url -> Nav.Key -> ( FrontendModel, Cmd FrontendMsg )
init url key =
    let
        route =
            Route.decode url
    in
        ( { key = key
        , device = classifyDevice {width = 0, height = 0}
        , window = {width = 0, height = 0}
        , route = route
        }
        ,  Cmd.batch
            [ Browser.Dom.getViewport
                |> Task.perform (\{ viewport } -> GotWindowSize (round viewport.width) (round viewport.height))
            ]
        )


update : FrontendMsg -> FrontendModel -> ( FrontendModel, Cmd FrontendMsg )
update msg model =
    case msg of
        UrlClicked urlRequest ->
            case urlRequest of
                Internal url ->
                    ( model
                    , Nav.pushUrl model.key (Url.toString url)
                    )

                External url ->
                    ( model
                    , Nav.load url
                    )

        UrlChanged url ->
            ( model, Cmd.none )

        NoOpFrontendMsg ->
            ( model, Cmd.none )
            
        SetViewport ->
            ( model, Cmd.none )

        GotWindowSize width height ->
            ( { model | device = classifyDevice { width = width, height = height }, window = { width = width, height = height } }, Cmd.none )            


scrollToTop : Cmd FrontendMsg
scrollToTop =
    Browser.Dom.setViewport 0 0 |> Task.perform (\() -> SetViewport)


updateFromBackend : ToFrontend -> FrontendModel -> ( FrontendModel, Cmd FrontendMsg )
updateFromBackend msg model =
    case msg of
        NoOpToFrontend ->
            ( model, Cmd.none )
