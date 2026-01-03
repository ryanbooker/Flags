// Copyright © 2025 Ryan Booker. All rights reserved.

import IssueReporting
public import SwiftUI
public import Vexil

extension FlagPole {
  static var null: FlagPole {
    .init(
      hoist: RootGroup.self,
      sources: [
        Unimplemented()
      ]
    )
  }
}

public extension EnvironmentValues {
  @Entry var flagPole: FlagPole<Flags> = .null
}
