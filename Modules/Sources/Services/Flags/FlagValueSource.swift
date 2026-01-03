// Copyright © 2025 Ryan Booker. All rights reserved.

import Foundation
import Vexil

extension FlagValueSource where Self == FlagValueSourceCoordinator<UserDefaults> {
  static var config: Self {
    FlagValueSourceCoordinator(source: UserDefaults.config)
  }
}
