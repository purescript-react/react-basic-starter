module Components.AppErrorHandler where

import Prelude
import Data.Maybe (Maybe(..))
import Effect (Effect)
import Effect.Console (error)
import Effect.Exception (Error)
import React.Basic.DOM as R
import React.Basic.Emotion as E
import React.Basic.Hooks as React
import React.Basic.Hooks.ErrorBoundary (mkErrorBoundary)
import Unsafe.Coerce (unsafeCoerce)

mkAppErrorHandler :: React.Component React.JSX
mkAppErrorHandler = do
  catchAppErrors <- mkErrorBoundary "AppErrorHandler"
  renderAppErrors <-
    React.component "AppError" \e -> React.do
      -- Log the current error to the console every time this component renders.
      -- You may want to send this error to an error monitoring service as well.
      React.useEffectAlways do
        logError e
        mempty
      -- Render a user-facing error. You could include the error message in this
      -- view if you have technical users, but this really only exists to capture
      -- completely unexpected errors. Use more local error boundaries for
      -- handling issues with specific messaging and/or recovery paths.
      pure
        $ divFillSpace
            [ h2Centered
                [ R.text "Oops, something went wrong."
                ]
            ]
  pure \children ->
    catchAppErrors \{ dismissError, error } -> case error of
      Just e -> renderAppErrors e
      Nothing -> children
  where
  logError :: Error -> Effect Unit
  logError = error <<< unsafeCoerce

  divFillSpace children =
    E.element
      R.div'
      { css: E.css { display: E.str "grid", padding: E.str "24px 24px 48px" }
      , className: ""
      , children
      }

  h2Centered children =
    E.element R.h2'
      { css: E.css { margin: E.str "auto" }
      , className: ""
      , children
      }
