module View.Paleta exposing
    ( ColorPalette
    , palette
    , ColorDef
    )

{-| Este módulo define la paleta de colores completa de la aplicación.

La idea es tener una única fuente de verdad para todos los colores,
accesible a través del registro `palette`.

Cada color se define en dos formatos para máxima flexibilidad:
- `hex`: Un string hexadecimal (ej. "#ffffff"), útil para atributos SVG o CSS.
- `color`: El tipo `Element.Color`, para usar con `elm-ui`.


## Cómo Usarlo

Desde cualquier módulo de tu vista, puedes importar este y usar los colores así:

    import View.Color as Color

    ...
        Element.el
            [ Element.background <| Color.palette.primary.color
            , Element.Font.color <| Color.palette.secondary.color
            , Element.Border.color <| Color.palette.accent.color
            ]
            (Element.text "Hola Mundo")

Para los iconos SVG, usarías el campo `.hex`:

    import View.Icons as Icons

    ...
        Icons.user Color.palette.accent.hex
    ...

-}

import Element exposing (Color)
import Element.HexColor as HexColor
import Maybe


-- TIPOS PÚBLICOS


{-| Un registro que contiene un color en sus dos formatos.
-}
type alias ColorDef =
    { hex : String
    , color : Color
    }


{-| El registro principal que contiene toda nuestra paleta de colores,
organizada por categorías.
-}
type alias ColorPalette =
    { -- Colores Base
      primary : ColorDef
    , secondary : ColorDef
    , accent : ColorDef

    -- Gamas de color basadas en el color de acento
    , analogous : { orange : ColorDef, pink : ColorDef }
    , splitComplementary : { green : ColorDef, blue : ColorDef }

    -- Variaciones de Tinte (más claros) y Sombra (más oscuros)
    , tints : { accentLight : ColorDef, secondaryLight : ColorDef }
    , shades : { accentDark : ColorDef, secondaryDark : ColorDef }

    -- Colores neutrales para fondos, bordes y textos
    , neutrals :
        { white : ColorDef
        , offWhite : ColorDef
        , lightGray : ColorDef
        , midGray : ColorDef
        , darkGray : ColorDef
        , black : ColorDef
        }

    -- Colores de UI para estados (éxito, error, etc.)
    , ui :
        { success : ColorDef
        , warning : ColorDef
        , error : ColorDef
        }
    }



-- PALETA PRINCIPAL


{-| La paleta de colores completa de la aplicación.
Esta es la única variable que necesitas importar y usar desde fuera.
-}
palette : ColorPalette
palette =
    let
        -- Definimos los strings hexadecimales una sola vez.
        primaryHex =
            "#ffffff"

        secondaryHex =
            "#1f2f38"

        accentHex =
            "#f3000d"

        -- Colores Análogos (cercanos en la rueda de color al acento)
        analogousOrangeHex =
            "#f36d00"

        analogousPinkHex =
            "#f3007b"

        -- Colores Complementarios Divididos (opuestos al acento)
        splitCompGreenHex =
            "#00f371"

        splitCompBlueHex =
            "#007bf3"

        -- Tintes (mezclados con blanco)
        accentTintHex =
            "#f96670"

        secondaryTintHex =
            "#657278"

        -- Sombras (mezclados con negro)
        accentShadeHex =
            "#9e0008"

        secondaryShadeHex =
            "#0f171c"

        -- Neutros
        whiteHex =
            "#ffffff"

        offWhiteHex =
            "#f7f7f7"

        lightGrayHex =
            "#dddddd"

        midGrayHex =
            "#aaaaaa"

        darkGrayHex =
            "#666666"

        blackHex =
            "#000000"

        -- UI
        successHex =
            "#28a745"

        warningHex =
            "#ffc107"

        errorHex =
            accentHex -- Reutilizamos el color de acento para errores
    in
    { primary = toColorDef primaryHex
    , secondary = toColorDef secondaryHex
    , accent = toColorDef errorHex
    , analogous =
        { orange = toColorDef analogousOrangeHex
        , pink = toColorDef analogousPinkHex
        }
    , splitComplementary =
        { green = toColorDef splitCompGreenHex
        , blue = toColorDef splitCompBlueHex
        }
    , tints =
        { accentLight = toColorDef accentTintHex
        , secondaryLight = toColorDef secondaryTintHex
        }
    , shades =
        { accentDark = toColorDef accentShadeHex
        , secondaryDark = toColorDef secondaryShadeHex
        }
    , neutrals =
        { white = toColorDef whiteHex
        , offWhite = toColorDef offWhiteHex
        , lightGray = toColorDef lightGrayHex
        , midGray = toColorDef midGrayHex
        , darkGray = toColorDef darkGrayHex
        , black = toColorDef blackHex
        }
    , ui =
        { success = toColorDef successHex
        , warning = toColorDef warningHex
        , error = toColorDef errorHex
        }
    }



-- FUNCIONES PRIVADAS DE AYUDA


{-| Convierte un string hexadecimal en un registro `ColorDef`.
Esta función es el núcleo de nuestro sistema para no duplicar colores.
-}
toColorDef : String -> ColorDef
toColorDef hexString =
    { hex = hexString
    , color = hexToColor hexString
    }


{-| Una función segura que convierte un `String` a `Color`.

La función `HexColor.hex` devuelve un `Maybe Color`. Esta función
maneja el `Maybe` por nosotros. Si el `String` es inválido,
devuelve un color rosa brillante muy obvio para que detectemos
el error al instante durante el desarrollo.

-}
hexToColor : String -> Color
hexToColor hexString =
    Maybe.withDefault debugColor (HexColor.hex hexString)


{-| Un color de depuración para identificar fácilmente strings hexadecimales rotos.
-}
debugColor : Color
debugColor =
    -- Un rosa chillón que no pasará desapercibido.
    Element.rgb255 255 0 255