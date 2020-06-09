module Pages.Home where

import Prelude
import Components.Code (Language(..), code)
import Components.Page (page, section)
import Components.Text (h1, h2, i, linkOut, p, t)
import React.Basic.Hooks as React
import Web.HTML.History (URL(..))

mkHome :: React.Component Unit
mkHome = do
  React.component "Home" \_ -> React.do
    pure
      $ page "React-Basic Starter"
          [ h1 "React-Basic Starter"
          , p
              [ t "Hello and welcome to the React-Basic docs!"
              ]
          , p
              [ t
                  """
                  In addition to guides and documentation, this resource is also intended to serve
                  as an example project and boilerplate, so check out and clone the
                  """
              , linkOut (URL "https://github.com/lumihq/react-basic-starter") "source"
              , t "!"
              , t
                  """
                  That's also where you'll want to go to submit issues if you get stuck or something
                  is unclear, or if you'd like to contribute new content. (yes, please!)
                  """
              ]
          , section
              [ h2 "What is React-Basic?"
              , p
                  [ i "Basically (ha ha)"
                  , t ", it's a "
                  , linkOut (URL "https://www.purescript.org") "PureScript"
                  , t
                      """
                      wrapper around
                      """
                  , linkOut (URL "https://reactjs.org") "React"
                  , t
                      """
                      which tries to give you the best of PureScript (type safety!) without getting
                      in your way too much. That means writing components should feel familiar if
                      you're coming from JavaScript and you should still have access to the existing
                      React ecosystem of tools and components.
                      """
                  ]
              , code PureScript
                  """
module Counter where

import Prelude
import React.Basic.DOM as R
import React.Basic.Events (handler_)
import React.Basic.Hooks as React

mkCounter :: React.Component Unit
mkCounter = do
  React.component "Counter" \_ -> React.do

    counter React./\ setCounter <- React.useState 0

    pure
      $ R.button
        { onClick: handler_ do
            setCounter (_ + 1)
        , children:
            [ R.text $ "Increment: " <> show counter ]
        }
                  """
              ]
          ]
