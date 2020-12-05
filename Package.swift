// swift-tools-version:5.0
import PackageDescription

let package = Package(
  name: "Prelude",
  platforms: [
    .iOS(.v9), .tvOS(.v9)
  ],
  products: [
    .library(name: "Prelude", targets: ["Prelude"])
  ],
  dependencies: [
    .package(url: "git@github.com:1989allen126/Runes.git", from: Version(1,0,6))
  ],
  targets: [
    .target(
      name: "Prelude",
      dependencies: [
        "Runes",
      ],
      path: "Sources",
      linkerSettings: [.linkedFramework("CoreGraphics"),.linkedFramework("UIKit",.when(platforms: [.iOS,.tvOS]))]),
  ],
  swiftLanguageVersions: [.v5]
)
