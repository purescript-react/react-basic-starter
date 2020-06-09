module Components.Page where

import Prelude
import Effect.Unsafe (unsafePerformEffect)
import React.Basic.DOM as R
import React.Basic.Emotion as E
import React.Basic.Hooks (fragment)
import React.Basic.Hooks as React
import Web.HTML (window)
import Web.HTML.HTMLDocument (setTitle)
import Web.HTML.Window (document)

pageWidth :: Int
pageWidth = 800

page :: String -> Array React.JSX -> React.JSX
page title children =
  fragment
    [ setPageTitle title
    , E.element R.article'
        { css:
            E.css
              { margin: E.str "0 auto"
              , width: E.percent 100.0
              , maxWidth: E.px pageWidth
              , padding: E.px 24
              , "> *, article > *, section > *": E.nested $ E.css { marginBottom: E.px 32 }
              }
        , className: "page"
        , children
        }
    ]

article :: Array React.JSX -> React.JSX
article = R.article_

section :: Array React.JSX -> React.JSX
section = R.section_

setPageTitle :: String -> React.JSX
setPageTitle =
  unsafePerformEffect do
    React.component "SetPageTitle" \title -> React.do
      React.useEffect title do
        setTitle title =<< document =<< window
        mempty
      mempty
