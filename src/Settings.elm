module Settings exposing (canonicalUrl, description, locale, title)

{-| The site's name, description, address and locale, for its head tags and manifest.
-}

import LanguageTag.Language as Language
import LanguageTag.Region as Region


{-| The address the site is served from. Netlify gives a new site an address of its own; set this
to it, or to the site's own domain, so that canonical links and social cards point there.
-}
canonicalUrl : String
canonicalUrl =
    "https://grad-drag.netlify.app"


locale : Maybe ( Language.Language, Region.Region )
locale =
    Just ( Language.en, Region.us )


title : String
title =
    "Dragging through gradients"


description : String
description =
    "Declarative dragging in Elm, with exact derivatives from the-sett/elm-max's automatic differentiation, evaluated in the browser."
