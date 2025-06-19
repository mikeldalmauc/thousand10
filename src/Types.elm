module Types exposing (..)

import Browser exposing (UrlRequest)
import Browser.Navigation exposing (Key)
import Url exposing (Url)
import Element exposing (Device)
import Route exposing (Route)

type alias FrontendModel =
    { key : Key
    , route : Route
    , device : Device
    , window : { width : Int, height : Int }
    }


type alias BackendModel =
    { message : String
    }


type FrontendMsg
    = UrlClicked UrlRequest
    | UrlChanged Url
    | NoOpFrontendMsg
    | SetViewport
    | GotWindowSize Int Int


type ToBackend
    = NoOpToBackend


type BackendMsg
    = NoOpBackendMsg


type ToFrontend
    = NoOpToFrontend