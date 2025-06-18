module Frontend exposing (..)

import Browser exposing (UrlRequest(..))
import Browser.Navigation as Nav
import Html
import Html.Attributes as Attr
import Lamdera
import Types exposing (..)
import Url
import Element exposing (..)
import Browser.Dom
import Browser.Events
import Task
import Element.Font as Font

type alias Model =
    FrontendModel


app =
    Lamdera.frontend
        { init = init
        , onUrlRequest = UrlClicked
        , onUrlChange = UrlChanged
        , update = update
        , updateFromBackend = updateFromBackend
        , subscriptions = \m -> Sub.none
        , view = view
        }

subscriptions : FrontendModel -> Sub FrontendMsg
subscriptions _ =
    Sub.batch
        [ Browser.Events.onResize GotWindowSize
        ]


init : Url.Url -> Nav.Key -> ( Model, Cmd FrontendMsg )
init url key =
    ( { key = key
      , device = classifyDevice {width = 0, height = 0}
      , window = {width = 0, height = 0}
      }
    ,  Cmd.batch
        [ Browser.Dom.getViewport
            |> Task.perform (\{ viewport } -> GotWindowSize (round viewport.width) (round viewport.height))
        ]
    )


update : FrontendMsg -> Model -> ( Model, Cmd FrontendMsg )
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


updateFromBackend : ToFrontend -> Model -> ( Model, Cmd FrontendMsg )
updateFromBackend msg model =
    case msg of
        NoOpToFrontend ->
            ( model, Cmd.none )


view : Model -> Browser.Document FrontendMsg
view model =
    { title = ""
    , body =
        [ 
            layoutWith  { options = [] }
            [ width fill
                , Font.color <| rgb255 0 0 0
                , Font.size 16
                , Font.medium
                ]
            <|  debugInfo model    
        ]
    }
        

debugInfo : Model -> Element FrontendMsg
debugInfo model =
    column []
        [ text "Debug" 
       -- , el [] [ text ("Key: " ++ Nav.keyToString model.key) ]
        
        , text ("Device: " ++  Debug.toString model.device) 
        , text ("Window Size: " ++ String.fromInt model.window.width ++ "x" ++ String.fromInt model.window.height)
        ]
        
    