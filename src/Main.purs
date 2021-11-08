module Main where

import Prelude

import Components.App (classicApp, mkApp)
import Data.Maybe (Maybe(..))
import Effect (Effect)
import Effect.Exception (throw)
import React.Basic.DOM (render)
import Web.DOM.NonElementParentNode (getElementById)
import Web.HTML (window)
import Web.HTML.HTMLDocument (toNonElementParentNode)
import Web.HTML.Window (document)

main :: Effect Unit
main = do
  root <- getElementById "root" =<< (map toNonElementParentNode $ document =<< window)
  hookApp <- mkApp
  case root of
    Nothing -> throw "Root element not found."
    -- Just r  -> render classicApp r -- classic-only app is pure func
    Just r  -> render hookApp r -- Hooks app runs in Effect
