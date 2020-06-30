module Components.Icons where

import React.Basic as React
import React.Basic.DOM.SVG as RS

menu :: React.JSX
menu =
  RS.svg
    { viewBox: "0 0 10 10"
    , width: "20"
    , children:
        [ RS.path
            { d: "M1 2h8M1 5h 8M1 8h8"
            , stroke: "#666"
            , strokeWidth: "1"
            , strokeLinecap: "round"
            }
        ]
    }

close :: React.JSX
close =
  RS.svg
    { viewBox: "0 0 10 10"
    , width: "20"
    , children:
        [ RS.path
            { d: "M1,1 L9,9 M1,9 L9,1"
            , stroke: "#666"
            , strokeWidth: "1"
            , strokeLinecap: "round"
            }
        ]
    }
