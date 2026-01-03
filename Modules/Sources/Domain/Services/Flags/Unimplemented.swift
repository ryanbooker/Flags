// Copyright © 2025 Ryan Booker. All rights reserved.

import IssueReporting
import Vexil

final class Unimplemented: FlagValueSource {
  typealias ChangeStream = AsyncStream<FlagChange>

  let flagValueSourceID = "Unimplemented"
  let flagValueSourceName = "Unimplemented"

  func flagValue<Value>(key: String) -> Value? where Value: FlagValue {
    unimplemented(
      "Using `null` FlagPole. Inject a real FlagPole using `.environment(\\.flagPole, ...)`.",
      placeholder: nil
    )
  }

  func setFlagValue(_ value: (some FlagValue)?, key: String) throws {
    unimplemented(
      "Using `null` FlagPole. Inject a real FlagPole using `.environment(\\.flagPole, ...)`."
    )
  }

  public func flagValueChanges(keyPathMapper: @Sendable @escaping (String) -> FlagKeyPath) -> ChangeStream {
    unimplemented(
      "Using `null` FlagPole. Inject a real FlagPole using `.environment(\\.flagPole, ...)`.",
      placeholder: AsyncStream { _ in
      }
    )
  }
}
