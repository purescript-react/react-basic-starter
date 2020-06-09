module Pages.NotFound where

import Prelude
import Components.Page (page)
import Components.Text (h2)
import React.Basic.Hooks as React

mkNotFound :: React.Component Unit
mkNotFound = do
  React.component "NotFound" \_ ->
    pure $ page "Not found" [ h2 "Page not found" ]
