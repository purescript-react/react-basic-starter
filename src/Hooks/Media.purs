module Hooks.Media where

import React.Basic.Hooks as React

foreign import useMedia :: String -> React.Hook UseMedia Boolean

foreign import data UseMedia :: Type -> Type
