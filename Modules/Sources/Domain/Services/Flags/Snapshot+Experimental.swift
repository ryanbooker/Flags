// Copyright © 2025 Ryan Booker. All rights reserved.

import Foundation
public import Vexil

public extension Snapshot<Flags> {
  /// A pre canned set of features that will be enable/disabled as a group.
  static var experimental: Snapshot<Flags> {
    let flagPole = FlagPole<Flags>.null
    let snapshot = flagPole.emptySnapshot()
    do {
      try snapshot.setFlagValue("Hello, Experimental!", key: flagPole.configuration.$welcome.key)
      try snapshot.setFlagValue(true, key: flagPole.features.$enableHomeUplift.key)
      try snapshot.setFlagValue(true, key: flagPole.features.$enableCatgeoryUplift.key)
      try snapshot.setFlagValue(true, key: flagPole.features.$enableChannelUplift.key)
    } catch {
      print("Could not generate experiemental snapshot: \(error.localizedDescription)")
    }

    return snapshot
  }
}
