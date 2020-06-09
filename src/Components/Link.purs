module Components.Link where

import Prelude
import Components.Router (Route, print, useRoutePush)
import Components.Text (t)
import Data.Maybe (Maybe(..))
import Data.Newtype (un)
import Effect.Uncurried (runEffectFn1)
import Effect.Unsafe (unsafePerformEffect)
import React.Basic.DOM as R
import React.Basic.DOM.Events (altKey, button, ctrlKey, metaKey, preventDefault, shiftKey, stopPropagation)
import React.Basic.Events (handler, merge, syntheticEvent)
import React.Basic.Hooks as React
import Web.HTML.History (URL(..))

link :: Route -> String -> React.JSX
link = \to child -> link' { to, child }
  where
  link' =
    unsafePerformEffect do
      React.component "Link" \{ to, child } -> React.do
        routePush <- useRoutePush
        pure
          $ R.a
              { children: [ t child ]
              , href: "#" <> (un URL $ print to)
              , onClick:
                  handler
                    ( stopPropagation
                        >>> merge { button, metaKey, altKey, ctrlKey, shiftKey, syntheticEvent }
                    )
                    ( \{ button, metaKey, altKey, ctrlKey, shiftKey, syntheticEvent } -> do
                        case button, metaKey, altKey, ctrlKey, shiftKey of
                          Just 0, Just false, Just false, Just false, Just false ->
                            runEffectFn1
                              (handler preventDefault \_ -> routePush to)
                              syntheticEvent
                          _, _, _, _, _ -> mempty
                    )
              }
