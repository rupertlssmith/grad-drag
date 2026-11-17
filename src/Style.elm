module Style exposing (styleNode)

{-| The site's stylesheet: the `gd-*` classes the page's markup uses, written with elm-css as global rules.

@docs styleNode

-}

import Css
import Css.Global
import Html
import Html.Styled
import Style.Layout
    exposing
        ( alignItems
        , gap
        , marginBottom
        , marginTop
        , maxWidth
        , reset
        , row
        , weight
        )



-- DESIGN TOKENS


colors :
    { text : String
    , muted : String
    , bg : String
    , panel : String
    , border : String
    , buttonBorder : String
    , codeBg : String
    , link : String
    }
colors =
    { text = "#212529"
    , muted = "#495057"
    , bg = "#f8f9fa"
    , panel = "#ffffff"
    , border = "#dee2e6"
    , buttonBorder = "#adb5bd"
    , codeBg = "#f1f3f5"
    , link = "#1971c2"
    }


fontBody : String
fontBody =
    "system-ui, -apple-system, sans-serif"



-- STYLE NODE


{-| The site's stylesheet, as a `<style>` element. `Shared.view` renders it once, at the top of every page.

It is a constant, so Elm builds it once and the virtual DOM skips it on every render because it is the same object.
Keep it a constant: built from arguments, it would be rebuilt and compared on every render.

-}
styleNode : Html.Html msg
styleNode =
    Css.Global.global style
        |> Html.Styled.toUnstyled


style : List Css.Global.Snippet
style =
    List.concat
        [ reset
        , pageStyles
        , sectionStyles
        , textStyles
        , controlStyles
        ]



-- PAGE


pageStyles : List Css.Global.Snippet
pageStyles =
    [ Css.Global.selector "body"
        [ Css.property "background-color" colors.bg
        ]
    , Css.Global.class "gd-page"
        [ maxWidth "1000px"
        , Css.property "margin" "0 auto"
        , Css.property "padding" "16px"
        , Css.property "font-family" fontBody
        , Css.property "color" colors.text
        , Css.property "line-height" "1.5"
        ]
    , Css.Global.class "gd-title"
        [ marginBottom 1
        , weight 700
        , Css.property "margin-top" "0.67em"
        , Css.property "font-size" "2em"
        ]
    ]



-- SECTIONS AND PANELS


sectionStyles : List Css.Global.Snippet
sectionStyles =
    [ Css.Global.class "gd-section"
        [ Css.property "margin-top" "28px"
        ]
    , Css.Global.class "gd-section-title"
        [ marginBottom 1
        , weight 700
        , Css.property "font-size" "20px"
        ]
    , Css.Global.class "gd-panels"
        [ row
        , gap 4
        , Css.property "flex-wrap" "wrap"
        ]
    , Css.Global.class "gd-panel"
        [ Css.property "padding" "8px"
        , Css.property "border" ("1px solid " ++ colors.border)
        , Css.property "border-radius" "8px"
        , Css.property "background-color" colors.panel

        -- the drawings take every touch, so dragging them does not scroll the page
        , Css.property "touch-action" "none"
        ]
    , Css.Global.class "gd-caption"
        [ marginBottom 1
        , Css.property "font-size" "13px"
        , Css.property "color" colors.muted
        ]
    , Css.Global.class "gd-full-row"
        [ Css.property "flex-basis" "100%"
        ]
    ]



-- TEXT


textStyles : List Css.Global.Snippet
textStyles =
    [ Css.Global.class "gd-para"
        [ maxWidth "780px"
        , Css.property "margin" "6px 0 12px"
        ]
    , Css.Global.class "gd-code"
        [ Css.property "padding" "1px 4px"
        , Css.property "border-radius" "4px"
        , Css.property "background-color" colors.codeBg
        , Css.property "font-size" "0.92em"
        ]
    , Css.Global.class "gd-link"
        [ Css.property "color" colors.link
        , Css.property "text-decoration-line" "underline"
        ]
    ]



-- CONTROLS


controlStyles : List Css.Global.Snippet
controlStyles =
    [ Css.Global.class "gd-controls"
        [ row
        , gap 2
        , alignItems "center"
        , marginTop 1.5
        ]
    , Css.Global.class "gd-status"
        [ Css.property "font-size" "13px"
        , Css.property "color" colors.muted
        ]
    , Css.Global.class "gd-button"
        [ Css.property "padding" "4px 12px"
        , Css.property "border" ("1px solid " ++ colors.buttonBorder)
        , Css.property "border-radius" "6px"
        , Css.property "background-color" colors.bg
        , Css.property "font-size" "13px"
        , Css.property "cursor" "pointer"
        ]
    ]
