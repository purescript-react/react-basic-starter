module Components.Router
  ( Route(..)
  , UseRoute
  , useRoute
  , UseRoutePush
  , useRoutePush
  , parse
  , print
  ) where

import Prelude hiding ((/))
import Data.Either (Either(..))
import Data.Generic.Rep (class Generic)
import Data.Key (Key(..))
import Data.Newtype (class Newtype, un)
import Effect (Effect)
import Effect.Unsafe (unsafePerformEffect)
import React.Basic.Hooks (UnsafeReference(..))
import React.Basic.Hooks as React
import Routing.Duplex (RouteDuplex')
import Routing.Duplex as R
import Routing.Duplex.Generic as G
import Routing.Duplex.Generic.Syntax ((/))
import Routing.Duplex.Parser (RouteError)
import Web.HTML.History (URL(..))

data Route
  = Home
  | About

derive instance eqRoute :: Eq Route

derive instance genericRoute :: Generic Route _

key :: forall entity. RouteDuplex' (Key entity)
key = R.as (un Key) (Right <<< Key) R.segment

routes :: RouteDuplex' Route
routes =
  R.root
    $ G.sum
        { "Home": G.noArgs
        , "About": "about" / G.noArgs
        }

parse :: String -> Either RouteError Route
parse = R.parse routes

print :: Route -> URL
print = URL <<< R.print routes

newtype UseRoute hooks
  = UseRoute
  ( React.UseEffect
      (UnsafeReference History)
      ( React.UseState (Either RouteError Route)
          (React.UseContext History hooks)
      )
  )

derive instance ntUseRoute :: Newtype (UseRoute hooks) _

useRoute :: React.Hook UseRoute (Either RouteError Route)
useRoute =
  React.coerceHook React.do
    history <- React.useContext routerContext
    path <- React.unsafeRenderEffect do getPath history
    match React./\ setMatch <- React.useState (parse path)
    React.useEffect (UnsafeReference history) do
      listen history (setMatch <<< const <<< parse)
    pure match

newtype UseRoutePush hooks
  = UseRoutePush
  (React.UseContext History hooks)

derive instance ntUseRoutePush :: Newtype (UseRoutePush hooks) _

useRoutePush :: React.Hook UseRoutePush (Route -> Effect Unit)
useRoutePush =
  React.coerceHook React.do
    history <- React.useContext routerContext
    pure $ push history <<< un URL <<< print

routerContext :: React.ReactContext History
routerContext =
  unsafePerformEffect do
    -- `createBrowserHistory` is usually preferrable here, but
    -- GitHub Pages still doesn't support single page apps!
    React.createContext =<< createHashHistory

foreign import data History :: Type

foreign import createBrowserHistory :: Effect History

foreign import createHashHistory :: Effect History

foreign import getPath :: History -> Effect String

foreign import listen :: History -> (String -> Effect Unit) -> Effect (Effect Unit)

foreign import push :: History -> String -> Effect Unit
