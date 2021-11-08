module Components.ToggleHooks where

import Prelude

import Data.Tuple.Nested ((/\))
import React.Basic.DOM as R
import React.Basic.Events (handler_)
import React.Basic.Hooks (Component, component, useState)
import React.Basic.Hooks as React


mkToggle :: Component Boolean -- Effect (Boolean -> JSX)
mkToggle = do
  component "ToggleHook" \initialValue -> React.do
    toggleOn /\ setToggle <- useState initialValue

    pure
      $ R.button
          { onClick: handler_ do
              setToggle not
          , children: [ R.text if toggleOn then "Hook On" else "Hook Off" ]
          }
