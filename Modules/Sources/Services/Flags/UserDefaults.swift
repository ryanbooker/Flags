// Copyright © 2025 Ryan Booker. All rights reserved.

import Foundation

extension UserDefaults {
  static var config: Self {
    // swift-format-ignore: NeverForceUnwrap
    .init(suiteName: "group.com.ryanbooker.App.Config")!
  }
}
