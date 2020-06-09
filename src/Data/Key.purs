module Data.Key where

import Prelude
import Data.Newtype (class Newtype)

newtype Key entity
  = Key String

derive instance eqKey :: Eq (Key entity)

derive instance ordKey :: Ord (Key entity)

derive instance ntKey :: Newtype (Key entity) _
