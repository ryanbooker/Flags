// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Modules",
  defaultLocalization: "en",
  platforms: [
    .iOS(.v26)
  ],
  products: [
    .library(name: "Domain", targets: ["Domain"]),
    .library(name: "DomainUI", targets: ["DomainUI"]),
    .library(name: "Services", targets: ["Services"]),
  ],
  dependencies: [
    .package(url: "https://github.com/apple/swift-async-algorithms.git", from: "1.1.1"),
    .package(url: "https://github.com/pointfreeco/swift-issue-reporting", from: "1.8.0"),
    .package(url: "https://github.com/unsignedapps/Vexil.git", branch: "main"),

    // Plugins
    .package(url: "https://github.com/ryanbooker/SwiftFormatPlugins", from: "1.0.0"),
  ],
  targets: [
    .target(
      name: "Domain",
      dependencies: [
        .product(name: "Vexil", package: "Vexil"),
        .product(name: "IssueReporting", package: "swift-issue-reporting"),
      ]
    ),
    .target(
      name: "DomainUI",
      dependencies: [
        "Domain",
        .product(name: "AsyncAlgorithms", package: "swift-async-algorithms"),
        .product(name: "Vexil", package: "Vexil"),
        .product(name: "Vexillographer", package: "Vexil"),
      ]
    ),
    .target(
      name: "Services",
      dependencies: [
        "Domain",
        .product(name: "Vexil", package: "Vexil"),
      ]
    ),
  ],
  swiftLanguageModes: [
    .v6
  ]
)

// MARK: - Common build plugins

let buildPlugins: [Target.PluginUsage] = [
  .plugin(name: "Lint", package: "SwiftFormatPlugins")
]

// MARK: - Common Swift settings

var swiftSettings: [SwiftSetting] = [
  // Flags equivalent to enabling Approachable Concurrency in Xcode
  .enableUpcomingFeature("InferIsolatedConformances"),
  .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
  // Other flags that will one day be defaulted to ON.
  // These are trivial and mechanical to fix, but generate 1000s of issues
  .enableUpcomingFeature("ExistentialAny"),
  .enableUpcomingFeature("InternalImportsByDefault"),
  .enableUpcomingFeature("MemberImportVisibility"),
]

// MARK: - Apply plugins and settings

for target in package.targets where target.pluginCapability == nil {
  // Add plugins to every target
  var plugins = target.plugins ?? []
  plugins.append(contentsOf: buildPlugins)
  target.plugins = plugins

  // Add settings to every target
  var settings = target.swiftSettings ?? []
  settings.append(contentsOf: swiftSettings)
  target.swiftSettings = settings
}
