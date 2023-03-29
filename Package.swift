// swift-tools-version:5.7

import PackageDescription

let package = Package(
    name: "Architecture",
    platforms: [.macOS(.v10_15)],
    products: [.library(name: "Architecture", targets: ["Architecture"])],
    dependencies: [],
    targets: [.target(name: "Architecture")]
)
