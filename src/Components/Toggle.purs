module Components.Toggle where

import Prelude

import Data.Maybe (Maybe(..), fromMaybe)
import React.Basic (Component, JSX, StateUpdate(..), capture_, createComponent, make)
import React.Basic.DOM as R

type Props =
  { initialValue :: Boolean
  }

data Action
  = Toggle

component :: Component Props
component = createComponent "App"

toggle :: Props -> JSX
toggle = make component { initialState, update, render }
  where
    initialState =
      Nothing

    update self = case _ of
      Toggle ->
        Update $ map not $ Just $
          -- this is a silly example; copying props to state
          -- is generally a bad idea
          fromMaybe self.props.initialValue self.state

    render self =
      R.button
        { onClick: capture_ self Toggle
        , children:
            [ R.text
                if fromMaybe self.props.initialValue self.state
                  then "On"
                  else "Off"
            ]
        }
