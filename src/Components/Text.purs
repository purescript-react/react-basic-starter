module Components.Text where

import Prelude
import Data.Newtype (un)
import React.Basic.DOM as R
import React.Basic.Hooks as React
import Web.HTML.History (URL(..))

-- | Sometimes full components are not necssary. This documentation site is very
-- | content-heavy and most of that content fits neatly into these standard DOM
-- | elements. These helper functions make that primary use case of editing text
-- | content easy, like editing markdown, but I wouldn't necessarily recommend
-- | copying them directly into most applications.
--
h1 :: String -> React.JSX
h1 = R.h1_ <<< pure <<< R.text

h2 :: String -> React.JSX
h2 = R.h2_ <<< pure <<< R.text

h3 :: String -> React.JSX
h3 = R.h3_ <<< pure <<< R.text

h4 :: String -> React.JSX
h4 = R.h4_ <<< pure <<< R.text

p :: Array React.JSX -> React.JSX
p = R.p_

p' :: String -> React.JSX
p' = p <<< pure <<< R.text

b :: String -> React.JSX
b = R.b_ <<< pure <<< R.text

i :: String -> React.JSX
i = R.i_ <<< pure <<< R.text

c :: String -> React.JSX
c = R.code_ <<< pure <<< R.text

ol :: Array React.JSX -> React.JSX
ol = R.ol_ <<< map (R.li_ <<< pure)

ul :: Array React.JSX -> React.JSX
ul = R.ul_ <<< map (R.li_ <<< pure)

linkOut :: URL -> String -> React.JSX
linkOut href msg =
  R.a
    { href: un URL href
    , children: [ t msg ]
    , target: "_blank"
    , rel: "noreferrer noopener"
    }

t :: String -> React.JSX
t = R.text
