{-
Welcome to a Spago project!
You can edit this file as you like.
-}
{ name = "my-project"
, packages = ./packages.dhall
, sources = [ "src/**/*.purs", "test/**/*.purs" ]
, dependencies =
  [ "console"
  , "effect"
  , "psci-support"
  , "react-basic"
  , "react-basic-classic"
  , "react-basic-dom"
  , "react-basic-emotion"
  , "react-basic-hooks"
  , "routing"
  , "routing-duplex"
  ]
}
