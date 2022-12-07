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
      url: "https://github.com/alandeguz/R.swift/releases/download/7.2.2/RswiftBinary-macos.artifactbundle.zip",
      checksum: "df1c031d5c91e6cec0af118974664a544b0376e0d0170c46d581c5b8225c6f9e")
  ]
)
