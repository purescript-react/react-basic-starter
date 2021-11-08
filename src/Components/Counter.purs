module Components.Counter where

import Prelude

import Data.Tuple.Nested ((/\))
import React.Basic.DOM as R
import React.Basic.Events (handler_)
import React.Basic.Hooks (Component, component, useState)
import React.Basic.Hooks as React

mkCounter :: Component Int -- Effect (Int -> JSX)
mkCounter = do
  component "Counter" \initialValue -> React.do
    counter /\ setCounter <- useState initialValue

    pure
      $ R.button
          { onClick: handler_ do
              setCounter (_ + 1)
          , children:
              [ R.text $ "Increment: " <> show counter ]
          }
