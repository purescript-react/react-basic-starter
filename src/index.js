if (process.env.NODE_ENV === "production") {
  import("../output/Main-bundled.js").then((Main) => Main.main());
} else {
  import("../output/Main/index.js").then((Main) => Main.main());
}
