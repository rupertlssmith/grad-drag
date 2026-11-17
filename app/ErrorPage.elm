module ErrorPage exposing (ErrorPage(..), Model, Msg, init, internalError, notFound, statusCode, update, view)

import Effect exposing (Effect)
import Html
import Html.Attributes as Attrs
import View exposing (View)


type Msg
    = NoOp


type alias Model =
    {}


init : ErrorPage -> ( Model, Effect Msg )
init _ =
    ( {}, Effect.none )


update : ErrorPage -> Msg -> Model -> ( Model, Effect Msg )
update _ _ model =
    ( model, Effect.none )


type ErrorPage
    = NotFound
    | InternalError String


notFound : ErrorPage
notFound =
    NotFound


internalError : String -> ErrorPage
internalError =
    InternalError


view : ErrorPage -> Model -> View Msg
view error _ =
    case error of
        NotFound ->
            { body =
                [ Html.div [ Attrs.class "gd-page" ]
                    [ Html.p [ Attrs.class "gd-para" ]
                        [ Html.text "There is no page here. The demos are on "
                        , Html.a [ Attrs.class "gd-link", Attrs.href "/" ] [ Html.text "the front page" ]
                        , Html.text "."
                        ]
                    ]
                ]
            , title = "Page not found"
            }

        InternalError reason ->
            { body =
                [ Html.div [ Attrs.class "gd-page" ]
                    [ Html.p [ Attrs.class "gd-para" ] [ Html.text <| "Internal error: " ++ reason ]
                    ]
                ]
            , title = "Internal error"
            }


statusCode : ErrorPage -> number
statusCode error =
    case error of
        NotFound ->
            404

        InternalError _ ->
            500
