// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "RswiftPlugin",
  platforms: [ .macOS(.v10_15) ],
  products: [
    .plugin(name: "RswiftExec", targets: ["RswiftPlugin"])
  ],
  targets: [
    .plugin(
      name: "RswiftPlugin",
      capability: .buildTool(),
      dependencies: ["RswiftBinary"]),
    .binaryTarget(
      name: "RswiftBinary",
      url: "https://github.com/alandeguz/swift-build-tools/releases/download/1.0.3/RswiftBinary-macos.artifactbundle.zip",
      checksum: "ca5adb220bd6674a6664d1a39b67e6e139603db50d2ac4960ac3789704c04a41")
  ]
)
