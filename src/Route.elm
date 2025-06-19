module Route exposing (Route(..), decode, encode)

import Url exposing (Url)
import Url.Builder
import Url.Parser exposing ((</>), (<?>))
import Url.Parser.Query


type Route
    = HomepageRoute


decode : Url -> Route
decode url =
    Url.Parser.oneOf
        [ Url.Parser.top |> Url.Parser.map HomepageRoute
        ]
        |> (\a -> Url.Parser.parse a url |> Maybe.withDefault HomepageRoute)


parseAdminPass : Url.Parser.Query.Parser (Maybe String)
parseAdminPass =
    Url.Parser.Query.string "pass"


encode : Route -> String
encode route =
    Url.Builder.absolute
        (case route of
            HomepageRoute ->
                []

        )
        (case route of
            HomepageRoute ->
                []

        )