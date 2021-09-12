// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "Architecture",
    platforms: [.iOS(.v10)],
    products: [.library(name: "Architecture", targets: ["Architecture"])],
    dependencies: [],
    targets: [.target(name: "Architecture")]
)
