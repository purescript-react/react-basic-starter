"use strict";

const useMedia = require("react-media-hook").useMediaPredicate;

exports.useMedia = (query) => () => useMedia(query);
