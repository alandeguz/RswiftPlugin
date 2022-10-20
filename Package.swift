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
      url: "https://github.com/alandeguz/R.swift/releases/download/6.0.0-spm/RswiftBinary-macos.artifactbundle.zip",
      checksum: "274eae6001e6649dd70a7bef6aa60b01bd9000c223d53560352d6ad591b6a874")
  ]
)

//url: "https://github.com/quentinfasquel/R.swift/releases/download/6.0.0-spm/rswift.artifactbundle.zip",
//checksum: "357e8982f00e17a8d40027a40c1e01cfd90d5345ce0e30ae16fe78cba49704a7"

// url: "https://github.com/alandeguz/swift-build-tools/releases/download/1.0.4/RswiftBinary-macos.artifactbundle.zip",
// checksum: "274eae6001e6649dd70a7bef6aa60b01bd9000c223d53560352d6ad591b6a874"

// url: "https://github.com/alandeguz/R.swift/releases/download/v6.1.0/RswiftBinary-macos.artifactbundle.zip"
// checksum: "3957f1f633f5d82de1dd5535abc1d02cd3758f4284dd7cffd613240732c04bc5"
