// Copyright © 2025 Ryan Booker. All rights reserved.

import StoreKit
public import SwiftUI

public actor AppValidator {
  static let shared = AppValidator()

  public var status: Status = .unknown

  public var shouldShouldInternalFeatures: Bool {
    isDevelopment || isTestFlight
  }

  public var isAppStore: Bool {
    status == .appStore
  }

  public var isDevelopment: Bool {
    status == .development
  }

  public var isTestFlight: Bool {
    status == .testFlight
  }

  public var isUnknown: Bool {
    status == .unknown
  }

  public func refresh() async {
    #if DEBUG
    status = .development
    #else
    do {
      let transaction = try await AppTransaction.shared.payloadValue
      status =
        switch transaction.environment {
        case .production: .appStore
        case .sandbox: .testFlight
        case .xcode: .development
        case _: .unknown
        }
    } catch {
      print("AppValidator refresh failed: \(error.localizedDescription)")
    }
    #endif
  }

  public enum Status {
    case appStore
    case development
    case testFlight
    case unknown
  }
}

public extension EnvironmentValues {
  @Entry var appValidator: AppValidator = .shared
}
