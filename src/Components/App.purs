module Components.App where

import Prelude

import Components.Toggle (toggle)
import Components.Counter (mkCounter)
import Components.ToggleHooks (mkToggle)
import Effect (Effect)
import React.Basic.Classic (Component, JSX, createComponent, makeStateless)
import React.Basic.DOM as R

component :: Component Unit
component = createComponent "App"


classicApp :: JSX
classicApp = unit # makeStateless component \_ ->
  R.div_
    [ R.h1_ [ R.text "Hello world" ]
    , toggle { initialValue: true }
    , toggle { initialValue: false }
    ]

mkApp :: Effect JSX
mkApp = do
  counter <- mkCounter
  toggleHooks <- mkToggle

  pure $ unit # makeStateless component \_ ->
    R.div_
      [ R.h1_ [ R.text "Hello world" ]
      , toggle { initialValue: true }
      , toggle { initialValue: false }
      , counter 0
      , toggleHooks false
      , toggleHooks true
      ]
