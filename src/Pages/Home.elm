module Pages.Home exposing (view)

import Element exposing (..)
import Element.Font as Font
import Html.Attributes
import MarkdownThemed
import Theme
import Types exposing (FrontendMsg(..), FrontendModel)


view : FrontendModel -> Element FrontendMsg
view model =
   column [paddingXY 0 30 ]
        [column Theme.contentAttributes [ content ]
        ,el [paddingEach { left = 0, right = 0, top = 48, bottom = 0 } ] (Element.column Theme.contentAttributes [ content2 ])
        ]


content2 : Element msg
content2 =
    """
**NOTE.** *The "View Data" and "Edit Data" tabs are for another project
(a curated public data service for science and education) and will be removed when this project is complete.*
    """
        |> MarkdownThemed.renderFull


content : Element msg
content =
    """
# Kitchen Sink

This is app is a template for Lamdera projects.
The repo is at  [github.com/jxxcarlson/kitchen-sink](https://github.com/jxxcarlson/kitchen-sink).

See the **Features** and **Note** tabs for more information. The first
of these lists the main features of the template and their status. The
second gives details on their implementation. The **Purchase** tab
allows you to make fake purchases using Stripe.  Your credit card
will not be charged — this is all done in test mode.

Note that you can play administrator by signing in as `jxxcarlson`. When signed
is as an administrator, the **Admin** tab appears.  Using it, you
can display the current users, Stripe data, and a key-value store.  You can
put data into and get data out of the key-value store using remote
procedure calls (RPCs).

Below are five short examples: (1) the first button plays a sound,
(2) the second copies some hidden text to the clipboard, (3)
the third displays the current temperature in of the city
that you type into the white box (press `Enter` when done),
while (4) the fourth displays the current local time, (5)
the fifth displays the current date in an internationalize format.

Examples (1) and (2) use ports, (3)  relies
on an outbound Http request to [openweathermap.org](https://openweathermap.org/)
from the backend, while (4) and (5) are implemented as a custom element (web component).
See the `Ports`, `Weather`, and `View.CustomElement` modules for code
and for more information. For (5), see also the
[guide.elm-lang.org](https://guide.elm-lang.org/interop/custom_elements).
        """
        |> MarkdownThemed.renderFull