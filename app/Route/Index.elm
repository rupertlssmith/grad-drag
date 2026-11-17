module Route.Index exposing (ActionData, Data, Model, Msg, RouteParams, route)

{-| The site's one page: every demo of dragging through gradients, run by `Demo`.

The page is rendered when the site is built, so its text and the drawings in their first state are in
the HTML; once the page's Elm starts in the browser, the drawings can be dragged and the panels
that train start training.

-}

import BackendTask exposing (BackendTask)
import Demo
import Effect exposing (Effect)
import FatalError exposing (FatalError)
import Head
import Head.Seo as Seo
import Html
import MimeType
import Pages.Url
import PagesMsg exposing (PagesMsg)
import RouteBuilder exposing (App, StatefulRoute)
import Settings
import Shared
import UrlPath exposing (UrlPath)
import View exposing (View)


type alias Model =
    Demo.Model


type alias Msg =
    Demo.Msg


type alias RouteParams =
    {}


type alias Data =
    {}


type alias ActionData =
    {}


route : StatefulRoute RouteParams Data ActionData Model Msg
route =
    RouteBuilder.single
        { head = head
        , data = data
        }
        |> RouteBuilder.buildWithLocalState
            { view = view
            , init = init
            , update = update
            , subscriptions = subscriptions
            }


data : BackendTask FatalError Data
data =
    BackendTask.succeed {}


head : App Data ActionData RouteParams -> List Head.Tag
head _ =
    Seo.summary
        { canonicalUrlOverride = Nothing
        , siteName = Settings.title
        , image =
            { url = [ "images", "card.png" ] |> UrlPath.join |> Pages.Url.fromPath
            , alt = "Two-source interference, one of the drawings"
            , dimensions = Just { width = 480, height = 300 }
            , mimeType = Just (MimeType.Image MimeType.Png)
            }
        , description = Settings.description
        , locale = Settings.locale
        , title = Settings.title
        }
        |> Seo.website


init : App Data ActionData RouteParams -> Shared.Model -> ( Model, Effect Msg )
init _ _ =
    ( Demo.init, Effect.none )


update : App Data ActionData RouteParams -> Shared.Model -> Msg -> Model -> ( Model, Effect Msg )
update _ _ msg model =
    ( Demo.update msg model, Effect.none )


subscriptions : RouteParams -> UrlPath -> Shared.Model -> Model -> Sub Msg
subscriptions _ _ _ model =
    Demo.subscriptions model


view : App Data ActionData RouteParams -> Shared.Model -> Model -> View (PagesMsg Msg)
view _ _ model =
    { title = Settings.title
    , body = [ Html.map PagesMsg.fromMsg (Demo.view model) ]
    }
