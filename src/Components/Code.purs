module Components.Code where

import Prelude
import Data.Nullable as Nullable
import Data.String (trim)
import Effect (Effect)
import Effect.Unsafe (unsafePerformEffect)
import React.Basic.DOM as R
import React.Basic.Hooks as React
import Web.DOM (Node)

data Language
  = PureScript
  | JavaScript

derive instance eqLanguage :: Eq Language

code :: Language -> String -> React.JSX
code = \language content -> code' { language, content }
  where
  code' =
    unsafePerformEffect do
      React.component "Code" \props -> React.do
        ref <- React.useRef (Nullable.null :: Nullable.Nullable Node)
        React.useEffect props do
          highlight =<< React.readRef ref
          mempty
        pure
          $ R.pre_
              [ R.code
                  { ref
                  , className:
                      "language-"
                        <> case props.language of
                            PureScript -> "purescript"
                            JavaScript -> "javascript"
                  , children: [ R.text (trim props.content) ]
                  }
              ]

foreign import highlight :: Nullable.Nullable Node -> Effect Unit
