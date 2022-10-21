//
//  RswiftPlugin.swift
//  Plugins/Rswift
//
//  Created by Alan DeGuzman on 9/23/22.
//

import PackagePlugin
import Foundation

@main

// for operating on a Swift package
struct RswiftBuildToolPlugin: BuildToolPlugin {
  
  enum Const {
    static let doNothing = PackagePlugin.Path("/usr/bin/true")
    static let configFileName = "rswift-config.plist"
  }
  
  // disabled as plugin intended only for Xcode projects
  func createBuildCommands(context: PluginContext, target: Target) async throws -> [Command] {
    return [.buildCommand(
      displayName: "Skipping R.swift",
      executable: Const.doNothing,
      arguments: [],
      environment: [:],
      inputFiles: [],
      outputFiles: [])
    ]
  }
}

#if canImport(XcodeProjectPlugin)
import XcodeProjectPlugin

// for operating on an Xcode project
extension RswiftBuildToolPlugin: XcodeBuildToolPlugin {
  
  func createBuildCommands(context: XcodePluginContext, target: XcodeTarget) throws -> [Command] {
    let configPath = context.xcodeProject.directory.appending(subpath: Const.configFileName)
    let config = try Config.parseConfig(configPath.string)
    print("projectFilePath = \(config.projectFilePath)")
    print("rGeneratedFilePath = \(config.rGeneratedFilePath)")
    print("PROJECT_FILE_PATH = \(context.xcodeProject.directory.appending(subpath: config.projectFilePath).string)")
    print("SOURCE_ROOT = \(context.xcodeProject.directory.string)")
    print("TARGET_NAME = \(target.displayName)")
    
    return [
      .prebuildCommand(
        displayName: "Running R.swift",
        executable: try context.tool(named: "rswift").path,
        arguments: [
          "generate", context.xcodeProject.directory.appending(config.rGeneratedFilePath)
        ],
        environment: [
          "PROJECT_FILE_PATH": context.xcodeProject.directory.appending(subpath: config.projectFilePath).string,
          "SOURCE_ROOT": context.xcodeProject.directory.string,
          "TARGET_NAME": target.displayName,
          "PRODUCT_BUNDLE_IDENTIFIER": config.productBundleIdentifier
        ],
        outputFilesDirectory: context.pluginWorkDirectory
      )
    ]
  }
  
}
#endif

struct Config: Codable {
  let projectFilePath: String
  let rGeneratedFilePath: String
  let productBundleIdentifier: String
  
  static func parseConfig(_ path: String) throws -> Config  {
    guard let file = FileManager.default.contents(atPath: path) else {
      throw URLError(URLError.Code(rawValue: NSURLErrorFileDoesNotExist))
    }
    return try PropertyListDecoder().decode(Config.self, from: file)
  }
}


