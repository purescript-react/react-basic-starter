"use strict";

require("highlight.js/styles/tomorrow.css");
const hljs = require("highlight.js/lib/core");
const purescript = require("highlight.js/lib/languages/haskell");
const javascript = require("highlight.js/lib/languages/javascript");

hljs.registerLanguage("purescript", purescript);
hljs.registerLanguage("javascript", javascript);

exports.highlight = (node) => () => hljs.highlightBlock(node);
