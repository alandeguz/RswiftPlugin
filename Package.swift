// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "RswiftPlugin",
  platforms: [ .macOS(.v10_15) ],
  products: [
    .plugin(name: "Rswift", targets: ["RswiftPlugin"])
  ],
  targets: [
    .plugin(
      name: "RswiftPlugin",
      capability: .buildTool(),
      dependencies: ["RswiftBinary"]),
    .binaryTarget(
      name: "RswiftBinary",
      url: "https://github.com/alandeguz/R.swift/releases/download/v6.1.0/RswiftBinary-macos.artifactbundle.zip",
      checksum: "274eae6001e6649dd70a7bef6aa60b01bd9000c223d53560352d6ad591b6a874")
  ]
)
