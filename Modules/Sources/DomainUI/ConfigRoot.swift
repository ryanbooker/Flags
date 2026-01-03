// Copyright © 2025 Ryan Booker. All rights reserved.

import AsyncAlgorithms
import Domain
public import SwiftUI
import Vexil
import Vexillographer

public struct ConfigRoot: View {
  @Environment(\.flagPole) private var flagPole
  @State private var isShowingRestoreDefaultsAlert: Bool = false
  @State private var restorationSnapshot: Snapshot<Flags>?
  @State private var experimentalSnapshot: Snapshot<Flags>?

  public var body: some View {
    if let overrides = flagPole._sources.first {
      NavigationView {
        Form {
          FlagControl(flagPole.$enableExperimentalFeatures) { configuration in
            Section {
              FlagToggle(configuration: configuration)
            } footer: {
              Text("When enabled, the current experiemental feature set is activated.")
            }
          }

          FlagControl(flagPole.$enableAdvancedOverrides) { configuration in
            Section {
              FlagToggle(configuration: configuration)
            } footer: {
              Text("When enabled, the settings below override the defaults used by the app.")
            }

            if configuration.value {
              NavigationLink("Advanced Overrides") {
                Vexillographer()
                  .toolbar {
                    Button(role: .destructive) {
                      isShowingRestoreDefaultsAlert = true
                    } label: {
                      Label("Restore Defaults", systemImage: "arrow.triangle.2.circlepath")
                    }
                    .tint(.red)
                  }
              }

              Section {
                Button(role: .destructive) {
                  isShowingRestoreDefaultsAlert = true
                } label: {
                  LabeledContent {
                    Image(systemName: "arrow.triangle.2.circlepath")
                      .foregroundStyle(.red)
                  } label: {
                    Text("Restore Defaults")
                  }
                }
              }
            }
          }
        }
        .navigationTitle("ABC Config")
        .navigationBarTitleDisplayMode(.inline)
      }
      .alert(
        "Are you sure you want to restore the default setting for all flags?",
        isPresented: $isShowingRestoreDefaultsAlert
      ) {
        Button(role: .cancel, action: {})
        Button("Restore Defaults", role: .destructive) {
          restoreDefaults(flagSource: overrides)
        }
      }
      .tint(.accentColor)
      .flagPole(flagPole, editableSource: overrides)
      .task {
        for await enable in flagPole.$enableExperimentalFeatures.removeDuplicates() {
          updateExperimentalFeatures(enable: enable)
        }
      }
      .task {
        for await enable in flagPole.$enableAdvancedOverrides.removeDuplicates() {
          updateAdvancedOverrides(flagSource: overrides, enable: enable)
        }
      }
    }
  }

  public init() {
    // Intentionally left emtpy
  }
}

private extension ConfigRoot {
  /// Experimental features a overrides that will force the applicable flags to the experimental feature values.
  func updateExperimentalFeatures(enable: Bool) {
    switch (experimentalSnapshot, enable) {
    case (let snapshot?, false):
      flagPole.remove(snapshot: snapshot)
      self.experimentalSnapshot = nil

    case (_, true):
      self.experimentalSnapshot = .experimental
      if let experimentalSnapshot {
        flagPole.append(snapshot: experimentalSnapshot)
      }

    case _:
      break
    }
  }

  func updateAdvancedOverrides(flagSource: some FlagValueSource, enable: Bool) {
    do {
      switch (restorationSnapshot, enable) {
      case (let snapshot?, true):
        // Reapply the previous snapshot
        snapshot.enableAdvancedOverrides = enable
        try flagPole.save(snapshot: snapshot, to: flagSource)
        self.restorationSnapshot = nil

      case (_, false):
        // Save a snapshot, and restore the default flag values
        self.restorationSnapshot = flagPole.snapshot(of: flagSource)
        try removeFlagValues(flagSource: flagSource)

      case _:
        break
      }
    } catch {
      print("Could not update overrides: \(error.localizedDescription)")
    }
  }

  func removeFlagValues(flagSource: some FlagValueSource) throws {
    let snapshot = flagPole.emptySnapshot()
    snapshot.enableAdvancedOverrides = flagPole.enableAdvancedOverrides
    updateExperimentalFeatures(enable: false)
    try flagPole.removeFlagValues(in: flagSource)
    try flagPole.save(snapshot: snapshot, to: flagSource)
  }

  func restoreDefaults(flagSource: some FlagValueSource) {
    do {
      try removeFlagValues(flagSource: flagSource)
    } catch {
      print("Could not reset overrides: \(error.localizedDescription)")
    }
  }
}
