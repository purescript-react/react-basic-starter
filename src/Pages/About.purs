module Pages.About where

import Prelude
import Components.Link (link)
import Components.Page (page)
import Components.Router (Route(..))
import Components.Text (h1, p, t)
import React.Basic.Hooks as React

mkAbout :: React.Component Unit
mkAbout = do
  React.component "About" \_ -> React.do
    pure
      $ page "About"
          [ h1 "About"
          , p
              [ t "Just a placeholder for now."
              ]
          , link Home "Back"
          ]
