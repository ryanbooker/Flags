// Copyright © 2025 Ryan Booker. All rights reserved.

public import Domain
import Foundation
public import Vexil

public extension FlagPole<Flags> {
  static var `default`: Self {
    .init(hoist: Flags.self, sources: [.config])
  }
}
