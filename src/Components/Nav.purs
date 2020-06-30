module Components.Nav where

import Prelude
import Color (white)
import Components.Icons as Icons
import Components.Link (link)
import Components.Router (Route, useRoute)
import Data.Monoid as Monoid
import Data.Tuple.Nested (type (/\), (/\))
import Effect.Unsafe (unsafePerformEffect)
import Hooks.Media (useMedia)
import React.Basic.DOM as R
import React.Basic.DOM.Events (capture_)
import React.Basic.Emotion as E
import React.Basic.Hooks as React

navCollapseBelowWidth :: Int
navCollapseBelowWidth = 1080

nav :: Array (Route /\ String) -> React.JSX
nav =
  unsafePerformEffect do
    React.component "Nav" \routes -> React.do
      isCollapsable <- not <$> useMedia ("(min-width: " <> show navCollapseBelowWidth <> "px)")
      isOpen /\ setIsOpen <- React.useState false
      route <- useRoute
      React.useEffect route do
        setIsOpen \_ -> false
        mempty
      let
        toggle = setIsOpen not
      pure $ nav' { isCollapsable, isOpen, toggle, routes }
  where
  nav' { isCollapsable, isOpen, toggle, routes } =
    E.element R.nav'
      { className: "menu"
      , css:
          E.merge
            [ E.css
                { padding: E.px 20
                , width: E.px 240
                }
            , Monoid.guard isCollapsable
                $ E.merge
                    [ E.css
                        { width: E.percent 100.0
                        }
                    , Monoid.guard isOpen E.css
                        { backgroundColor: E.color white
                        , position: E.str "fixed"
                        , top: E.px 0
                        , left: E.px 0
                        , right: E.px 0
                        , bottom: E.px 0
                        }
                    ]
            ]
      , children:
          [ Monoid.guard isCollapsable
              $ toggleButton { isOpen, toggle }
          , Monoid.guard isOpen
              $ navContainer { isCollapsable, isOpen, routes }
          ]
      }

  toggleButton { isOpen, toggle } =
    E.element R.div'
      { className: "toggle-menu"
      , css:
          E.css
            { cursor: E.str "pointer"
            , backgroundColor: E.color white
            , display: E.str "inline-block"
            , transition: E.str "all 200ms"
            }
      , onClick: capture_ toggle
      , children: [ if isOpen then Icons.close else Icons.menu ]
      }

  navContainer { isCollapsable, isOpen, routes } =
    E.element R.ul'
      { className: ""
      , css:
          E.merge
            [ E.css
                { listStyleType: E.none
                , padding: E.px 0
                , margin: E.px 0
                }
            ]
      , children: navItem <$> routes
      }

  navItem (route /\ name) =
    E.element R.li'
      { className: ""
      , css:
          E.css
            { listStyle: E.none
            , backgroundImage: E.none
            , backgroundRepeat: E.none
            , backgroundPosition: E.px 0
            }
      , children: [ link route name ]
      }
