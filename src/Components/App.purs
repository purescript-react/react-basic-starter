module Components.App where

import Prelude
import Components.Router (Route(..), useRoute)
import Data.Either (Either(..))
import Pages.About (mkAbout)
import Pages.Home (mkHome)
import Pages.NotFound (mkNotFound)
import React.Basic.Hooks as React

mkApp :: React.Component Unit
mkApp = do
  notFound <- mkNotFound
  routeFor <- mkRouteFor
  React.component "App" \_ -> React.do
    route <- useRoute
    pure
      $ case route of
          Left _ -> notFound unit
          Right match -> routeFor match
  where
  mkRouteFor = do
    home <- mkHome
    about <- mkAbout
    pure case _ of
      Home -> home unit
      About -> about unit
