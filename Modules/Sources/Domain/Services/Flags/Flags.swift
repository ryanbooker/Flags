// The Swift Programming Language
// https://docs.swift.org/swift-book

public import Vexil

@FlagContainer public struct Flags {
  /// A hidden flag used to disable the shared UserDetails source globally.
  @Flag(description: "Whether to enable the experiemental feature set.", display: .hidden)
  public var enableExperimentalFeatures: Bool = false

  /// A hidden flag used to disable the shared UserDetails source globally.
  @Flag(description: "Whether to enable granular overrides for all feature flags.", display: .hidden)
  public var enableAdvancedOverrides: Bool = false

  @FlagGroup(description: "General app configuration.", display: .section)
  public var configuration: Configuration

  @FlagGroup(description: "Features", display: .section)
  public var features: Features
}

@FlagContainer public struct Configuration {
  @Flag(description: "Ignore previous in app purchases.")
  public var environment: AppEnvironment = .production

  @Flag(description: "The welcome greeting configuration value.")
  public var welcome: String = "Hello, World!"
}

public enum AppEnvironment: String, CaseIterable, FlagValue {
  case production = "Production"
  case staging = "Staging"
  case uat = "UAT"
}

@FlagContainer public struct Features {
  @Flag(description: "Enable new onboarding flow.")
  public var enableOnboardingUplift: Bool = false

  @Flag(description: "Enable new home screen.")
  public var enableHomeUplift: Bool = false

  @Flag(description: "Enable new category screen.")
  public var enableCatgeoryUplift: Bool = false

  @Flag(description: "Enable new channel screen.")
  public var enableChannelUplift: Bool = false
}
