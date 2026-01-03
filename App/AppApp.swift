// Copyright © 2025 Ryan Booker. All rights reserved.

import Domain
import DomainUI
import Services
import SwiftUI

@main struct AppApp: App {
  @Environment(\.appValidator) var appValidator

  var body: some Scene {
    WindowGroup {
      AppRoot()
        .environment(\.flagPole, .default)
        .task {
          await appValidator.refresh()
        }
    }
  }
}
