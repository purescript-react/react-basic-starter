"use strict";

const history = require("history");

exports.createBrowserHistory = () => history.createBrowserHistory();

exports.createHashHistory = () => history.createHashHistory();

exports.getPath = (h) => () => h.location.pathname;

exports.listen = (h) => (cb) => () =>
  h.listen((location) => cb(location.pathname)());

exports.push = (h) => (path) => () => h.push(path);
