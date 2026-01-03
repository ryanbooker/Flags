// Copyright © 2025 Ryan Booker. All rights reserved.

import Domain
import DomainUI
import Services
import SwiftUI

@main
struct ConfigApp: App {
  var body: some Scene {
    WindowGroup {
      ConfigRoot()
        .environment(\.flagPole, .default)
    }
  }
}
