module Components.App where

import Prelude
import Components.Nav (nav)
import Components.Router (Route(..), useRoute)
import Data.Either (Either(..))
import Data.Tuple.Nested ((/\))
import Pages.About (mkAbout)
import Pages.Home (mkHome)
import Pages.NotFound (mkNotFound)
import React.Basic.DOM as R
import React.Basic.Emotion as E
import React.Basic.Hooks as React

mkApp :: React.Component Unit
mkApp = do
  notFound <- mkNotFound
  routeFor <- mkRouteFor
  React.component "App" \_ -> React.do
    route <- useRoute
    pure
      $ appContainer
          [ nav
              [ Home /\ "Home"
              ]
          , case route of
              Left _ -> notFound unit
              Right match -> routeFor match
          ]
  where
  mkRouteFor = do
    home <- mkHome
    about <- mkAbout
    pure case _ of
      Home -> home unit
      About -> about unit

  appContainer children =
    E.element R.div'
      { className: "app-container"
      , css:
          E.css
            { display: E.str "flex"
            , flexFlow: E.str "row wrap"
            }
      , children
      }
